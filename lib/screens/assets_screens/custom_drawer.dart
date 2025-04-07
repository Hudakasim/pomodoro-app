import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String? logoUrl; // Logo URL'sini alacağız

  CustomDrawer({this.logoUrl}); // Logo URL'sini constructor ile alıyoruz

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Drawer Header kısmında logo
          DrawerHeader(
            child: logoUrl == null
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo boyutunu ayarlama
                      Image.network(
                        logoUrl!,
                        width: 80,   // genişlik istediğiniz gibi ayarlayın
                        height: 80,  // yükseklik istediğiniz gibi ayarlayın
                        fit: BoxFit.contain, // logonun oranını korur
                      ),
                      SizedBox(height: 10),
                      // Eklemek istediğiniz yazı
                      Text(
                        'MindTick',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ),
          // home page
          ListTile(
            leading: Icon(Icons.home, color: Color(0xFFC31F48), size: 30),
            title: Text("H O M E", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            onTap: () => {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false)
            },
          ),
          // Settings page
          ListTile(
            leading: Icon(Icons.settings, color: Color(0xFFC31F48), size: 30),
            title: Text("S E T T I N G S", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            onTap: () => {
              Navigator.pushNamedAndRemoveUntil(context, '/settings', (route) => false)
            },
          ),
          // Log out (go back to login page)
          ListTile(
            leading: Icon(Icons.logout, color: Color(0xFFC31F48), size: 30),
            title: Text("L O G   O U T", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            onTap: () => {
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false)
            },
          ),
        ],
      ),
    );
  }
}
