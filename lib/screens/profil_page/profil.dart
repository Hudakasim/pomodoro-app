import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pomodoro/widgets/base.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final User? user = FirebaseAuth.instance.currentUser;

  final TextEditingController _bioController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Eğer kullanıcıdan bio veya diğer bilgileri alıyorsan burada yükleyebilirsin
    _bioController.text = ""; // Başlangıçta boş, ihtiyaca göre değiştir
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      // Burada istersen seçilen resmi Firebase Storage'a yükleme işlemi yapabilirsin
    }
  }

  // Profile sayfasında
  Future<String?> getNameFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  void _updateProfilee() {
    // Burada isim, biyografi ve profile fotoğrafını Firebase Firestore ve Storage’a kaydetme işlemi olmalı
    // Örnek amaçlı sadece Snackbar gösteriyoruz
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile güncelleme işlemi burada yapılacak.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> imageProvider;

    if (_selectedImage != null) {
      imageProvider = FileImage(_selectedImage!);
    } else if (user?.photoURL != null) {
      imageProvider = NetworkImage(user!.photoURL!);
    } else {
      imageProvider = const AssetImage('assets/default_avatar.png');
    }

    return BasePage(
      title: 'Profile',
      content: user == null
          ? const Center(child: Text('Kullanıcı bulunamadı!'))
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: imageProvider,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      user?.displayName ?? 'Kullanıcı',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    // Biyografi alanı
                    TextField(
                      controller: _bioController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Biyografi',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Profilei güncelle butonu
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC31F48),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: _updateProfilee,
                      child: const Text('Profilei Güncelle',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),

                    const SizedBox(height: 30),

                    // Çıkış yap butonu
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[700],
                        padding:
                            const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text('Çıkış Yap',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
