import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/custom_cards.dart';
import 'drill_detail_screen.dart';
import 'explore_screen.dart';
import 'blueprint_detail_screen.dart';
import 'community_screen.dart';
import 'ghost_sync_hub_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Control de la pestaña activa (LAB, COMUNIDAD, GHOST, ME)

  // Lista de pantallas para la navegación por pestañas
  final List<Widget> _screens = [
    const _LabFeedContent(), // Pestaña 0: LAB (Contenido principal)
    const CommunityScreen(), // Pestaña 1: COMUNIDAD
    const GhostSyncHubScreen(), // Pestaña 2: GHOST
    const ProfileScreen(), // Pestaña 3: ME (Placeholder)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05), width: 1)),
        ),
        child: BottomNavigationBar(
          backgroundColor: VantageColors.obsidian,
          selectedItemColor: VantageColors.neonMint,
          unselectedItemColor: Colors.white24,
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.science_outlined), 
              activeIcon: Icon(Icons.science), 
              label: "LAB"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline), 
              activeIcon: Icon(Icons.people), 
              label: "COMUNIDAD"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.visibility_outlined), 
              activeIcon: Icon(Icons.visibility), 
              label: "GHOST"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), 
              activeIcon: Icon(Icons.person), 
              label: "YO"
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget interno que contiene todo el scroll view del LAB (Home Content)
class _LabFeedContent extends StatefulWidget {
  const _LabFeedContent();

  @override
  State<_LabFeedContent> createState() => _LabFeedContentState();
}

class _LabFeedContentState extends State<_LabFeedContent> {
  final PageController _heroController = PageController();
  String _selectedRole = "DIVE VANGUARD";
  String _selectedInput = "MNK";

  // --- BASE DE DATOS LOCAL SIMULADA ---
  
  final Map<String, List<Map<String, dynamic>>> _roleContent = {
    "DIVE VANGUARD": [
      {
        "hero": "Venom",
        "title": "Symbiotic Dive & Focus",
        "duration": "5:20",
        "icon": Icons.blur_on,
        "color": VantageColors.vividCyan,
        "steps": [
          DrillStep(text: "Lanza 'Venom Swing' para ganar altura.", videoUrl: "https://images.unsplash.com/photo-1612036782180-6f0b6cd846fe?q=80&w=800", ghostTarget: "Ángulo de Péndulo", coachAdvice: "Apunta a la cornisa más alta."),
          DrillStep(text: "Impacta con 'Symbiotic Burst'.", videoUrl: "https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=800", ghostTarget: "Precisión", coachAdvice: "Espera a tocar el suelo."),
          DrillStep(text: "Activa 'Symbiotic Bond'.", videoUrl: "https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?q=80&w=800", ghostTarget: "Mitigación", coachAdvice: "Úsalo ante proyectiles pesados."),
        ]
      },
      {
        "hero": "Spider-Man",
        "title": "Web-Swing Velocity",
        "duration": "6:15",
        "icon": Icons.speed,
        "color": VantageColors.neonMint,
        "steps": [
          DrillStep(text: "Salto de inercia inicial.", videoUrl: "https://images.unsplash.com/photo-1509198397868-475647b2a1e5?q=80&w=800", ghostTarget: "Altura", coachAdvice: "Necesitas buena altura."),
          DrillStep(text: "Lanzamiento a 45°.", videoUrl: "https://images.unsplash.com/photo-1608889175123-8ee362201f81?q=80&w=800", ghostTarget: "Ángulo", coachAdvice: "Debes estár en el punto más alto del salto."),
          DrillStep(text: "Cancelamiento de animación.", videoUrl: "https://images.unsplash.com/photo-1509198397868-475647b2a1e5?q=80&w=800", ghostTarget: "Velocidad de reacción", coachAdvice: "Espera a que tengas buena velocidad antes de cancelar la animación."),
          DrillStep(text: "Salto de inercia final.", videoUrl: "https://images.unsplash.com/photo-1608889175123-8ee362201f81?q=80&w=800", ghostTarget: "Tiempo", coachAdvice: "Apenas tocar el piso, salta."),
        ]
      },
    ],
    "HITSCAN DUELIST": [
      {
        "hero": "Hela",
        "title": "Ataque rápido",
        "duration": "4:30",
        "icon": Icons.bolt,
        "color": VantageColors.neonMint,
        "steps": [
          DrillStep(text: "Lanza 'Nightsword'.", videoUrl: "https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=800", ghostTarget: "Precisión", coachAdvice: "Apunta al pecho."),
          DrillStep(text: "Cancelación 'Soul Infusion'.", videoUrl: "https://images.unsplash.com/photo-1614017414570-1917533bb460?q=80&w=800", ghostTarget: "Tiempo", coachAdvice: "La señal es el brillo verde."),
        ]
      },
    ],
    "MAIN TANK": [
      {
        "hero": "Dr. Strange",
        "title": "Ataque rápido",
        "duration": "8:10",
        "icon": Icons.shield,
        "color": VantageColors.vividCyan,
        "steps": [
          DrillStep(text: "Realiza un ataque básico", videoUrl: "https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?q=80&w=800", ghostTarget: "Punteria", coachAdvice: "Intenta no fallar, esto ayuda a un combo."),
          DrillStep(text: "Realiza un ataque cuerpo a cuerpo", videoUrl: "https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?q=80&w=800", ghostTarget: "Tiempo", coachAdvice: "Apenas hagas el primer paso, presiona el ataque cuerpo a cuerpo."),
          DrillStep(text: "Usa 'Shield'", videoUrl: "https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?q=80&w=800", ghostTarget: "Tiempo", coachAdvice: "Apenas empiece el ataque cuerpo a cuerpo, usa la habilidad del escudo."),
        ]
      },
    ],
    "MAIN STRATEGIST": [
      {
        "hero": "Luna Snow",
        "title": "¡Congelado!",
        "duration": "6:45",
        "icon": Icons.music_note,
        "color": VantageColors.electricViolet,
        "steps": [
          DrillStep(text: "Bola de nieve.", videoUrl: "https://images.unsplash.com/photo-1614613535308-eb5fbd3d2c17?q=80&w=800", ghostTarget: "Predicción", coachAdvice: "No apuntes al objetivo, intenta predecir su trayectoria."),
        ]
      },
    ],
  };

  final List<Map<String, dynamic>> _allBlueprints = [
    {
      "image": "https://images.unsplash.com/photo-1624138784181-dc7f5b75e52e?q=80&w=500",
      "type": "DIVE COMP",
      "title": "Arácnidos al Acecho",
      "heroes": ["Spider-Man", "Venom", "Mantis"],
    },
    {
      "image": "https://images.unsplash.com/photo-1635322966219-b75ed372eb01?q=80&w=500",
      "type": "RUSH COMP",
      "title": "Fuerza Bruta de Wakanda",
      "heroes": ["Black Panther", "Hulk", "Ultron"],
    },
    {
      "image": "https://images.unsplash.com/photo-1542751110-97427bbecf20?q=80&w=500",
      "type": "POKE COMP",
      "title": "La tercia de Asgard",
      "heroes": ["Hela", "Thor", "Loki"],
    },
  ];

  final List<DrillStep> _thorDrills = [
    DrillStep(text: "Carga Mjolnir post-nerf.", videoUrl: "https://images.unsplash.com/photo-1612036782180-6f0b6cd846fe?q=80&w=800", ghostTarget: "Carga", coachAdvice: "El área es menor, busca el centro."),
  ];

  // --- LÓGICA DE INTERACCIÓN ---

  void _showInputSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: VantageColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("CONFIGURACIÓN DE INPUT", style: TextStyle(fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, fontSize: 18)),
            const SizedBox(height: 20),
            _buildInputOption("MNK"),
            _buildInputOption("CONTROLLER (XBOX)"),
            _buildInputOption("CONTROLLER (PS5)"),
          ],
        ),
      ),
    );
  }

  Widget _buildInputOption(String input) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(input, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
      trailing: _selectedInput == input ? const Icon(Icons.check_circle, color: VantageColors.neonMint) : null,
      onTap: () {
        setState(() => _selectedInput = input);
        Navigator.pop(context);
      },
    );
  }

  void _showRoleSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: VantageColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("SELECCIONA TU ROL", style: TextStyle(fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, fontSize: 18)),
            const SizedBox(height: 20),
            ..._roleContent.keys.map((role) => _buildRoleOption(role)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleOption(String role) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(role, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 14)),
      trailing: _selectedRole == role ? const Icon(Icons.check_circle, color: VantageColors.vividCyan) : null,
      onTap: () {
        setState(() => _selectedRole = role);
        Navigator.pop(context);
      },
    );
  }

  void _navigateToDrill(BuildContext context, String title, String hero, List<DrillStep> steps) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DrillDetailScreen(title: title, heroName: hero, steps: steps)));
  }

  void _navigateToBlueprint(BuildContext context, Map<String, dynamic> blueprint) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => BlueprintDetailScreen(title: blueprint["title"], type: blueprint["type"], image: blueprint["image"], heroes: List<String>.from(blueprint["heroes"]))));
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> currentFeed = _roleContent[_selectedRole] ?? [];

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. CAROUSEL HERO
          SliverAppBar(
            expandedHeight: 440.0,
            pinned: true,
            backgroundColor: VantageColors.obsidian,
            flexibleSpace: FlexibleSpaceBar(
              background: PageView(
                controller: _heroController,
                children: [
                  HeroCarouselItem(
                    label: "CALENTAMIENTO",
                    title: "RUTINA DE REFLEJOS:\nDUELIST WARMUP",
                    subtitle: "Preparación de 5 min para Hela.",
                    imageUrl: "https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=800",
                    labelColor: VantageColors.neonMint,
                    onTap: () => _navigateToDrill(context, "Calentamiento de duelista", "Hela", _roleContent["HITSCAN DUELIST"]![0]["steps"]),
                  ),
                  HeroCarouselItem(
                    label: "DESCUBRIMIENTO",
                    title: "PENI PARKER:\nHIDDEN WEB TECH",
                    subtitle: "Nueva ubicación de trampas descubierta en Yggsgard.",
                    imageUrl: "https://images.unsplash.com/photo-1614017414570-1917533bb460?q=80&w=800",
                    labelColor: VantageColors.electricViolet,
                    onTap: () {
                      if (_selectedRole != "DIVE VANGUARD") setState(() => _selectedRole = "DIVE VANGUARD");
                    },
                  ),
                ],
              ),
            ),
          ),

          // 2. CONTENIDO PRINCIPAL
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              child: Column(
                children: [
                  // Alerta Meta-Pulse
                  MetaPulseAlert(
                    title: "¡Thor ha sido nerfeado!",
                    description: "Habilidad 'God of Thunder' con nueva hitbox. Mira el ajuste.",
                    version: "PATCH v.0.84",
                    onTap: () => _navigateToDrill(context, "Mjolnir ajuste hitbox", "Thor", _thorDrills),
                  ),

                  const SizedBox(height: 28),

                  // Barra de Estado Interactiva
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: _showInputSelector,
                          child: _buildStatItem("INPUT PROFILE", _selectedInput, Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: _showRoleSelector,
                          child: _buildStatItem("ROLE ALIGNMENT", _selectedRole, VantageColors.vividCyan),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 36),

                  // Sección: The Lab
                  SectionHeader(
                    title: "The Lab",
                    subtitle: "Personalizado para $_selectedRole",
                    onSeeAll: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ExploreScreen(type: ExploreType.lab, title: "Biblioteca de Entrenamiento", items: currentFeed)));
                    },
                  ),
                  const SizedBox(height: 18),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 1.25,
                    ),
                    itemCount: currentFeed.length,
                    itemBuilder: (context, index) {
                      final item = currentFeed[index];
                      return LabCard(
                        heroName: item["hero"],
                        title: item["title"],
                        duration: item["duration"],
                        icon: item["icon"],
                        accentColor: item["color"],
                        onTap: () => _navigateToDrill(context, item["title"], item["hero"], item["steps"]),
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // Sección: Strategic Blueprints
                  SectionHeader(
                    title: "Strategic Blueprints",
                    subtitle: "Tácticas de Equipo",
                    onSeeAll: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ExploreScreen(type: ExploreType.blueprints, title: "Explorador de Tácticas", items: _allBlueprints)));
                    },
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 240,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      children: _allBlueprints.take(3).map((bp) => BlueprintCard(
                        image: bp["image"],
                        type: bp["type"],
                        title: bp["title"],
                        heroes: List<String>.from(bp["heroes"]),
                        onTap: () => _navigateToBlueprint(context, bp),
                      )).toList(),
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: VantageColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 8, color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: color)),
        ],
      ),
    );
  }
}