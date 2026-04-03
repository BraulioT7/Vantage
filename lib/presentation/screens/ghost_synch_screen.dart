import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';


class GhostSyncScreen extends StatelessWidget {
  const GhostSyncScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VantageColors.obsidian,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // AppBar minimalista e integrada
          SliverAppBar(
            backgroundColor: VantageColors.obsidian,
            elevation: 0,
            pinned: true,
            centerTitle: true,
            title: const Text(
              "GHOST-SYNC ANALYSIS",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                fontSize: 14,
                letterSpacing: 1.2
              ),
            ),
          ),
         
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // 1. Cabecera de comparación visual simplificada para rendimiento
                _buildVisualComparisonHeader(),


                const SizedBox(height: 32),


                // 2. Sección de métricas
                const _SectionTitle(title: "MÉTRICAS DE IMPACTO"),
                const SizedBox(height: 16),
                _buildMetricsGrid(),


                const SizedBox(height: 32),


                // 3. Análisis de posicionamiento
                const _SectionTitle(title: "ANÁLISIS DE POSICIONAMIENTO"),
                const SizedBox(height: 16),
                _buildMiniMap(),


                const SizedBox(height: 20),
                const Text(
                  "INSIGHT: El 'Gamer Lean' detectado sugiere una exposición innecesaria al flanco derecho. El Pro Player utiliza la cobertura del pilar para reducir el daño recibido.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.5,
                    fontStyle: FontStyle.italic
                  ),
                ),


                const SizedBox(height: 40),


                // 4. Botón de acción principal
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: VantageColors.neonMint,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0, // Evitar sobrecarga de sombras
                    ),
                    child: const Text("REPETIR DRILL", style: TextStyle(fontWeight: FontWeight.w900)),
                  ),
                ),
               
                const SizedBox(height: 100), // Espacio para el scroll
              ]),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildVisualComparisonHeader() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: VantageColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              _buildComparisonPanel(
                label: "TU CLIP",
                color: Colors.redAccent,
                icon: Icons.person_outline,
                isLeft: true
              ),
              const VerticalDivider(width: 1, color: Colors.white10),
              _buildComparisonPanel(
                label: "PRO DATA",
                color: VantageColors.neonMint,
                icon: Icons.bolt,
                isLeft: false
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.sync, color: Colors.black, size: 20),
          ),
        ],
      ),
    );
  }


  Widget _buildComparisonPanel({required String label, required Color color, required IconData icon, required bool isLeft}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.03),
          borderRadius: isLeft
            ? const BorderRadius.horizontal(left: Radius.circular(24))
            : const BorderRadius.horizontal(right: Radius.circular(24)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color.withOpacity(0.5), size: 32),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: color.withOpacity(0.7))),
          ],
        ),
      ),
    );
  }


  Widget _buildMetricsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.5,
      children: [
        _MetricItem(label: "PRECISIÓN", value: "72%", color: VantageColors.neonMint),
        _MetricItem(label: "TIMING", value: "-0.12s", color: Colors.redAccent),
        _MetricItem(label: "POSICIÓN", value: "85%", color: VantageColors.vividCyan),
        _MetricItem(label: "EFICACIA", value: "A+", color: VantageColors.electricViolet),
      ],
    );
  }


  Widget _buildMiniMap() {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        color: VantageColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(Icons.grid_4x4, size: 100, color: Colors.white10),
          ),
          // Marcador PRO
          const Positioned(
            top: 60, left: 80,
            child: _MapMarker(label: "PRO", color: VantageColors.neonMint),
          ),
          // Marcador Usuario
          const Positioned(
            top: 130, left: 160,
            child: _MapMarker(label: "TÚ", color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}


class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white38, letterSpacing: 1.5),
    );
  }
}


class _MetricItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _MetricItem({required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: VantageColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 8, color: Colors.white38, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: color)),
        ],
      ),
    );
  }
}


class _MapMarker extends StatelessWidget {
  final String label;
  final Color color;
  const _MapMarker({required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.location_on, color: color, size: 24),
        Text(label, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
