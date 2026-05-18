import 'package:aether_project/core/theme/app_colors.dart';
import 'package:aether_project/provider/message_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MessageField extends StatefulWidget {
  final ItemScrollController scrollController;
  const MessageField({super.key, required this.scrollController});

  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final String text = _controller.text.trim();
    if (text.isEmpty) return;

    context.read<MessagePro>().sendMessage(text);
    _controller.clear();

    if (widget.scrollController.isAttached) {
      widget.scrollController.scrollTo(index: 0, duration: 300.ms);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade300,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'Type a message...',
                hintStyle: TextStyle(color: Color(0xFF6B5B8D), fontSize: 13),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: _sendMessage,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.send, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
