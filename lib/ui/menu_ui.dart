import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'search_ui.dart';
import 'post_log_ui.dart';

class MenuUI extends StatelessWidget {
  const MenuUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Background Hitam Premium
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER SECTION (Gradient & Profile) ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 40, left: 30, right: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE10600), Color(0xFF8A0000)], // Gradasi Merah F1
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(color: Color(0x66E10600), blurRadius: 20, offset: Offset(0, 10)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.speed, size: 40, color: Colors.white),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text("UAS EDITION v2.0", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text("WELCOME BACK,", style: TextStyle(color: Colors.white70, fontSize: 14, letterSpacing: 2)),
                  const Text("RACE ENGINEER", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 20),

                  // Kartu Identitas Transparan
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        _buildIdentityRow(Icons.badge_outlined, "223303030448"),
                        const SizedBox(height: 8),
                        _buildIdentityRow(Icons.person_outline, "NAWFAL TAMIM SYUJA'I"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // --- MENU OPTIONS ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("DASHBOARD MENU", style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  const SizedBox(height: 15),

                  // [1] SEARCH MENU
                  _buildMenuCard(
                    context,
                    title: "TELEMETRY SEARCH",
                    subtitle: "[1] Cari data setup sirkuit",
                    icon: Icons.search_rounded,
                    accentColor: Colors.blueAccent,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const SearchUI())),
                  ),

                  const SizedBox(height: 20),

                  // [2] POST LOG MENU
                  _buildMenuCard(
                    context,
                    title: "MECHANIC LOG",
                    subtitle: "[2] Input laporan mekanik",
                    icon: Icons.add_to_photos_rounded,
                    accentColor: const Color(0xFFE10600),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const PostLogUI())),
                  ),

                  const SizedBox(height: 40),

                  // [3] LOGOUT BUTTON (Minimalis)
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.power_settings_new),
                      label: const Text("SHUTDOWN SYSTEM"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey,
                        side: const BorderSide(color: Colors.grey, width: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () => SystemNavigator.pop(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildIdentityRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontFamily: 'monospace')),
      ],
    );
  }

  Widget _buildMenuCard(BuildContext context, {required String title, required String subtitle, required IconData icon, required Color accentColor, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(20),
            border: Border(left: BorderSide(color: accentColor, width: 6)), // Aksen warna di kiri
            boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 5))],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accentColor, size: 28),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}