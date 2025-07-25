import 'package:flutter/material.dart';
import 'prediction_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2E7D32),
              Color(0xFF4CAF50),
              Color(0xFF81C784),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.recycling,
                        size: 120,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Waste Prediction',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Predict waste tonnage for South African provinces',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(
                          context,
                          'Start Prediction',
                          Icons.analytics,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PredictionScreen(),
                            ),
                          ),
                          isPrimary: true,
                        ),
                        _buildActionButton(
                          context,
                          'About This App',
                          Icons.info_outline,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutScreen(),
                            ),
                          ),
                          isPrimary: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onPressed, {
    required bool isPrimary,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: isPrimary ? Colors.white : const Color(0xFF2E7D32),
        ),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isPrimary ? Colors.white : const Color(0xFF2E7D32),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? const Color(0xFF2E7D32) : Colors.white,
          foregroundColor: isPrimary ? Colors.white : const Color(0xFF2E7D32),
          elevation: isPrimary ? 8 : 2,
          shadowColor: isPrimary ? const Color(0xFF2E7D32).withOpacity(0.3) : Colors.grey.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isPrimary ? BorderSide.none : const BorderSide(color: Color(0xFF2E7D32)),
          ),
        ),
      ),
    );
  }
}
