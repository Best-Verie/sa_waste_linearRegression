import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.recycling,
                      size: 60,
                      color: Color(0xFF2E7D32),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Waste Prediction App',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Version 1.0',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Mission section
              _buildSimpleSection(
                'Mission',
                'To support better waste management through data-driven insights. This app helps predict waste generation across South Africa, optimizing waste reduction, reuse, recycling, and recovery activities for a more sustainable future.',
              ),
              
              const SizedBox(height: 24),
              
              // How it works section
              _buildSimpleSection(
                'How It Works',
                'Enter facility data including number of facilities, general waste, hazardous waste amounts, and select a province. The app calculates waste tonnage based on statistical models trained on South African waste data.',
              ),
              
              const SizedBox(height: 24),
              
              // Data source section
              _buildSimpleSection(
                'Data Source',
                'The calculations are based on South African waste management data spanning multiple years and provinces, ensuring reliable estimates.',
              ),
              
              const SizedBox(height: 24),
              
              // Provinces section
              const Text(
                'Supported Provinces',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 12),
              _buildSimpleProvinceList(),
              
              const SizedBox(height: 32),
              
              // Footer
              const Center(
                child: Text(
                  'Built by Best Verie Iradukunda',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleSection(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleProvinceList() {
    final provinces = [
      'Eastern Cape',
      'Free State', 
      'Gauteng',
      'KwaZulu-Natal',
      'Limpopo',
      'Mpumalanga',
      'North West',
      'Northern Cape',
      'Western Cape',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: provinces.map((province) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            '• $province',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        );
      }).toList(),
    );
  }
}
