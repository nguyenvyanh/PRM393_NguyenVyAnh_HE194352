import 'package:flutter/material.dart';

import '../../../home/presentation/screens/home_screen.dart';
import '../../../notifications/notification_service.dart';
import '../../data/auth_api.dart';
import '../../data/firebase_google_auth_service.dart';
import '../../data/session_manager.dart';
import '../widgets/login_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'emilys');
  final _passwordController = TextEditingController(text: 'emilyspass');
  final _authApi = AuthApi();
  final _session = SessionManager();
  final _googleAuth = FirebaseGoogleAuthService();

  bool _apiLoading = false;
  bool _googleLoading = false;
  bool _obscure = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginWithApi() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _apiLoading = true);
    try {
      final user = await _authApi.login(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
      await _session.saveApiSession(user);
      await NotificationService.instance.showLoginSuccessNotification(
        loginType: 'DummyJSON API',
      );

      _goHome();
    } catch (e) {
      _showError(e);
    } finally {
      if (mounted) setState(() => _apiLoading = false);
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() => _googleLoading = true);
    try {
      await _googleAuth.signInWithGoogle();
      await NotificationService.instance.showLoginSuccessNotification(
        loginType: 'Google',
      );

      _goHome();
    } catch (e) {
      _showError(e);
    } finally {
      if (mounted) setState(() => _googleLoading = false);
    }
  }

  void _goHome() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  void _showError(Object error) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error.toString().replaceFirst('Exception: ', ''))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: LoginCard(
              formKey: _formKey,
              usernameController: _usernameController,
              passwordController: _passwordController,
              apiLoading: _apiLoading,
              googleLoading: _googleLoading,
              obscurePassword: _obscure,
              onTogglePassword: () => setState(() => _obscure = !_obscure),
              onApiLogin: _loginWithApi,
              onGoogleLogin: _loginWithGoogle,
            ),
          ),
        ),
      ),
    );
  }
}
