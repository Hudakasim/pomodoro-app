import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _client = Supabase.instance.client;

  Future<void> upsertUserProfile({
    required String userId,
    required String username,
    required String bio,
    required String profileImageUrl,
  }) async {
    await _client.from('profiles').upsert({
      'id': userId,
      'username': username,
      'bio': bio,
      'profile_image': profileImageUrl,
    });
  }

  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();

    return response;
  }
}
