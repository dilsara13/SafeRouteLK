// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saferoute_lk/presentation/providers/ui_provider.dart';
import 'package:saferoute_lk/core/constants/app_colors.dart';
import 'package:saferoute_lk/core/constants/app_styles.dart';
import 'package:saferoute_lk/presentation/widgets/emergency_button.dart';
import 'package:saferoute_lk/presentation/screens/chatbot_screen.dart';
import 'package:saferoute_lk/presentation/screens/emergency_screen.dart';
import 'package:saferoute_lk/presentation/screens/fake_call_screen.dart';
import 'package:saferoute_lk/presentation/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UIProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SafeRouteLK - AI Safety Assistant',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Safety Dashboard
            _buildSafetyDashboard(provider),
            const SizedBox(height: 24),

            // Emergency Button
            _buildEmergencyButton(context),
            const SizedBox(height: 32),

            // Quick Actions
            _buildQuickActions(context),
            const SizedBox(height: 24),

            // Live Tracking Status
            _buildTrackingStatus(provider),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyDashboard(UIProvider provider) {
    Color scoreColor = provider.safetyScore >= 80
        ? AppColors.safe
        : provider.safetyScore >= 60
            ? AppColors.warning
            : AppColors.emergency;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2A5C82), Color(0xFF4CAF50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Safety Dashboard',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Text(
            provider.currentLocation,
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white70, size: 16),
              const SizedBox(width: 4),
              Text(
                'Live location enabled',
                style: TextStyle(color: Colors.white.withOpacity(0.8)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Safety Score',
                        style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('${provider.safetyScore}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700)),
                        const Text('/100',
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                    Text(
                      provider.safetyScore >= 80
                          ? 'Very Safe'
                          : provider.safetyScore >= 60
                              ? 'Moderately Safe'
                              : 'Exercise Caution',
                      style: TextStyle(
                          color: scoreColor, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                  width: 1, height: 60, color: Colors.white.withOpacity(0.2)),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Community Rating',
                        style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildStars(4.2),
                        const SizedBox(width: 8),
                        const Text('4.2',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const Text('Based on 128 reviews',
                        style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(Icons.star, color: Colors.yellow, size: 20);
        } else if (index < rating.ceil()) {
          return const Icon(Icons.star_half, color: Colors.yellow, size: 20);
        }
        return Icon(Icons.star_border,
            color: Colors.yellow.withOpacity(0.5), size: 20);
      }),
    );
  }

  Widget _buildEmergencyButton(BuildContext context) {
    return Column(
      children: [
        const Text('Emergency Assistance',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.primary)),
        const SizedBox(height: 8),
        const Text('Press and hold for 3 seconds',
            style: TextStyle(color: AppColors.textSecondary)),
        const SizedBox(height: 16),
        EmergencyButton(
          onEmergencyActivated: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EmergencyScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quick Actions', style: AppStyles.heading2),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildActionCard(
              icon: Icons.chat_bubble,
              title: 'AI Assistant',
              color: AppColors.primary,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChatbotScreen())),
            ),
            _buildActionCard(
              icon: Icons.phone,
              title: 'Fake Call',
              color: AppColors.secondary,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FakeCallScreen())),
            ),
            _buildActionCard(
              icon: Icons.location_on,
              title: 'Route Safety',
              color: Colors.purple,
              onTap: () => _showRouteSafetyDialog(context),
            ),
            _buildActionCard(
              icon: Icons.people,
              title: 'Safe Spots',
              color: Colors.orange,
              onTap: () => _showSafeSpotsDialog(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 12),
            Text(title,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingStatus(UIProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppStyles.cardDecoration,
      child: Row(
        children: [
          Icon(Icons.location_on,
              color: provider.isTracking
                  ? AppColors.safe
                  : AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Live Location Tracking',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Text(
                  provider.isTracking
                      ? 'Active • Updated 2 mins ago'
                      : 'Inactive',
                  style: TextStyle(
                    color: provider.isTracking
                        ? AppColors.safe
                        : AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: provider.isTracking,
            onChanged: (_) => provider.toggleTracking(),
            activeThumbColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  void _showRouteSafetyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Route Safety Check'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter destination to check safety:'),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter destination address',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
            onPressed: () => Navigator.pop(context),
            child: const Text('Check Safety'),
          ),
        ],
      ),
    );
  }

  void _showSafeSpotsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nearby Safe Spots'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: const [
              ListTile(
                leading: Icon(Icons.local_police, color: Colors.blue),
                title: Text('Police Station'),
                subtitle: Text('Colombo 07 Police • 500m away'),
              ),
              ListTile(
                leading: Icon(Icons.local_hospital, color: Colors.red),
                title: Text('General Hospital'),
                subtitle: Text('24/7 Emergency • 2km away'),
              ),
              ListTile(
                leading: Icon(Icons.store, color: Colors.green),
                title: Text('24hr Supermarket'),
                subtitle: Text('Well lit area • 300m away'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
