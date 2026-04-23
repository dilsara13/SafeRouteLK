// lib/presentation/screens/emergency_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:saferoute_lk/core/constants/app_colors.dart';
import 'package:saferoute_lk/presentation/screens/alert_confirmation_screen.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  String _selectedMessage =
      'I need immediate help! My current location is: {LOCATION}. Please check on me.';
  bool _shareLiveLocation = true;
  bool _activateFakeCall = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmergencyProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Alert'),
        backgroundColor: AppColors.emergency,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Warning Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.emergency.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.emergency.withOpacity(0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning, color: AppColors.emergency),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'This will send alert to selected contacts.',
                      style: TextStyle(color: AppColors.emergency),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Emergency Contacts
            const Text('Alert Recipients',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...provider.contacts.asMap().entries.map((entry) {
              final contact = entry.value;
              return _buildContactItem(contact, entry.key, provider);
            }),

            const SizedBox(height: 24),

            // Message Template
            const Text('Alert Message',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Type your emergency message...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (value) => _selectedMessage = value,
            ),

            const SizedBox(height: 24),

            // Additional Options
            const Text('Additional Options',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),

            _buildOptionSwitch(
              title: 'Share Live Location',
              subtitle: 'Contacts can track location for 30 minutes',
              value: _shareLiveLocation,
              onChanged: (value) => setState(() => _shareLiveLocation = value),
            ),

            _buildOptionSwitch(
              title: 'Activate Fake Call',
              subtitle: 'Receive a fake call to deter threats',
              value: _activateFakeCall,
              onChanged: (value) => setState(() => _activateFakeCall = value),
            ),

            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _sendEmergencyAlert(context, provider),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.emergency,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.warning, size: 20),
                        SizedBox(width: 8),
                        Text('SEND ALERT'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(
      Map<String, dynamic> contact, int index, EmergencyProvider provider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: const Icon(Icons.person, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contact['name'],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                Text(contact['phone'],
                    style: const TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          ),
          Checkbox(
            value: contact['selected'],
            onChanged: (_) => provider.toggleContactSelection(index),
            activeColor: AppColors.emergency,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Switch(value: value, onChanged: onChanged),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
                Text(subtitle,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendEmergencyAlert(BuildContext context, EmergencyProvider provider) {
    final selectedContacts = provider.selectedContacts;

    if (selectedContacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one contact')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlertConfirmationScreen(
          contacts: selectedContacts,
          message: _selectedMessage,
        ),
      ),
    );
  }
}

class EmergencyProvider {
  final List<Map<String, dynamic>> _contacts = [
    {'name': 'Contact 1', 'phone': '0712345678', 'selected': false},
    {'name': 'Contact 2', 'phone': '0787654321', 'selected': false},
  ];

  List<Map<String, dynamic>> get contacts => _contacts;

  List<Map<String, dynamic>> get selectedContacts =>
      _contacts.where((contact) => contact['selected'] == true).toList();

  void toggleContactSelection(int index) {
    if (index >= 0 && index < _contacts.length) {
      _contacts[index]['selected'] = !_contacts[index]['selected'];
    }
  }
}
