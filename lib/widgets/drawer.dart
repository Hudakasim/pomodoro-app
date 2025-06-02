import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  void _navigate(BuildContext context, String route) {
    Navigator.pop(context);
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log out'),
          content: const Text('Sure you want to log out?'),
          actions: [
            TextButton(
              child: const Text('Cancle'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('log out'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('you successfully loged out')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          // Updated Drawer Header (using local asset)
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFC31F48),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/avatar.png', // Local asset
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Ahmet Yilmaz',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const Text(
                  'ahmet.yilmaz@example.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Updated ListTiles (styled like old drawer)
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xFFC31F48), size: 30),
            title: const Text('T I C K   T A C K', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            onTap: () => _navigate(context, '/home'),
          ),
          ListTile(
            leading: const Icon(Icons.person_3_sharp, color: Color(0xFFC31F48), size: 30),
            title: const Text('P R O F I L', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            onTap: () => _navigate(context, '/profile'),
          ),
    
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_applications_outlined, color: Color(0xFFC31F48), size: 30),
            title: const Text('S E T T I N G S', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            onTap: () => _navigate(context, '/settings'),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Color(0xFFC31F48), size: 30),
            title: const Text('L O G   O U T', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
