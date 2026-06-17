import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
    required this.apiLoading,
    required this.googleLoading,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.onApiLogin,
    required this.onGoogleLogin,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool apiLoading;
  final bool googleLoading;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onApiLogin;
  final VoidCallback onGoogleLogin;

  @override
  Widget build(BuildContext context) {
    final isBusy = apiLoading || googleLoading;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.shield_outlined, size: 72),
            const SizedBox(height: 12),
            Text(
              'Lab10 Full Login',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'DummyJSON username',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => (value ?? '').trim().isEmpty
                        ? 'Username required'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: onTogglePassword,
                      ),
                    ),
                    validator: (value) => (value ?? '').trim().isEmpty
                        ? 'Password required'
                        : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: isBusy ? null : onApiLogin,
              icon: apiLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.cloud_done_outlined),
              label:
                  Text(apiLoading ? 'Signing in...' : 'Login with DummyJSON'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: isBusy ? null : onGoogleLogin,
              icon: googleLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.g_mobiledata),
              label: Text(
                googleLoading ? 'Signing in...' : 'Continue with Google',
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Test API: emilys / emilyspass',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
