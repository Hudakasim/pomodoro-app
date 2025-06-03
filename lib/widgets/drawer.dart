import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:supabase_flutter/supabase_flutter.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  String displayName = 'Kullanıcı';
  String email = 'email@example.com';
  String? photoUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = fb_auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      String newDisplayName = user.displayName ?? displayName;
      String newEmail = user.email ?? email;
      String? newPhotoUrl;

      final supabase = Supabase.instance.client;
      final response = await supabase
          .from('profiles')
          .select()
          .eq('id', user.uid)
          .maybeSingle();

      if (response != null &&
          response is Map<String, dynamic> &&
          response['profile_image'] != null &&
          (response['profile_image'] as String).isNotEmpty) {
        newPhotoUrl = response['profile_image'] as String;
      } else {
        newPhotoUrl = user.photoURL;
      }

      setState(() {
        displayName = newDisplayName;
        email = newEmail;
        photoUrl = newPhotoUrl;
      });
    }
  }

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
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Log out'),
              onPressed: () async {
                Navigator.of(context).pop();
                await fb_auth.FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You have successfully logged out')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = (photoUrl != null && photoUrl!.isNotEmpty)
        ? NetworkImage(photoUrl!)
        : const AssetImage('assets/avatar.png') as ImageProvider;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFFC31F48)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: imageProvider,
                  radius: 40,
                ),
                const SizedBox(height: 8),
                Text(
                  displayName,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  email,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading:
                const Icon(Icons.home, color: Color(0xFFC31F48), size: 30),
            title: const Text('T I C K   T A C K',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            onTap: () => _navigate(context, '/home'),
          ),
          ListTile(
            leading:
                const Icon(Icons.person_3_sharp, color: Color(0xFFC31F48), size: 30),
            title: const Text('P R O F I L',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            onTap: () => _navigate(context, '/profile'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_applications_outlined,
                color: Color(0xFFC31F48), size: 30),
            title: const Text('S E T T I N G S',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            onTap: () => _navigate(context, '/settings'),
          ),
          ListTile(
            leading:
                const Icon(Icons.exit_to_app, color: Color(0xFFC31F48), size: 30),
            title: const Text('L O G   O U T',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
