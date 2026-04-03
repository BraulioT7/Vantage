import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/custom_cards.dart';
import 'drill_detail_screen.dart';
import 'blueprint_detail_screen.dart'; // Importación necesaria para la navegación

enum ExploreType { lab, blueprints }

class ExploreScreen extends StatelessWidget {
  final ExploreType type;
  final String title;
  final List<Map<String, dynamic>> items;

  const ExploreScreen({
    super.key,
    required this.type,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VantageColors.obsidian,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      // Pasamos el contexto a ambos constructores de grid para manejar la navegación
      body: type == ExploreType.lab ? _buildLabGrid(context) : _buildBlueprintGrid(context),
    );
  }

  Widget _buildLabGrid(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return LabCard(
          heroName: item["hero"],
          title: item["title"],
          duration: item["duration"],
          icon: item["icon"],
          accentColor: item["color"],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DrillDetailScreen(
                  title: item["title"],
                  heroName: item["hero"],
                  steps: item["steps"],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBlueprintGrid(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // En la vista completa, las blueprints se ven mejor a ancho completo
        mainAxisSpacing: 20,
        childAspectRatio: 1.6,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return BlueprintCard(
          image: item["image"],
          type: item["type"],
          title: item["title"],
          heroes: List<String>.from(item["heroes"]),
          // Implementación del onTap para navegar al detalle de la táctica
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlueprintDetailScreen(
                  title: item["title"],
                  type: item["type"],
                  image: item["image"],
                  heroes: List<String>.from(item["heroes"]),
                ),
              ),
            );
          },
        );
      },
    );
  }
}