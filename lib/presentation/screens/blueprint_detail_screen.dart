import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class BlueprintDetailScreen extends StatelessWidget {
  final String title;
  final String type;
  final String image;
  final List<String> heroes;

  const BlueprintDetailScreen({
    super.key,
    required this.title,
    required this.type,
    required this.image,
    required this.heroes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VantageColors.obsidian,
      body: CustomScrollView(
        slivers: [
          // Header con la imagen del mapa/composición
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: VantageColors.obsidian,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(image, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          VantageColors.obsidian.withOpacity(0.8),
                          VantageColors.obsidian,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título y Tipo
                  Text(
                    type,
                    style: const TextStyle(
                      color: VantageColors.vividCyan,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Sección de Héroes
                  const Text(
                    "COMPOSICIÓN DEL SQUAD",
                    style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: heroes.map((hero) => _buildHeroAvatar(hero)).toList(),
                  ),

                  const SizedBox(height: 32),

                  // Diagrama Táctico (Simulado)
                  const Text(
                    "DIAGRAMA DE EJECUCIÓN (MAPA: YGGSGARD)",
                    style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: VantageColors.surface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Stack(
                      children: [
                        Center(child: Icon(Icons.map, size: 100, color: Colors.white.withOpacity(0.05))),
                        // Rutas de ataque simuladas con iconos
                        const Positioned(top: 40, left: 40, child: Icon(Icons.near_me, color: VantageColors.neonMint, size: 30)),
                        const Positioned(top: 100, left: 120, child: Icon(Icons.radio_button_checked, color: Colors.redAccent, size: 20)),
                        const Positioned(
                          bottom: 20, 
                          right: 20, 
                          child: Text("OBJETIVO A", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white24))
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Fases de la Estrategia
                  const Text(
                    "FASES DE LA TÁCTICA",
                    style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildTacticPhase(1, "Infiltración", "Spider-Man busca el flanco izquierdo mientras el Vanguard distrae en el centro."),
                  _buildTacticPhase(2, "Engage", "Venom activa el Dive. Mantis prioriza la sanación del objetivo en foco."),
                  _buildTacticPhase(3, "Limpieza", "Eliminación de Strategists enemigos antes de capturar el punto."),

                  const SizedBox(height: 40),

                  // Botón para compartir con el equipo
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share, size: 18),
                      label: const Text("COMPARTIR CON TU SQUAD"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: VantageColors.electricViolet,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroAvatar(String name) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white10,
            radius: 24,
            child: Text(name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 6),
          Text(name, style: const TextStyle(fontSize: 8, color: Colors.white60, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTacticPhase(int number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: VantageColors.vividCyan.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Text(
              number.toString(),
              style: const TextStyle(color: VantageColors.vividCyan, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(color: Colors.white60, fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}