import 'package:aether_project/core/constant.dart';
import 'package:aether_project/core/enums/app_status.dart';
import 'package:aether_project/core/theme/app_colors.dart';
import 'package:aether_project/model/message_model/message_model.dart';
import 'package:aether_project/provider/message_pro.dart';
import 'package:aether_project/ui/screens/home_screen/widgets/message_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HomeScreenSection3 extends StatefulWidget {
  const HomeScreenSection3({super.key});

  @override
  State<HomeScreenSection3> createState() => _HomeScreenSection3State();
}

class _HomeScreenSection3State extends State<HomeScreenSection3> {
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    final MessagePro pro = context.read<MessagePro>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[defaultShadow],
      ),
      height: MediaQuery.sizeOf(context).height / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _ChatHeader(),
          const SizedBox(height: 16),
          Expanded(
            child: ValueListenableBuilder<List<MessageModel>>(
              valueListenable: pro.messages,
              builder: (_, List<MessageModel> messages, _) {
                return Selector<MessagePro, AppStatus>(
                  selector: (_, MessagePro p) => p.status,
                  child: chats(messages),
                  builder: (_, AppStatus status, Widget? child) {
                    if (status == AppStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    if (status == AppStatus.error) return onError(pro);

                    return child ?? const SizedBox();
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          MessageField(scrollController: _scrollController),
        ],
      ),
    );
  }

  Center onError(MessagePro pro) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(onPressed: pro.init, child: const Text('Retry')),
          const SizedBox(height: 12),
          const Text('Failed to load messages'),
        ],
      ),
    );
  }

  ScrollConfiguration chats(List<MessageModel> messages) {
    return ScrollConfiguration(
      behavior: _ScrollbarBehavior(),
      child: ScrollablePositionedList.builder(
        itemScrollController: _scrollController,
        itemCount: messages.length,
        reverse: true,
        itemBuilder: (_, int i) {
          final MessageModel message = messages[messages.length - 1 - i];
          return Column(
            children: <Widget>[
              if (i == messages.length - 1) moreLoader(),
              _buildChatMessage(message),
            ],
          );
        },
      ),
    );
  }

  Selector<MessagePro, AppStatus> moreLoader() {
    return Selector<MessagePro, AppStatus>(
      selector: (_, MessagePro p) => p.moreLoadstatus,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: CircularProgressIndicator(),
      ),
      builder: (_, AppStatus moreLoad, Widget? w) {
        if (moreLoad == AppStatus.loading) return w!;
        return const SizedBox();
      },
    );
  }

  Widget _buildChatMessage(MessageModel msg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF6D28D9),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          msg.senderId,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${msg.timestamp.hour}:${msg.timestamp.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            color: Color(0xFF6B5B8D),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(msg.content, style: const TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ValueListenableBuilder<AppStatus>(
              valueListenable:
                  msg.processingStatus ??
                  ValueNotifier<AppStatus>(AppStatus.success),
              builder: (_, AppStatus status, _) {
                if (status == AppStatus.loading) {
                  return const Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: AppColors.primaryColor,
                      )
                      .animate(
                        onComplete: (AnimationController ctl) => ctl.loop(),
                      )
                      .rotate();
                }
                if (status == AppStatus.error) {
                  return const Icon(
                    Icons.error_outline,
                    size: 14,
                    color: Colors.redAccent,
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(width: 20),
        Icon(Icons.chat, color: AppColors.primaryColor, size: 20),
        SizedBox(width: 8),
        Text(
          'ENGAGEMENT CHAT',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(
          'Live',
          style: TextStyle(
            color: Color(0xFF10B981),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 20),
      ],
    );
  }
}

class _ScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return Scrollbar(
      controller: details.controller,
      thumbVisibility: true,
      trackVisibility: true,
      child: child,
      notificationPredicate: (ScrollNotification notification) {
        final double max = notification.metrics.maxScrollExtent - 20;
        if (notification.metrics.pixels >= max) {
          context.read<MessagePro>().loadMore();
        }
        return true;
      },
    );
  }
}
