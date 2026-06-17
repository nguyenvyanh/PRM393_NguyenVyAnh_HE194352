import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/session_keys.dart';
import '../../../auth/data/firebase_google_auth_service.dart';
import '../../../auth/data/session_manager.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../widgets/api_session_card.dart';
import '../widgets/google_session_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _session = SessionManager();
  final _googleAuth = FirebaseGoogleAuthService();
  Map<String, String>? _apiProfile;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final profile = await _session.getApiProfile();
    if (!mounted) return;
    setState(() => _apiProfile = profile);
  }

  Future<void> _logout() async {
    await _session.clear();
    await _googleAuth.signOut();

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final googleUser = _googleAuth.currentUser;
    final apiProfile = _apiProfile;
    final hasApi = (apiProfile?[SessionKeys.token] ?? '').isNotEmpty;
    final hasGoogle = googleUser != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab10 Home'),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: apiProfile == null
          ? const Center(child: CircularProgressIndicator())
          : _HomeContent(
              apiProfile: apiProfile,
              googleUser: googleUser,
              hasApi: hasApi,
              hasGoogle: hasGoogle,
              onLogout: _logout,
            ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.apiProfile,
    required this.googleUser,
    required this.hasApi,
    required this.hasGoogle,
    required this.onLogout,
  });

  final Map<String, String> apiProfile;
  final User? googleUser;
  final bool hasApi;
  final bool hasGoogle;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          'Authenticated',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        if (hasApi) ApiSessionCard(profile: apiProfile),
        if (hasGoogle && googleUser != null)
          GoogleSessionCard(user: googleUser!),
        if (!hasApi && !hasGoogle)
          const Text('No active session found. Please logout and login again.'),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: onLogout,
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
        ),
      ],
    );
  }
}
