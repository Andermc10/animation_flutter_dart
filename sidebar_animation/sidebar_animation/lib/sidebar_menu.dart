import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  final List<Map<String, dynamic>> menuItems = const [
    {"icon": Icons.dashboard, "title": "Dashboard"},
    {"icon": Icons.people, "title": "Usuarios"},
    {"icon": Icons.shield, "title": "Roles"},
    {"icon": Icons.sports_soccer, "title": "Material Deportivo"},
    {"icon": Icons.badge, "title": "Empleados"},
    {"icon": Icons.person, "title": "Deportistas"},
    {"icon": Icons.build, "title": "Servicios"},
    {"icon": Icons.volunteer_activism, "title": "Donaciones"},
    {"icon": Icons.event, "title": "Eventos"},
    {"icon": Icons.shopping_bag, "title": "Compras"},
    {"icon": Icons.sell, "title": "Ventas"},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            SizedBox(
              height: 100,
              child: Image.asset("assets/logo.png"), 
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 400),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: ListTile(
                            leading: Icon(item["icon"], color: Colors.black),
                            title: Text(
                              item["title"],
                              style: const TextStyle(fontSize: 16),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.purple),
              title: const Text(
                "Cerrar Sesión",
                style: TextStyle(color: Colors.purple),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}