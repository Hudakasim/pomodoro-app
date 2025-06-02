import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pomodoro/widgets/base.dart';
import '../../services/user_service.dart';
import '../../services/local_storage_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final User? user = FirebaseAuth.instance.currentUser;
  final UserService _userService = UserService();
  final LocalStorageService _storage = LocalStorageService();

  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();  // Eklendi
  final TextEditingController _emailController = TextEditingController();    // Eklendi
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllUserData();
  }

  Future<void> _loadAllUserData() async {
    final localUserData = await _storage.getUserData();
    final firestoreData = await _userService.getUserData();

    setState(() {
      _nameController.text = localUserData['name'] ?? '';
      _surnameController.text = localUserData['surname'] ?? '';
      _emailController.text = localUserData['email'] ?? '';
      _birthDateController.text = firestoreData?['birthDate'] ?? '';
      _birthPlaceController.text = firestoreData?['birthPlace'] ?? '';
      _cityController.text = firestoreData?['city'] ?? '';
      _isLoading = false;
    });
  }


  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      // Firebase Storage yükleme buraya eklenebilir
    }
  }

  Future<void> _updateProfile() async {
    setState(() => _isLoading = true);

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) throw Exception("Kullanıcı bulunamadı");

      // Firestore bilgilerini güncelle
      await _userService.updateUserProfile(
        _birthDateController.text,
        _birthPlaceController.text,
        _cityController.text,
      );

      // SharedPreferences bilgilerini güncelle
      await _storage.saveUserData(
        userId: currentUser.uid,
        email: _emailController.text.trim(),
        name: _nameController.text.trim(),
        surname: _surnameController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil başarıyla güncellendi!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profil güncellenirken hata: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (_selectedImage != null) {
      imageProvider = FileImage(_selectedImage!);
    } else if (user?.photoURL != null) {
      imageProvider = NetworkImage(user!.photoURL!);
    } else {
      imageProvider = const AssetImage('assets/default_avatar.png');
    }

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return BasePage(
      title: 'Profile',
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: imageProvider,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // İsim ve Soyisim yan yana
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'İsim'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _surnameController,
                    decoration: const InputDecoration(labelText: 'Soyisim'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Email
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              readOnly: true,
            ),

            const SizedBox(height: 16),

            // Çizgi
            const Divider(thickness: 1),

            const SizedBox(height: 16),

            // Doğum Tarihi ve Doğum Yeri yan yana
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _birthDateController,
                    decoration: const InputDecoration(labelText: 'Doğum Tarihi'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _birthPlaceController,
                    decoration: const InputDecoration(labelText: 'Doğum Yeri'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Yaşadığı Şehir
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: 'Şehir'),
            ),

            const SizedBox(height: 16),

            // Biyografi
            TextField(
              controller: _bioController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Biyografi',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC31F48),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: _updateProfile,
                child: const Text(
                  'Profili Güncelle',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
