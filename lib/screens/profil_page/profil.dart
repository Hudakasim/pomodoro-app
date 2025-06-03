import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:image_picker/image_picker.dart';
import 'package:pomodoro/widgets/base.dart';
import '../../services/user_service.dart';
import '../../services/local_storage_service.dart';
import '../../services/database_helper.dart';
import '../../services/supabase_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final fb_auth.User? user = fb_auth.FirebaseAuth.instance.currentUser;
  final UserService _userService = UserService();
  final LocalStorageService _storage = LocalStorageService();
  final SupabaseService _supabaseService = SupabaseService();
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllUserData();
  }

  Future<void> _loadAllUserData() async {
    if (user == null) return;
    final userId = user!.uid;

    final localUserData = await _storage.getUserData(userId);
    final sqliteData = await _dbHelper.getUserProfile(userId);
    final firestoreData = await _userService.getUserData();
    final supaData = await _supabaseService.getUserProfile(userId);
    setState(() {
    if (sqliteData != null) {
      _usernameController.text = sqliteData['username'] ?? '';
      _bioController.text = sqliteData['bio'] ?? '';
      final imagePath = sqliteData['profile_image'];
    if (imagePath != null && imagePath.isNotEmpty) {
      _selectedImage = File(imagePath);
    }
    }
      _nameController.text = localUserData['name'] ?? '';
      _surnameController.text = localUserData['surname'] ?? '';
      _emailController.text = localUserData['email'] ?? '';
      _birthDateController.text = firestoreData?['birthDate'] ?? '';
      _birthPlaceController.text = firestoreData?['birthPlace'] ?? '';
      _cityController.text = firestoreData?['city'] ?? '';
      _isLoading = false;
    });

    if (supaData != null) {
      _usernameController.text = supaData['username'] ?? '';
      _bioController.text = supaData['bio'] ?? '';
      // Profil resmi URL'si varsa burada kullanılabilir (ileride ekleyeceğiz)
    }

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
    if (user == null) return;
    final userId = user!.uid;

    setState(() => _isLoading = true);
    // SQLite'e kaydetme
    try {
      final existingProfile = await _dbHelper.getUserProfile(userId);
        if (existingProfile == null) {
          await _dbHelper.insertUserProfile({
            'user_id': userId,  // kullanıcı id ekle
            'username': _usernameController.text.trim(),
            'bio': _bioController.text.trim(),
            'profile_image': _selectedImage?.path ?? '',
          });
        } else {
          await _dbHelper.updateUserProfile({
            'id': existingProfile['id'],
            'user_id': userId, // kullanıcı id ekle
            'username': _usernameController.text.trim(),
            'bio': _bioController.text.trim(),
            'profile_image': _selectedImage?.path ?? existingProfile['profile_image'],
          });
      }
    } catch (e) {
      print("SQLite kaydetme hatası: $e");
    }
    try {
      // Firestore bilgilerini güncelle
      await _userService.updateUserProfile(
        _birthDateController.text,
        _birthPlaceController.text,
        _cityController.text,
      );

      // SharedPreferences bilgilerini modüler olarak güncelle
      try {
        await _storage.updateName(userId, _nameController.text.trim());
        await _storage.updateSurname(userId, _surnameController.text.trim());

        print("SharedPreferences güncellendi: isim=${_nameController.text.trim()}, soyisim=${_surnameController.text.trim()}");
      } catch (e) {
        print("SharedPreferences güncelleme hatası: $e");
      }
    await _supabaseService.upsertUserProfile(
      userId: userId,
      username: _usernameController.text.trim(),
      bio: _bioController.text.trim(),
      profileImageUrl: '', // ileride Storage'tan URL eklersin
    );

    if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil başarıyla güncellendi!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profil güncellenirken hata: $e')),
      );
    } finally {
      if (!mounted) return;
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

            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              readOnly: true,
            ),

            const SizedBox(height: 16),

            const Divider(thickness: 1),

            const SizedBox(height: 16),

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

            TextField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: 'Şehir'),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _bioController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Biyografi',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username for profile'),
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
