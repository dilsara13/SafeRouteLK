// lib/presentation/widgets/emergency_button.dart
import 'package:flutter/material.dart';
import 'package:saferoute_lk/core/constants/app_colors.dart';

class EmergencyButton extends StatefulWidget {
  final VoidCallback onEmergencyActivated;

  const EmergencyButton({
    super.key,
    required this.onEmergencyActivated,
  });

  @override
  State<EmergencyButton> createState() => _EmergencyButtonState();
}

class _EmergencyButtonState extends State<EmergencyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPressed = false;
  int _pressDuration = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startPressTimer() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_isPressed) {
        setState(() {
          _pressDuration += 100;

          if (_pressDuration >= 3000) {
            widget.onEmergencyActivated();
            _resetButton();
          } else {
            _startPressTimer();
          }
        });
      }
    });
  }

  void _resetButton() {
    setState(() {
      _isPressed = false;
      _pressDuration = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
        _startPressTimer();
      },
      onTapUp: (_) => _resetButton(),
      onTapCancel: () => _resetButton(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFFE53935), Color(0xFFFF6B6B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      AppColors.emergency.withOpacity(_controller.value * 0.5),
                  blurRadius: 30,
                  spreadRadius: 10 * _controller.value,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.warning, size: 48, color: Colors.white),
                const SizedBox(height: 8),
                Text(
                  _isPressed
                      ? 'HOLD... ${(3000 - _pressDuration) ~/ 1000}s'
                      : '🚨 EMERGENCY',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                if (_isPressed && _pressDuration > 0) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 120,
                    child: LinearProgressIndicator(
                      value: _pressDuration / 3000,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
