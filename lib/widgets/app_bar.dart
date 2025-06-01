import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
    final String title;

    const CustomAppBar({super.key, required this.title});

    @override
    Widget build(BuildContext context) {
        return AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(title, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w200, color: Colors.white)),
            actions: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                    child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/settings'),
                        child: Image.asset(
                            'assets/logo/logo_white.png',
                            height: 30,
                        ),
                    ),
                ),
            ],
            backgroundColor: Color(0xFFC31F48),
        );
    }

    @override
    Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.white),
      //   title: Center(
      //     child: Padding(
      //       padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
      //       child: Text(
      //         "Settings",
      //         style: TextStyle(fontSize: 28, fontWeight: FontWeight.w200, color: Colors.white),
      //       ),
      //     ),
      //   ),
      //   backgroundColor: Color(0xFFC31F48),
      // ),
