import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'ghost_sync_step_screen.dart';

class GhostSyncHubScreen extends StatelessWidget {
  const GhostSyncHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VantageColors.obsidian,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // AppBar con estilo técnico
          const SliverAppBar(
            floating: true,
            backgroundColor: VantageColors.obsidian,
            elevation: 0,
            title: Text(
              "GHOST-SYNC ENGINE",
              style: TextStyle(
                fontWeight: FontWeight.w900, 
                fontStyle: FontStyle.italic, 
                fontSize: 16,
                letterSpacing: 1.2
              ),
            ),
            centerTitle: true,
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tarjeta principal de subida (Scanner AI)
                  _buildUploadSection(context),

                  const SizedBox(height: 36),

                  // Biblioteca Pro
                  const _SectionHeader(title: "BIBLIOTECA DE FANTASMAS PRO"),
                  const SizedBox(height: 16),
                  _buildProVault(context),

                  const SizedBox(height: 36),

                  // Historial de Análisis
                  const _SectionHeader(title: "ÚLTIMOS ANÁLISIS REALIZADOS"),
                  const SizedBox(height: 16),
                  _buildAnalysisHistory(context),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildUploadSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: VantageColors.neonMint.withOpacity(0.03),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: VantageColors.neonMint.withOpacity(0.15)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [VantageColors.neonMint.withOpacity(0.05), Colors.transparent],
        ),
      ),
      child: Column(
        children: [
          // Icono con efecto de pulso
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  color: VantageColors.neonMint.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
              const Icon(Icons.document_scanner_outlined, color: VantageColors.neonMint, size: 36),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            "ANALIZAR NUEVO CLIP",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 8),
          const Text(
            "Sube un video de tu jugada para detectar errores de timing y posición mediante visión artificial.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 28),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 18),
            label: const Text("SELECCIONAR DE GALERÍA"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProVault(BuildContext context) {
    final proGhosts = [
      {"hero": "Spiderman", "player": "SpideyGod_99", "skill": "Web-Swing Inertia", "target": "Momento de Inercia", "color": VantageColors.neonMint},
      {"hero": "Venom", "player": "SymbioteX", "skill": "Dive Impact", "target": "Precisión de Impacto", "color": VantageColors.vividCyan},
      {"hero": "Hela", "player": "QueenOfHel", "skill": "Dagger Cancel", "target": "Frame de Cancelación", "color": VantageColors.electricViolet},
    ];

    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: proGhosts.length,
        itemBuilder: (context, index) {
          final ghost = proGhosts[index];
          final Color color = ghost["color"] as Color;
          
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GhostSyncStepScreen(
                    stepNumber: 1,
                    targetMetric: ghost["target"].toString(),
                    coachAdvice: "Comparando tu ejecución con el fantasma de ${ghost["player"]}.",
                  ),
                ),
              );
            },
            child: Container(
              width: 170,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: VantageColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ghost["hero"].toString().toUpperCase(),
                    style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                  ),
                  Text(ghost["skill"].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.verified, size: 10, color: Colors.white24),
                      const SizedBox(width: 4),
                      Text(ghost["player"].toString(), style: const TextStyle(color: Colors.white24, fontSize: 9, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnalysisHistory(BuildContext context) {
    return Column(
      children: [
        _buildHistoryItem(context, "Hela", "Animation Cancel #4", "92%", VantageColors.neonMint),
        _buildHistoryItem(context, "Spiderman", "Momentum Test", "74%", VantageColors.warningAmber),
        _buildHistoryItem(context, "Venom", "Dive Precision", "ERR", Colors.redAccent),
      ],
    );
  }

  Widget _buildHistoryItem(BuildContext context, String hero, String title, String score, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: VantageColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.analytics_outlined, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(hero.toUpperCase(), style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(score, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 16, fontFamily: 'Monospace')),
              const Text("ACCURACY", style: TextStyle(color: Colors.white24, fontSize: 8, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: Colors.white24),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GhostSyncStepScreen(
                    stepNumber: 1,
                    targetMetric: "Timing de Input",
                    coachAdvice: "Analizando $title de $hero...",
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5),
    );
  }
}