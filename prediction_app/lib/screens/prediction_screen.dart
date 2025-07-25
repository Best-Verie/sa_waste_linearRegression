import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/prediction_provider.dart';
import '../models/prediction_model.dart';
import '../services/api_service.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _facilitiesController = TextEditingController();
  final _generalWasteController = TextEditingController();
  final _hazardousWasteController = TextEditingController();
  
  String? _selectedProvince;

  @override
  void dispose() {
    _facilitiesController.dispose();
    _generalWasteController.dispose();
    _hazardousWasteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Waste Prediction',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2E7D32),
              Color(0xFFF1F8E9),
            ],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: Consumer<WastePredictionProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Card(
                        elevation: 8,
                        shadowColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Enter Facility Data',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2E7D32),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                _buildTextField(
                                  controller: _facilitiesController,
                                  label: 'Number of Facilities',
                                  hint: 'Enter number of facilities',
                                  icon: Icons.business,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter number of facilities';
                                    }
                                    final number = double.tryParse(value);
                                    if (number == null || number <= 0) {
                                      return 'Please enter a valid positive number';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  controller: _generalWasteController,
                                  label: 'General Waste (tonnes)',
                                  hint: 'Enter general waste amount',
                                  icon: Icons.delete,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter general waste amount';
                                    }
                                    final number = double.tryParse(value);
                                    if (number == null || number < 0) {
                                      return 'Please enter a valid non-negative number';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  controller: _hazardousWasteController,
                                  label: 'Hazardous Waste (tonnes)',
                                  hint: 'Enter hazardous waste amount',
                                  icon: Icons.warning,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter hazardous waste amount';
                                    }
                                    final number = double.tryParse(value);
                                    if (number == null || number < 0) {
                                      return 'Please enter a valid non-negative number';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildProvinceDropdown(),
                                const SizedBox(height: 32),
                                if (provider.status == PredictionStatus.loading)
                                  const Center(
                                    child: Column(
                                      children: [
                                        CircularProgressIndicator(
                                          color: Color(0xFF2E7D32),
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          'Predicting waste tonnage...',
                                          style: TextStyle(
                                            color: Color(0xFF2E7D32),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                else if (provider.status == PredictionStatus.success)
                                  _buildResultCard(provider.result!)
                                else if (provider.status == PredictionStatus.error)
                                  _buildErrorCard(provider.errorMessage!),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: provider.status == PredictionStatus.loading
                            ? null
                            : _onPredictPressed,
                        icon: const Icon(Icons.analytics, color: Colors.white),
                        label: const Text(
                          'Predict Waste Tonnage',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          disabledBackgroundColor: Colors.grey,
                          elevation: 8,
                          shadowColor: const Color(0xFF2E7D32).withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF2E7D32)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2E7D32)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildProvinceDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedProvince,
      decoration: InputDecoration(
        labelText: 'Province',
        hintText: 'Select a province',
        prefixIcon: const Icon(Icons.location_on, color: Color(0xFF2E7D32)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2E7D32)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      items: ProvinceHelper.provinces.map((province) {
        return DropdownMenuItem<String>(
          value: province,
          child: Text(province),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedProvince = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a province';
        }
        return null;
      },
    );
  }

  Widget _buildResultCard(WastePredictionResult result) {
    return Card(
      color: const Color(0xFFE8F5E8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF4CAF50), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(
              Icons.check_circle,
              color: Color(0xFF2E7D32),
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'Predicted Total Waste Tonnage',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${result.predictedTonnage.toStringAsFixed(2)} tonnes',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Predicted on ${result.timestamp.day}/${result.timestamp.month}/${result.timestamp.year} at ${result.timestamp.hour}:${result.timestamp.minute.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard(String error) {
    return Card(
      color: const Color(0xFFFFF3E0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.orange, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.orange,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'Prediction Error',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              error,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _onPredictPressed() {
    if (_formKey.currentState!.validate() && _selectedProvince != null) {
      final request = WastePredictionRequest(
        numberOfFacilities: double.parse(_facilitiesController.text),
        generalWaste: double.parse(_generalWasteController.text),
        hazardousWaste: double.parse(_hazardousWasteController.text),
        province: _selectedProvince!,
      );

      context.read<WastePredictionProvider>().predictWaste(request);
    }
  }
}
