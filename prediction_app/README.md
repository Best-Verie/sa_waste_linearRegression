# Waste Prediction App

A beautiful Flutter mobile application that predicts waste tonnage for South African provinces using machine learning. The app integrates with a FastAPI backend to provide accurate predictions based on facility data.

## Features

- 🏠 **Modern Home Screen** - Beautiful gradient design with easy navigation
- 📊 **Prediction Screen** - Input forms for waste data with real-time validation
- 🤖 **ML Integration** - Machine learning predictions via REST API
- 📱 **Responsive Design** - Works on both Android and iOS devices
- ℹ️ **About Screen** - Detailed information about the app and data sources
- 🎨 **Material Design 3** - Modern UI with smooth animations

## API Integration

The app connects to a FastAPI backend hosted at:
- **Endpoint**: `https://sa-waste-linearregression.onrender.com/predict`
- **Method**: POST
- **Input Parameters**:
  - `number_of_facilities` (float, >0)
  - `general_waste` (float, >=0) 
  - `hazardous_waste` (float, >=0)
  - `province_features` (array of 10 floats for one-hot encoding)

## Supported Provinces

- Eastern Cape, Free State, Gauteng, KwaZulu-Natal, Limpopo
- Mpumalanga, North West, Northern Cape, Western Cape

## Getting Started

### Prerequisites

- Flutter SDK (>=3.8.1)
- Dart SDK
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

## Dependencies

- `flutter`: Flutter SDK
- `http`: HTTP client for API calls
- `provider`: State management
- `material_design_icons_flutter`: Additional icons

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── prediction_model.dart # Data models
├── providers/
│   └── prediction_provider.dart # State management
├── screens/
│   ├── home_screen.dart      # Home page
│   ├── prediction_screen.dart # Prediction form
│   └── about_screen.dart     # About page
└── services/
    └── api_service.dart      # API integration
```

## Usage

1. **Launch the app** - Opens to a beautiful home screen
2. **Tap "Start Prediction"** - Navigate to the prediction form
3. **Enter facility data**: Number of facilities, waste amounts, select province
4. **Tap "Predict Waste Tonnage"** - Get machine learning powered prediction
5. **View results** - See predicted total waste tonnage
