// lib/presentation/screens/chatbot_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saferoute_lk/constants/app_colors.dart';
import 'package:saferoute_lk/presentation/providers/ui_provider.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _quickQuestions = [
    'Where am I?',
    'Is this area safe?',
    'I feel unsafe',
    'Nearest safe spot',
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UIProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Safety Assistant'),
        actions: [
          IconButton(
            icon: const Icon(Icons.mic),
            onPressed: () => _simulateVoiceInput(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.chatMessages.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) return _buildQuickActions();
                final message = provider.chatMessages[index - 1];
                return _buildChatBubble(
                  message['text'],
                  message['isUser'],
                  message['time'],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    onSubmitted: (value) => _sendMessage(value),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: () => _sendMessage(_textController.text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text('Quick Questions',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _quickQuestions.map((question) {
            return GestureDetector(
              onTap: () => _sendMessage(question),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.question_answer,
                        size: 16, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Text(question,
                        style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildChatBubble(String text, bool isUser, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: const Icon(Icons.psychology,
                  size: 18, color: AppColors.primary),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? AppColors.primary : Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text,
                      style: TextStyle(
                          color:
                              isUser ? Colors.white : AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text(time,
                      style: TextStyle(
                        fontSize: 11,
                        color: isUser ? Colors.white70 : Colors.grey,
                      )),
                ],
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.secondary.withOpacity(0.1),
              child: const Icon(Icons.person,
                  size: 18, color: AppColors.secondary),
            ),
          ],
        ],
      ),
    );
  }

  void _sendMessage(String text) {
    if (text.isEmpty) return;

    final provider = Provider.of<UIProvider>(context, listen: false);
    provider.addChatMessage(text, true);
    _textController.clear();

    // Simulate AI response
    Future.delayed(const Duration(seconds: 1), () {
      _addAIResponse(text);
    });
  }

  void _addAIResponse(String userMessage) {
    final provider = Provider.of<UIProvider>(context, listen: false);
    String response = '';

    if (userMessage.toLowerCase().contains('where am i')) {
      response = "📍 You're at: Galle Road, Colombo 03\n\n"
          "⚠️ Safety Information:\n"
          "• Safety Score: 72/100\n"
          "• Crime Level: Moderate\n"
          "• Street Lighting: Good\n\n"
          "🏪 Nearby Safe Spots:\n"
          "• 24hr Supermarket (50m)\n"
          "• Police Booth (200m)";
    } else if (userMessage.toLowerCase().contains('safe')) {
      response = "Based on recent data:\n\n"
          "✅ This area has:\n"
          "• Good street lighting\n"
          "• Regular police patrols\n\n"
          "⚠️ Caution advised:\n"
          "• Avoid dark alleys after 10 PM";
    } else if (userMessage.toLowerCase().contains('unsafe')) {
      response = "🚨 I detect you might be in danger.\n\n"
          "Are you OK? Please respond within 30 seconds.";
    } else {
      response = "I understand you asked: \"$userMessage\"\n\n"
          "As your safety assistant, I can help you with:\n"
          "• Location safety information\n"
          "• Emergency assistance\n"
          "• Safe route planning";
    }

    provider.addChatMessage(response, false);
  }

  void _simulateVoiceInput() {
    // Simulate voice input for demo
    _sendMessage('Voice message: I need help finding a safe route');
  }
}
