import 'package:flutter/material.dart';

import '../../../home/presentation/screens/home_screen.dart';
import '../../data/firebase_google_auth_service.dart';
import '../../data/session_manager.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _session = SessionManager();
  final _googleAuth = FirebaseGoogleAuthService();

  @override
  void initState() {
    super.initState();
    _route();
  }

  Future<void> _route() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));

    final hasApiSession = await _session.hasApiSession();
    final hasGoogleSession = _googleAuth.currentUser != null;

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => hasApiSession || hasGoogleSession
            ? const HomeScreen()
            : const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlutterLogo(size: 90),
            SizedBox(height: 16),
            Text('Lab10 Full'),
            SizedBox(height: 8),
            Text('Checking authentication session...'),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
