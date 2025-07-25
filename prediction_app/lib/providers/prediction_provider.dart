import 'package:flutter/foundation.dart';
import '../models/prediction_model.dart';
import '../services/api_service.dart';

class WastePredictionProvider extends ChangeNotifier {
  PredictionStatus _status = PredictionStatus.idle;
  WastePredictionResult? _result;
  String? _errorMessage;

  PredictionStatus get status => _status;
  WastePredictionResult? get result => _result;
  String? get errorMessage => _errorMessage;

  Future<void> predictWaste(WastePredictionRequest request) async {
    _status = PredictionStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final provinceFeatures = ProvinceHelper.getProvinceFeatures(request.province);
      
      final prediction = await WasteApiService.predictWaste(
        numberOfFacilities: request.numberOfFacilities,
        generalWaste: request.generalWaste,
        hazardousWaste: request.hazardousWaste,
        provinceFeatures: provinceFeatures,
      );

      _result = WastePredictionResult(
        predictedTonnage: prediction,
        timestamp: DateTime.now(),
      );
      _status = PredictionStatus.success;
    } catch (e) {
      _errorMessage = e.toString();
      _status = PredictionStatus.error;
    }

    notifyListeners();
  }

  void clearResult() {
    _status = PredictionStatus.idle;
    _result = null;
    _errorMessage = null;
    notifyListeners();
  }
}
