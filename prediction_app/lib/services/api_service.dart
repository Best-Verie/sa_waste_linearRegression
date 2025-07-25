import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class WasteApiService {
  // Use different URLs for web vs mobile to handle CORS
  static String get baseUrl {
    if (kIsWeb) {
      // For web development, you might need to use a proxy or ask backend to enable CORS
      return 'https://sa-waste-linearregression.onrender.com';
    } else {
      // Mobile/Desktop can access the API directly
      return 'https://sa-waste-linearregression.onrender.com';
    }
  }
  
  static Future<double> predictWaste({
    required double numberOfFacilities,
    required double generalWaste,
    required double hazardousWaste,
    required List<double> provinceFeatures,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/predict'),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
        },
        body: jsonEncode({
          'number_of_facilities': numberOfFacilities,
          'general_waste': generalWaste,
          'hazardous_waste': hazardousWaste,
          'province_features': provinceFeatures,
        }),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw Exception(
                'Request timeout - please check your internet connection',
              );
            },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('predicted_total_waste_tonnage')) {
          return data['predicted_total_waste_tonnage'].toDouble();
        } else {
          throw Exception('Invalid response format from API');
        }
      } else {
        throw Exception('API Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      if (e.toString().contains('XMLHttpRequest error')) {
        throw Exception(
          'CORS Error: The API does not allow requests from this domain. Please contact the API administrator to enable CORS for your Flutter web app.',
        );
      }
      throw Exception('Network Error: $e');
    }
  }
}

// Province mapping for UI
class ProvinceHelper {
  static const List<String> provinces = [
    'Eastern Cape', // Reference province (all zeros)
    'Free State',
    'Gauteng',
    'Kwa Zulu-Natal',
    'Kwazulu-Natal',
    'Limpopo',
    'Mpumalaga',
    'Mpumalanga',
    'North West',
    'Northern Cape',
    'Western Cape',
  ];
  
  static List<double> getProvinceFeatures(String provinceName) {
    // Create array of 10 zeros (11 provinces - 1 for drop_first)
    List<double> features = List.filled(10, 0.0);
    
    int index = provinces.indexOf(provinceName);
    if (index > 0) { // Skip Eastern Cape (index 0) as it's the reference
      features[index - 1] = 1.0;
    }
    
    return features;
  }
}
