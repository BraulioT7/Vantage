import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  String _activeFilter = "TODOS";
  
  // Lista de posts iniciales
  final List<Map<String, dynamic>> _allPosts = [
    {
      "id": "1",
      "user": "Vortex_Pro",
      "hero": "Peni Parker",
      "title": "Hidden Web-Trap Loop",
      "description": "Nueva mecánica de trampas infinitas descubierta en el punto B de Yggsgard.",
      "likes": 1240,
      "isLiked": false,
      "type": "MECÁNICA",
      "tag": "TOP TÉCNICAS",
      "color": VantageColors.electricViolet,
      "imageUrl": "https://images.unsplash.com/photo-1614017414570-1917533bb460?q=80&w=800",
      "steps": ["Coloca la trampa detrás del pilar.", "Espera al Dash.", "Activa tether frame 14."]
    },
    {
      "id": "2",
      "user": "RivalsTactician",
      "hero": "Black Panther",
      "title": "Vibranium Dive Route",
      "description": "Ruta de flanqueo optimizada para evitar proyectiles de Iron Man.",
      "likes": 850,
      "isLiked": true,
      "type": "TÁCTICA",
      "tag": "SQUAD BUILDS",
      "color": VantageColors.vividCyan,
      "imageUrl": "https://images.unsplash.com/photo-1624138784181-dc7f5b75e52e?q=80&w=800",
      "steps": ["Muro derecho.", "Doble salto cornisa.", "Ataque cargado."]
    }
  ];

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> filteredPosts = _activeFilter == "TODOS" 
        ? _allPosts 
        : _allPosts.where((p) => p["tag"] == _activeFilter).toList();

    return Scaffold(
      backgroundColor: VantageColors.obsidian,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverAppBar(
            floating: true,
            backgroundColor: VantageColors.obsidian,
            elevation: 0,
            title: Text("COMMUNITY HUB", style: TextStyle(fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, fontSize: 16)),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
                  _buildFilterChip("TODOS"),
                  _buildFilterChip("TOP TÉCNICAS"),
                  _buildFilterChip("SQUAD BUILDS"),
                  _buildFilterChip("CLIPS GHOST-SYNC"),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _CommunityCard(
                  post: filteredPosts[index],
                  onLike: () => setState(() => filteredPosts[index]["isLiked"] = !filteredPosts[index]["isLiked"]),
                  onTap: () => _navigateToDetail(filteredPosts[index]),
                ),
                childCount: filteredPosts.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreatePostModal,
        backgroundColor: VantageColors.neonMint,
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text("SUBIR HALLAZGO", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final bool isSelected = _activeFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _activeFilter = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: isSelected ? VantageColors.neonMint : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(color: isSelected ? Colors.black : Colors.white60, fontSize: 10, fontWeight: FontWeight.w900)),
      ),
    );
  }

  void _navigateToDetail(Map<String, dynamic> post) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => _PostDetailScreen(post: post)));
  }

  void _showCreatePostModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: VantageColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => const _CreatePostForm(),
    );
  }
}

/// Formulario Dinámico de Creación
class _CreatePostForm extends StatefulWidget {
  const _CreatePostForm();

  @override
  State<_CreatePostForm> createState() => _CreatePostFormState();
}

class _CreatePostFormState extends State<_CreatePostForm> {
  String _selectedType = "MECÁNICA";
  final List<String> _steps = [""]; // Inicia con un paso vacío

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 32, left: 24, right: 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("COMPARTIR CON LA COMUNIDAD", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
            const SizedBox(height: 24),
            
            // Selector de Tipo
            const Text("TIPO DE CONTENIDO", style: TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildTypeBadge("MECÁNICA", VantageColors.electricViolet),
                const SizedBox(width: 8),
                _buildTypeBadge("SQUAD", VantageColors.vividCyan),
                const SizedBox(width: 8),
                _buildTypeBadge("GHOST", VantageColors.neonMint),
              ],
            ),

            const SizedBox(height: 24),
            _buildInputField("TÍTULO DEL HALLAZGO", "Ej: Dash Cancel con Magik"),
            const SizedBox(height: 16),
            _buildInputField("DESCRIPCIÓN BREVE", "Explica el impacto en el meta...", maxLines: 2),

            const SizedBox(height: 24),
            
            // Sección Dinámica de Pasos (Estilo Lab)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("GUÍA PASO A PASO", style: TextStyle(fontSize: 10, color: Colors.white38, fontWeight: FontWeight.bold)),
                if (_selectedType != "SQUAD")
                  GestureDetector(
                    onTap: () => setState(() => _steps.add("")),
                    child: const Text("+ AÑADIR PASO", style: TextStyle(fontSize: 10, color: VantageColors.neonMint, fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            
            if (_selectedType == "SQUAD")
               _buildInputField("COMPOSICIÓN SUGERIDA", "Ej: Venom, Spider-Man, Mantis...")
            else
              ...List.generate(_steps.length, (index) => _buildStepInput(index)),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: VantageColors.neonMint, foregroundColor: Colors.black),
                child: const Text("PUBLICAR"),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeBadge(String label, Color color) {
    bool isSelected = _selectedType == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? color : Colors.transparent),
        ),
        child: Text(label, style: TextStyle(color: isSelected ? color : Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildStepInput(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 24, height: 24,
            decoration: const BoxDecoration(color: Colors.white10, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text("${index + 1}", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                hintText: "Describe la acción...",
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: Colors.white.withOpacity(0.02),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
          if (index > 0)
            IconButton(
              icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent, size: 20),
              onPressed: () => setState(() => _steps.removeAt(index)),
            )
        ],
      ),
    );
  }

  Widget _buildInputField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
            filled: true,
            fillColor: Colors.white.withOpacity(0.03),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}

class _CommunityCard extends StatelessWidget {
  final Map<String, dynamic> post;
  final VoidCallback onLike;
  final VoidCallback onTap;

  const _CommunityCard({required this.post, required this.onLike, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: VantageColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 14, backgroundColor: post["color"].withOpacity(0.1), child: Text(post["user"][0], style: TextStyle(color: post["color"], fontWeight: FontWeight.bold, fontSize: 10))),
                  const SizedBox(width: 10),
                  Text(post["user"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white70)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(6), border: Border.all(color: post["color"].withOpacity(0.3))),
                child: Text(post["type"], style: TextStyle(color: post["color"], fontSize: 8, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(post["hero"].toUpperCase(), style: TextStyle(color: post["color"], fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 1.5)),
          const SizedBox(height: 6),
          Text(post["title"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontStyle: FontStyle.italic)),
          const SizedBox(height: 8),
          Text(post["description"], style: const TextStyle(color: Colors.white54, fontSize: 13, height: 1.4)),
          const SizedBox(height: 24),
          Row(
            children: [
              IconButton(onPressed: onLike, icon: Icon(post["isLiked"] ? Icons.thumb_up : Icons.thumb_up_off_alt, color: post["isLiked"] ? VantageColors.neonMint : Colors.white24, size: 20)),
              Text(post["likes"].toString(), style: const TextStyle(color: Colors.white24, fontSize: 12, fontWeight: FontWeight.bold)),
              const Spacer(),
              TextButton(onPressed: onTap, child: const Text("VER DETALLE", style: TextStyle(color: VantageColors.neonMint, fontWeight: FontWeight.w900, fontSize: 11))),
            ],
          )
        ],
      ),
    );
  }
}

class _PostDetailScreen extends StatelessWidget {
  final Map<String, dynamic> post;
  const _PostDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VantageColors.obsidian,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: VantageColors.obsidian,
            leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(post["imageUrl"], fit: BoxFit.cover),
                  Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, VantageColors.obsidian.withOpacity(0.8), VantageColors.obsidian]))),
                  const Center(child: Icon(Icons.play_circle_fill, color: Colors.white, size: 64)),
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
                  Text(post["type"], style: TextStyle(color: post["color"], fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 2)),
                  const SizedBox(height: 8),
                  Text(post["title"], style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
                  const SizedBox(height: 16),
                  Text(post["description"], style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.5)),
                  const SizedBox(height: 32),
                  const Text("GUÍA DE EJECUCIÓN", style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 16),
                  ...List.generate(post["steps"].length, (i) => _buildStepTile(i + 1, post["steps"][i], post["color"])),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStepTile(int number, String text, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.03), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(width: 24, height: 24, decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle), alignment: Alignment.center, child: Text(number.toString(), style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12))),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 13))),
        ],
      ),
    );
  }
}