import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GoogleSessionCard extends StatelessWidget {
  const GoogleSessionCard({
    required this.user,
    super.key,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Firebase Google Session',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            CircleAvatar(
              radius: 36,
              backgroundImage:
                  user.photoURL != null ? NetworkImage(user.photoURL!) : null,
              child: user.photoURL == null ? const Icon(Icons.person) : null,
            ),
            const SizedBox(height: 12),
            Text('Name: ${user.displayName ?? 'No name'}'),
            Text('Email: ${user.email ?? 'No email'}'),
            Text('UID: ${user.uid}'),
          ],
        ),
      ),
    );
  }
}
