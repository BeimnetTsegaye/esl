import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/util/date_utils.dart';
import 'package:esl/core/widgets/custom_tab_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _chatController = TextEditingController();

  final List<String> tabs = ['Chat Bot', 'Live Chat'];
  List<Map<String, String>> chatBotMessages = [
    {
      'sender': 'bot',
      'message': 'Hello! How can I assist you today?',
      'date': '2025-05-01',
    },
    {
      'sender': 'bot',
      'message': 'I am here to help you with your queries.',
      'date': '2025-05-13',
    },
    {
      'sender': 'user',
      'message': 'Can you tell me about the courses?',
      'date': '2025-05-14',
    },
    {
      'sender': 'bot',
      'message': 'Sure! We offer various courses.',
      'date': '2025-05-15',
    },
    {
      'sender': 'user',
      'message': 'What are the admission requirements?',
      'date': '2025-05-23',
    },
    {
      'sender': 'bot',
      'message': 'Feel free to ask me anything.',
      'date': '2025-05-24',
    },
  ];
  List<Map<String, String>> liveChatMessages = [
    {
      'sender': 'user',
      'message': 'Hi! I need help with my account.',
      'date': '2025-05-10',
    },
    {
      'sender': 'support',
      'message': 'Sure! What seems to be the problem?',
      'date': '2025-05-16',
    },
    {
      'sender': 'user',
      'message': 'I forgot my password.',
      'date': '2025-05-17',
    },
    {
      'sender': 'support',
      'message': 'Let me check that for you.',
      'date': '2025-05-18',
    },
    {
      'sender': 'support',
      'message': 'I have reset your password.',
      'date': '2025-05-20',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chatbot & Live Chat')),
      body: Column(
        children: [
          CustomTabBar(tabController: _tabController, tabs: tabs),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  reverse: true,
                  itemCount: chatBotMessages.length,
                  itemBuilder: (context, index) {
                    final reversedIndex = chatBotMessages.length - 1 - index;
                    final isBot =
                        chatBotMessages[reversedIndex]['sender'] != 'user';
                    return ChatBubble(
                      isBot: isBot,
                      chatMessages:
                          chatBotMessages[reversedIndex]['message'] ?? '',
                      date: formatDateToRelative(
                        DateTime.parse(chatBotMessages[reversedIndex]['date']!),
                      ),
                    );
                  },
                ),
                ListView.builder(
                  reverse: true,
                  itemCount: liveChatMessages.length,

                  itemBuilder: (context, index) {
                    final reversedIndex = liveChatMessages.length - 1 - index;
                    final isBot =
                        liveChatMessages[reversedIndex]['sender'] != 'user';

                    return ChatBubble(
                      isBot: isBot,
                      chatMessages:
                          liveChatMessages[reversedIndex]['message'] ?? '',
                      date: formatDateToRelative(
                        DateTime.parse(
                          liveChatMessages[reversedIndex]['date']!,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.mic_none),
                        onPressed: () {
                          // Handle voice input
                        },
                      ),
                    ),
                    onSubmitted: (message) => send(),
                  ),
                ),
                IconButton(
                  icon: CircleAvatar(
                    child: SvgPicture.asset(AppConstants.send),
                  ),
                  onPressed: () => send(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void send() {
    final message = _chatController.text;
    if (message.isNotEmpty) {
      if (_tabController.index == 0) {
        // Add message to chat bot messages
        setState(() {
          chatBotMessages.add({
            'sender': 'user',
            'message': message,
            'date': DateTime.now().toIso8601String(),
          });
        });
      } else {
        setState(() {
          liveChatMessages.add({
            'sender': 'user',
            'message': message,
            'date': DateTime.now().toIso8601String(),
          });
        });
      }
      _chatController.clear();
    }
  }
}

class ChatBubble extends StatefulWidget {
  const ChatBubble({
    super.key,
    required this.isBot,
    required this.chatMessages,
    this.date = '',
  });

  final bool isBot;
  final String chatMessages;
  final String date;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool isDateVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDateVisible = !isDateVisible;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            if (isDateVisible)
              Padding(
                padding: const EdgeInsets.only(left: 50.0, top: 5),
                child: Text(
                  widget.date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppConstants.eslGrey,
                  ),
                ),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: widget.isBot
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                if (widget.isBot)
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: AppConstants.eslGreyTint,
                    child: SvgPicture.asset(AppConstants.chatBot),
                  ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: widget.isBot
                        ? AppConstants.eslGreyTint
                        : AppConstants.eslGreenTint,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(widget.isBot ? 0 : 10),
                      topRight: Radius.circular(widget.isBot ? 10 : 0),
                      bottomLeft: const Radius.circular(10),
                      bottomRight: const Radius.circular(10),
                    ),
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Text(
                      widget.chatMessages,
                      softWrap: true,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if (!widget.isBot) const Icon(FluentIcons.person_16_regular),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
