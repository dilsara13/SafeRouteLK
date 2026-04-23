// lib/presentation/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:saferoute_lk/core/constants/app_colors.dart';
import 'package:saferoute_lk/core/constants/app_styles.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _autoDetectDistress = true;
  bool _voiceInterfaceEnabled = true;
  bool _shareLiveLocation = true;
  bool _sendPeriodicUpdates = false;
  bool _shakeToTrigger = true;
  bool _darkMode = false;

  String _selectedLanguage = 'English';
  final List<String> _languages = ['English', 'Sinhala', 'Tamil'];

  String _fakeCallDefault = 'Dad';
  final List<String> _fakeCallOptions = ['Dad', 'Mom', 'Office', 'Friend'];

  int _alertCheckInterval = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            _buildProfileSection(),
            const SizedBox(height: 24),

            // Safety Preferences
            _buildSectionTitle('Safety Preferences'),
            const SizedBox(height: 12),

            _buildSettingSwitch(
              title: 'Auto-detect distress',
              subtitle: 'AI will monitor conversations for emergency keywords',
              value: _autoDetectDistress,
              onChanged: (value) => setState(() => _autoDetectDistress = value),
            ),

            _buildSettingSwitch(
              title: 'Voice interface',
              subtitle: 'Enable voice input/output',
              value: _voiceInterfaceEnabled,
              onChanged: (value) =>
                  setState(() => _voiceInterfaceEnabled = value),
            ),

            _buildSettingSwitch(
              title: 'Share live location',
              subtitle:
                  'Allow contacts to track your location during emergencies',
              value: _shareLiveLocation,
              onChanged: (value) => setState(() => _shareLiveLocation = value),
            ),

            _buildSettingSwitch(
              title: 'Shake to trigger',
              subtitle: 'Shake phone twice to trigger emergency alert',
              value: _shakeToTrigger,
              onChanged: (value) => setState(() => _shakeToTrigger = value),
            ),

            const SizedBox(height: 24),

            // Emergency Settings
            _buildSectionTitle('Emergency Settings'),
            const SizedBox(height: 12),

            _buildSettingDropdown(
              title: 'Default Fake Caller',
              subtitle: 'Select default contact for fake calls',
              value: _fakeCallDefault,
              options: _fakeCallOptions,
              onChanged: (value) => setState(() => _fakeCallDefault = value!),
            ),

            _buildSettingSlider(
              title: 'Alert Check Interval',
              subtitle: 'How often to check for alerts',
              value: _alertCheckInterval.toDouble(),
              min: 1,
              max: 30,
              divisions: 29,
              label: '$_alertCheckInterval minutes',
              onChanged: (value) =>
                  setState(() => _alertCheckInterval = value.toInt()),
            ),

            const SizedBox(height: 24),

            // App Settings
            _buildSectionTitle('App Settings'),
            const SizedBox(height: 12),

            _buildSettingDropdown(
              title: 'Language',
              subtitle: 'Select app language',
              value: _selectedLanguage,
              options: _languages,
              onChanged: (value) => setState(() => _selectedLanguage = value!),
            ),

            _buildSettingSwitch(
              title: 'Dark Mode',
              subtitle: 'Enable dark theme',
              value: _darkMode,
              onChanged: (value) => setState(() => _darkMode = value),
            ),

            const SizedBox(height: 24),

            // Emergency Contacts
            _buildSectionTitle('Emergency Contacts'),
            const SizedBox(height: 12),

            _buildEmergencyContacts(),

            const SizedBox(height: 32),

            // Action Buttons
            _buildActionButtons(),

            const SizedBox(height: 20),

            // App Info
            _buildAppInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppStyles.cardDecoration,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: const Icon(Icons.person, size: 30, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'John Doe',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  '+94 77 123 4567',
                  style: AppStyles.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppStyles.heading2.copyWith(color: AppColors.primary),
    );
  }

  Widget _buildSettingSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style:
                      AppStyles.bodySmall.copyWith(color: AppColors.textLight),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingDropdown({
    required String title,
    required String subtitle,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppStyles.bodySmall.copyWith(color: AppColors.textLight),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: value,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: options.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingSlider({
    required String title,
    required String subtitle,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required String label,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppStyles.bodySmall.copyWith(color: AppColors.textLight),
          ),
          const SizedBox(height: 12),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            label: label,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${min.toInt()} min', style: AppStyles.bodySmall),
              Text('${max.toInt()} min', style: AppStyles.bodySmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContacts() {
    final contacts = [
      {'name': 'Dad', 'phone': '+94 77 123 4567', 'relationship': 'Father'},
      {'name': 'Mom', 'phone': '+94 71 987 6543', 'relationship': 'Mother'},
      {'name': 'Sister', 'phone': '+94 76 555 1234', 'relationship': 'Sibling'},
    ];

    return Column(
      children: [
        ...contacts.map((contact) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: const Icon(Icons.person,
                      color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact['name']!,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${contact['relationship']!} • ${contact['phone']!}',
                        style: AppStyles.bodySmall
                            .copyWith(color: AppColors.textLight),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  onPressed: () {},
                  color: AppColors.primary,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 18),
                  onPressed: () {},
                  color: AppColors.emergency,
                ),
              ],
            ),
          );
        }).toList(),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {
            _showAddContactDialog();
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Emergency Contact'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _showSaveConfirmation();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Save Settings',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              _showTestAlertDialog();
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Test Emergency Alert'),
          ),
        ),
      ],
    );
  }

  Widget _buildAppInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.grey, size: 18),
              SizedBox(width: 8),
              Text('App Information',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Version', style: TextStyle(color: Colors.grey)),
              Text('1.0.0', style: AppStyles.bodyMedium),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Build Number', style: TextStyle(color: Colors.grey)),
              Text('2025.01.001', style: AppStyles.bodyMedium),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Last Updated', style: TextStyle(color: Colors.grey)),
              Text('Jan 15, 2025', style: AppStyles.bodyMedium),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Developer', style: TextStyle(color: Colors.grey)),
              Text('SafeRouteLK Team', style: AppStyles.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddContactDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Emergency Contact'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Relationship',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contact added successfully')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showSaveConfirmation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Settings saved successfully'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  void _showTestAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Test Emergency Alert'),
        content: const Text(
            'This will send a test alert to your emergency contacts. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Test alert sent successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Send Test'),
          ),
        ],
      ),
    );
  }
}
