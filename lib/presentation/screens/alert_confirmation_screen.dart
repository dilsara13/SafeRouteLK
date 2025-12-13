// lib/presentation/screens/alert_confirmation_screen.dart
import 'package:flutter/material.dart';
import 'package:saferoute_lk/constants/app_colors.dart';

class AlertConfirmationScreen extends StatelessWidget {
  final List<Map<String, dynamic>> contacts;
  final String message;

  const AlertConfirmationScreen({
    super.key,
    required this.contacts,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert Activated'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              '✅ ALERT ACTIVATED',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text('Emergency alert has been sent to:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  ...contacts.map((contact) {
                    return ListTile(
                      leading:
                          const Icon(Icons.person, color: AppColors.primary),
                      title: Text(contact['name']),
                      subtitle: Text(contact['phone']),
                      trailing: const Icon(Icons.check, color: Colors.green),
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Live location sharing ACTIVE for 30 minutes',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(height: 12),
                  LinearProgressIndicator(
                    backgroundColor: Colors.blue,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.phone, color: Colors.orange),
                        SizedBox(width: 8),
                        Text('Fake call incoming in...',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text('5... 4... 3... 2... 1...',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 20),
                    const Text(
                      'A fake call will be received to help you exit uncomfortable situations.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Return to Safety Dashboard'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
