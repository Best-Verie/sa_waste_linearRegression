from fastapi import FastAPI
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware
import joblib
import numpy as np

app = FastAPI(title="Waste Prediction API")

# Load saved model and scaler
model = joblib.load("best_model.pkl")
scaler = joblib.load("scaler.pkl")

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Define Pydantic model for input
class WasteInput(BaseModel):
    number_of_facilities: float = Field(..., gt=0)
    general_waste: float = Field(..., ge=0)
    hazardous_waste: float = Field(..., ge=0)
    province_features: list[float] = Field(..., min_items=10, max_items=10)  # 11 unique provinces - 1 (drop_first) = 10 features

@app.post("/predict")
def predict_waste(data: WasteInput):
    input_data = [data.number_of_facilities, data.general_waste, data.hazardous_waste] + data.province_features
    input_scaled = scaler.transform([input_data])
    prediction = model.predict(input_scaled)
    return {"predicted_total_waste_tonnage": float(prediction[0])}
