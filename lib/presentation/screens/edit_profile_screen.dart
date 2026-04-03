import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _userController = TextEditingController(text: "VANTAGE_USER_01");
  final TextEditingController _taglineController = TextEditingController(text: "TACTICAL SPECIALIST");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VantageColors.obsidian,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("EDITAR PERFIL", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- CAMBIAR AVATAR ---
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 100, height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: VantageColors.neonMint.withOpacity(0.5), width: 2),
                      color: VantageColors.surface,
                    ),
                    child: const Icon(Icons.person, size: 50, color: Colors.white24),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.add_a_photo, size: 16, color: Colors.black),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // --- CAMPOS DE TEXTO ---
            _buildFieldLabel("NOMBRE DE USUARIO VANTAGE"),
            TextField(
              controller: _userController,
              decoration: _inputDecoration("Usuario"),
            ),

            const SizedBox(height: 24),

            _buildFieldLabel("TAGLINE / ROL"),
            TextField(
              controller: _taglineController,
              decoration: _inputDecoration("Ej: Tactical Specialist"),
            ),

            const SizedBox(height: 40),

            // --- GESTIÓN DE CUENTAS VINCULADAS ---
            const Text(
              "GESTIÓN DE ECOSISTEMA",
              style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
            const SizedBox(height: 16),
            
            _buildLinkedAccountTile(
              "MARVEL RIVALS", 
              "VantagePro#2401", 
              Icons.link, 
              VantageColors.vividCyan
            ),

            const SizedBox(height: 60),

            // --- BOTONES DE ACCIÓN ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: VantageColors.neonMint,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text("GUARDAR CAMBIOS"),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("CANCELAR", style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(label, style: const TextStyle(color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold)),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white12),
      filled: true,
      fillColor: VantageColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16), 
        borderSide: BorderSide(color: Colors.white.withOpacity(0.05))
      ),
    );
  }

  Widget _buildLinkedAccountTile(String platform, String id, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: VantageColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(platform, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white38)),
                Text(id, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Text("DESVINCULAR", style: TextStyle(color: Colors.redAccent, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}