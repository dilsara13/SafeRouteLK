import 'package:flutter/material.dart';

import 'package:saferoute_lk/core/constants/app_colors.dart';
import 'package:saferoute_lk/core/constants/app_styles.dart';

class FakeCallScreen extends StatefulWidget {
  const FakeCallScreen({super.key});

  @override
  State<FakeCallScreen> createState() => _FakeCallScreenState();
}

class _FakeCallScreenState extends State<FakeCallScreen> {
  String _selectedCaller = 'dad';
  String _selectedScenario = 'on_my_way';
  int _callDelay = 0;
  bool _isCallActive = false;
  int _callTimer = 0;

  final Map<String, Map<String, dynamic>> _callers = {
    'dad': {
      'name': 'Dad',
      'icon': Icons.family_restroom,
      'color': Colors.blue,
      'number': '+94 77 XXX XX',
    },
    'mom': {
      'name': 'Mom',
      'icon': Icons.family_restroom,
      'color': Colors.pink,
      'number': '+94 71 XXX XX',
    },
    'office': {
      'name': 'Office',
      'icon': Icons.business,
      'color': Colors.orange,
      'number': '+94 11 XXX XX',
    },
    'friend': {
      'name': 'Best Friend',
      'icon': Icons.people,
      'color': Colors.green,
      'number': '+94 76 XXX XX',
    },
  };

  final Map<String, Map<String, dynamic>> _scenarios = {
    'on_my_way': {
      'title': 'On My Way',
      'description': 'Caller says they\'re coming to pick you up',
      'script':
          'Hi, just checking where you are. I\'m on my way, should be there in 10 minutes.',
    },
    'checking_in': {
      'title': 'Checking In',
      'description': 'Casual check-in call',
      'script': 'Hey, just calling to check on you. Everything okay?',
    },
    'emergency_excuse': {
      'title': 'Emergency Excuse',
      'description': 'Help you exit uncomfortable situation',
      'script':
          'Emergency at work! Need you back immediately. I\'ll explain when you get here.',
    },
    'fake_meeting': {
      'title': 'Fake Meeting',
      'description': 'Pretend there\'s an important meeting',
      'script':
          'The meeting starts in 15 minutes. Where are you? Everyone is waiting.',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fake Call Generator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preview Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.safetyGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    'Call Preview',
                    style: AppStyles.heading2.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  _buildCallPreview(),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Caller Selection
            Text('Select Caller', style: AppStyles.heading2),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _callers.entries.map((entry) {
                final caller = entry.value;
                final isSelected = _selectedCaller == entry.key;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCaller = entry.key;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? caller['color'].withOpacity(0.2)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? caller['color'] as Color
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          caller['icon'] as IconData,
                          size: 32,
                          color: caller['color'] as Color,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          caller['name'],
                          style: AppStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: caller['color'] as Color,
                          ),
                        ),
                        Text(caller['number'], style: AppStyles.bodySmall),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Scenario Selection
            Text('Call Scenario', style: AppStyles.heading2),
            const SizedBox(height: 12),
            ..._scenarios.entries.map((entry) {
              final scenario = entry.value;
              final isSelected = _selectedScenario == entry.key;

              return Card(
                elevation: isSelected ? 4 : 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    setState(() {
                      _selectedScenario = entry.key;
                    });
                  },
                  leading: isSelected
                      ? const Icon(Icons.check_circle, color: AppColors.primary)
                      : const Icon(Icons.radio_button_unchecked),
                  title: Text(
                    scenario['title'],
                    style: AppStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    scenario['description'],
                    style: AppStyles.bodySmall,
                  ),
                ),
              );
            }),

            const SizedBox(height: 16),

            // Scenario Script Preview
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Call Script:',
                    style: AppStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _scenarios[_selectedScenario]!['script'],
                    style: AppStyles.bodyMedium.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Call Timing
            Text('Call Timing', style: AppStyles.heading2),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              children: [
                _buildTimingOption('Call Now', 0),
                _buildTimingOption('In 30s', 30),
                _buildTimingOption('In 1 min', 60),
                _buildTimingOption('Custom', -1),
              ],
            ),

            if (_callDelay == -1) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Custom Delay',
                      style: AppStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Slider(
                      value: _callDelay.toDouble(),
                      min: 0,
                      max: 300,
                      divisions: 30,
                      label: '$_callDelay seconds',
                      onChanged: (value) {
                        setState(() {
                          _callDelay = value.toInt();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 16),

            // Gesture Trigger Option
            Container(
              padding: const EdgeInsets.all(16),
              decoration: AppStyles.cardDecoration,
              child: Row(
                children: [
                  const Icon(Icons.vibration, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shake to Trigger',
                          style: AppStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Shake phone twice to trigger fake call',
                          style: AppStyles.bodySmall.copyWith(
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: true,
                    onChanged: (value) {},
                    activeThumbColor: AppColors.primary,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isCallActive ? _endFakeCall : _startFakeCall,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isCallActive ? Colors.grey : AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isCallActive ? Icons.call_end : Icons.phone,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _isCallActive ? 'END FAKE CALL' : 'START FAKE CALL',
                      style: AppStyles.emergencyText.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            if (_isCallActive) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade100),
                ),
                child: Column(
                  children: [
                    Text(
                      'Call Active - $_callTimer seconds',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const LinearProgressIndicator(
                      backgroundColor: Colors.green,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Pretend to talk naturally. Call will end automatically in 45 seconds.',
                      style: AppStyles.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCallPreview() {
    final caller = _callers[_selectedCaller];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: caller!['color'].withOpacity(0.1),
            child: Icon(
              caller['icon'] as IconData,
              size: 40,
              color: caller['color'] as Color,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            caller['name'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Text(
            caller['number'],
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.phone_missed, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text('Decline', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.phone, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text('Accept', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimingOption(String label, int seconds) {
    final isSelected = _callDelay == seconds;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _callDelay = selected ? seconds : 0;
        });
      },
      selectedColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppColors.textPrimary,
      ),
    );
  }

  void _startFakeCall() {
    setState(() {
      _isCallActive = true;
      _callTimer = 0;
    });

    // Start timer
    _startCallTimer();

    // Show incoming call notification
    _showIncomingCall();
  }

  void _startCallTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_isCallActive && _callTimer < 45) {
        setState(() {
          _callTimer++;
        });
        _startCallTimer();
      } else if (_callTimer >= 45) {
        _endFakeCall();
      }
    });
  }

  void _showIncomingCall() {
    // This would show a full-screen incoming call UI in production
    // For demo, show a dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('📞 Incoming Fake Call'),
        content: Text(
          '${_callers[_selectedCaller]!['name']} is calling...\n\n'
          'Scenario: ${_scenarios[_selectedScenario]!['title']}\n\n'
          'When you accept, pretend to have a conversation.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Decline logic
            },
            child: const Text('Decline'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Accept logic - show talking screen
              _showTalkingScreen();
            },
            child: const Text('Accept'),
          ),
        ],
      ),
    );
  }

  void _showTalkingScreen() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: _callers[_selectedCaller]!['color'].withOpacity(
                0.1,
              ),
              child: Icon(
                _callers[_selectedCaller]!['icon'] as IconData,
                size: 50,
                color: _callers[_selectedCaller]!['color'] as Color,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _callers[_selectedCaller]!['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            Text(
              '00:${_callTimer.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What to say:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _scenarios[_selectedScenario]!['script'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Example responses:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('• "Yes, I\'m at [location]"'),
                    const Text('• "I\'ll wait here for you"'),
                    const Text('• "Thanks for checking on me"'),
                    const Text('• "See you soon"'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _endFakeCall,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.call_end),
                    SizedBox(width: 8),
                    Text('END CALL'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _endFakeCall() {
    setState(() {
      _isCallActive = false;
      _callTimer = 0;
    });

    // Close any open dialogs
    Navigator.of(context).popUntil((route) => route.isFirst);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fake call ended successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
