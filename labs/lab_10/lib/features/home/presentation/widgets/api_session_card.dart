import 'package:flutter/material.dart';

import '../../../../core/constants/session_keys.dart';

class ApiSessionCard extends StatelessWidget {
  const ApiSessionCard({
    required this.profile,
    super.key,
  });

  final Map<String, String> profile;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DummyJSON API Session',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Name: ${profile[SessionKeys.fullName]}'),
            Text('Username: ${profile[SessionKeys.username]}'),
            Text('Email: ${profile[SessionKeys.email]}'),
            const SizedBox(height: 8),
            const Text('Saved access token:'),
            SelectableText(profile[SessionKeys.token] ?? ''),
          ],
        ),
      ),
    );
  }
}
