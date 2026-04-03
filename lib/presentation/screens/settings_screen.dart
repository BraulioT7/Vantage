import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VantageColors.obsidian,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("CONFIGURACIÓN", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSettingsSection("CUENTA Y SEGURIDAD", [
            _buildSettingsTile(Icons.person_outline, "Información Personal"),
            _buildSettingsTile(Icons.lock_outline, "Contraseña y Seguridad"),
            _buildSettingsTile(Icons.link, "Cuentas de Terceros"),
          ]),
          
          const SizedBox(height: 32),

          _buildSettingsSection("PREFERENCIAS DE ENTRENAMIENTO", [
            _buildSettingsTile(Icons.notifications_none, "Notificaciones de Meta"),
            _buildSettingsTile(Icons.videocam_outlined, "Calidad de Clips Ghost-Sync"),
            _buildSettingsTile(Icons.tune, "Calibración de Perfil de Input"),
          ]),

          const SizedBox(height: 32),

          _buildSettingsSection("SOPORTE", [
            _buildSettingsTile(Icons.help_outline, "Centro de Ayuda"),
            _buildSettingsTile(Icons.description_outlined, "Términos y Privacidad"),
          ]),

          const SizedBox(height: 48),

          // --- BOTÓN CERRAR SESIÓN ---
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout, color: Colors.redAccent, size: 20),
            label: const Text("CERRAR SESIÓN", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
          
          const SizedBox(height: 10),
          const Center(
            child: Text("VANTAGE App v.1.0.4 (BETA)", style: TextStyle(color: Colors.white10, fontSize: 10)),
          )
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> tiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: VantageColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(children: tiles),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70, size: 20),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24, size: 18),
      onTap: () {},
    );
  }
}