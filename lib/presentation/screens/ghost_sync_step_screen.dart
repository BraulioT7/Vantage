import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';


class GhostSyncStepScreen extends StatelessWidget {
  final int stepNumber;
  final String targetMetric;
  final String coachAdvice; // Campo dinámico recibido


  const GhostSyncStepScreen({
    super.key,
    required this.stepNumber,
    required this.targetMetric,
    required this.coachAdvice,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VantageColors.obsidian,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("ANÁLISIS PASO $stepNumber", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("COMPARATIVA DE EJECUCIÓN", style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
            const SizedBox(height: 16),
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: VantageColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Container(color: Colors.white.withOpacity(0.02), child: const Center(child: Text("TU GHOST", style: TextStyle(fontSize: 10, color: Colors.white24))))),
                        const VerticalDivider(width: 1, color: Colors.white10),
                        Expanded(child: Container(color: VantageColors.neonMint.withOpacity(0.02), child: const Center(child: Text("PRO GHOST", style: TextStyle(fontSize: 10, color: VantageColors.neonMint))))),
                      ],
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.white10)),
                        child: Text("OBJETIVO: $targetMetric", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: VantageColors.neonMint)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text("MÉTRICAS DEL MOVIMIENTO", style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
            const SizedBox(height: 16),
            _buildMetricRow("Timing de Input", "94%", VantageColors.neonMint),
            _buildMetricRow("Ángulo de Cámara", "82%", VantageColors.vividCyan),
            _buildMetricRow("Frame Cancel", "ERR", Colors.redAccent),
            const Spacer(),
           
            // CONSEJO DINÁMICO DEL COACH
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("CONSEJO DEL COACH", style: TextStyle(color: VantageColors.neonMint, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 8),
                  Text(
                    coachAdvice,
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13, fontStyle: FontStyle.italic, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                child: const Text("REINTENTAR PASO"),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildMetricRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Monospace')),
        ],
      ),
    );
  }
}
