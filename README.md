# SA Waste Linear Regression - Waste Prediction App

## Mission & Problem Statement

This project addresses the critical need for accurate waste management predictions in South Africa through data-driven insights. 
The application leverages machine learning to predict waste tonnage across South African provinces, enabling better resource allocation and waste management strategies.
By providing reliable waste generation forecasts, it supports sustainable waste reduction, reuse, recycling, and recovery activities.
The solution bridges the gap between waste data and actionable insights for environmental sustainability.

## Features

- 🏠 **Modern Home Screen** - Beautiful gradient design with easy navigation
- 📊 **Prediction Screen** - Input forms for waste data with real-time validation
- 🤖 **ML Integration** - Machine learning predictions via REST API
- 📱 **Responsive Design** - Works on both Android and iOS devices
- ℹ️ **About Screen** - Detailed information about the app and data sources
- 🎨 **Material Design 3** - Modern UI with smooth animations

## API Integration

The app connects to a publicly available FastAPI backend:

### Public API Endpoint
- **Base URL**: `https://sa-waste-linearregression.onrender.com`
- **Prediction Endpoint**: `https://sa-waste-linearregression.onrender.com/predict`
- **Swagger UI Documentation**: `https://sa-waste-linearregression.onrender.com/docs`
- **Method**: POST
- **Content-Type**: application/json

### Input Parameters
```json
{
  "number_of_facilities": 10,
  "general_waste": 500,
  "hazardous_waste": 50,
  "province_features": [0, 0, 1, 0, 0, 0, 0, 0, 0, 0]
}
```

### Response Format
```json
{
  "predicted_total_waste_tonnage": 1250.75
}
```

**Test the API**: Visit the Swagger UI at `https://sa-waste-linearregression.onrender.com/docs` to interact with the API directly.

## Video Demo

🎥 **YouTube Demo**: [Watch the 5-minute app demo](https://youtu.be/YOUR_VIDEO_ID_HERE)

*Note: Replace YOUR_VIDEO_ID_HERE with your actual YouTube video ID*

## Supported Provinces

- Eastern Cape, Free State, Gauteng, KwaZulu-Natal, Limpopo
- Mpumalanga, North West, Northern Cape, Western Cape

## How to Run the Mobile App

### Prerequisites
- **Flutter SDK**: Version 3.8.1 or higher ([Install Flutter](https://docs.flutter.dev/get-started/install))
- **Dart SDK**: Included with Flutter
- **IDE**: Android Studio, VS Code, or IntelliJ IDEA with Flutter plugins
- **Device**: Android/iOS device or emulator

### Step-by-Step Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/SA_Waste_LinearRegression.git
   cd SA_Waste_LinearRegression/prediction_app
   ```

2. **Install Flutter dependencies**:
   ```bash
   flutter pub get
   ```

3. **Verify Flutter installation**:
   ```bash
   flutter doctor
   ```
   Fix any issues reported by Flutter Doctor.

4. **Connect your device or start an emulator**:
   - **Android**: Connect via USB with Developer Options enabled, or start Android emulator
   - **iOS**: Connect iPhone/iPad or start iOS Simulator (macOS only)

5. **Run the application**:
   ```bash
   flutter run
   ```
   
   Or for specific platforms:
   ```bash
   flutter run -d android    # For Android
   flutter run -d ios        # For iOS
   ```

6. **Build for release** (optional):
   ```bash
   flutter build apk         # Android APK
   flutter build ios         # iOS (macOS only)
   ```

### Troubleshooting
- Ensure your device has **Developer Options** and **USB Debugging** enabled (Android)
- For iOS, ensure you have **Xcode** installed and device is trusted
- Run `flutter clean` followed by `flutter pub get` if you encounter dependency issues

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
