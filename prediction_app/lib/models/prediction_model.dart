class WastePredictionRequest {
  final double numberOfFacilities;
  final double generalWaste;
  final double hazardousWaste;
  final String province;

  WastePredictionRequest({
    required this.numberOfFacilities,
    required this.generalWaste,
    required this.hazardousWaste,
    required this.province,
  });

  Map<String, dynamic> toJson() {
    return {
      'numberOfFacilities': numberOfFacilities,
      'generalWaste': generalWaste,
      'hazardousWaste': hazardousWaste,
      'province': province,
    };
  }
}

class WastePredictionResult {
  final double predictedTonnage;
  final DateTime timestamp;

  WastePredictionResult({
    required this.predictedTonnage,
    required this.timestamp,
  });
}

enum PredictionStatus {
  idle,
  loading,
  success,
  error,
}
