import 'package:esl/core/loaders/loading_widget.dart';
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:esl/features/home/domain/entities/feedback.dart';
import 'package:esl/features/home/presentation/blocs/feedback/feedback_bloc.dart';
import 'package:flutter/material.dart' hide Feedback;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int selectedRating = 0;
  bool _isExpanded1 = false;
  bool _isExpanded2 = false;
  final TextEditingController _commentController = TextEditingController();

  // Sample feedback data - in a real app, this would come from your backend
  final List<Map<String, dynamic>> _sampleFeedback = [
    {
      'name': 'Sara Abreham',
      'date': 'July 2, 2025',
      'comment':
          'Loved the tour! Lake Babogaya is stunning, and the facilities look modern. Great job!',
      'rating': 5,
      'avatar': '👩',
    },
    {
      'name': 'John Doe',
      'date': 'July 1, 2025',
      'comment':
          'The campus is beautiful and well-maintained. The tour guide was very knowledgeable.',
      'rating': 4,
      'avatar': '👨',
    },
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('h:mm a, MMM d').format(now);

    return Scaffold(
      body: BlocConsumer<FeedbackBloc, FeedbackState>(
        listener: (context, state) {
          if (state is FeedbackSubmittedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Feedback submitted successfully')),
            );
            setState(() {
              _sampleFeedback.insert(0, {
                'name': 'You',
                'date': DateFormat('MMMM d, y').format(DateTime.now()),
                'comment': _commentController.text,
                'rating': selectedRating,
                'avatar': '😊',
              });
              _commentController.clear();
              selectedRating = 0;
            });
          } else if (state is ErrorFeedbackState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is LoadingFeedbackState) {
            return const Center(child: LoadingWidget());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with time and notification
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formattedDate, style: const TextStyle(fontSize: 16)),
                      const Icon(Icons.notifications_none, size: 28),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Greeting
                  const Text(
                    'Hello, User!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 30),

                  // Title
                  const Text(
                    'Share Your Thoughts on the Campus Tour!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'We\'d love to hear about your experience touring the Babogaya Maritime and Logistics Academy. Your feedback helps us improve!',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),

                  const SizedBox(height: 30),

                  // Existing feedback section
                  if (_sampleFeedback.isNotEmpty) ...[
                    const Text(
                      'What others are saying:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ..._sampleFeedback
                        .map((feedback) => _buildFeedbackCard(feedback))
                        .toList(),
                    const SizedBox(height: 30),
                  ],

                  // Feedback form
                  const Text(
                    'Share your experience',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  // Star rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        icon: Icon(
                          index < selectedRating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 36,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedRating = index + 1;
                          });
                        },
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  // Comment field
                  const Text(
                    'Comment',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _commentController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Share your thoughts about the tour...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: selectedRating > 0
                          ? () {
                              final authState = context.read<AuthBloc>().state;
                              if (authState is Authenticated) {
                                context.read<FeedbackBloc>().add(
                                  FeedbackSubmitted(
                                    Feedback(
                                      userId: authState.user.id,
                                      group: FeedbackGroup
                                          .customer, // Default to guest for now
                                      rating: selectedRating,
                                      comment: _commentController.text,
                                    ),
                                  ),
                                );
                              } else {
                                // If not logged in, just add to the sample list
                                setState(() {
                                  _sampleFeedback.insert(0, {
                                    'name': 'Guest User',
                                    'date': DateFormat(
                                      'MMMM d, y',
                                    ).format(DateTime.now()),
                                    'comment': _commentController.text,
                                    'rating': selectedRating,
                                    'avatar': '👤',
                                  });
                                  _commentController.clear();
                                  selectedRating = 0;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Feedback submitted as guest',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Submit Feedback',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Accordion sections
                  _buildAccordion(
                    title: 'Did We Explain the Programs Well?',
                    isExpanded: _isExpanded1,
                    onTap: () {
                      setState(() {
                        _isExpanded1 = !_isExpanded1;
                      });
                    },
                    child: const Text(
                      'We strive to provide clear and comprehensive information about all our programs. Your feedback helps us improve our explanations and materials.',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),

                  const SizedBox(height: 15),

                  _buildAccordion(
                    title: 'Inspired to Join the Maritime World?',
                    isExpanded: _isExpanded2,
                    onTap: () {
                      setState(() {
                        _isExpanded2 = !_isExpanded2;
                      });
                    },
                    child: const Text(
                      'If you are interested in pursuing a career in the maritime industry, we would love to help you take the next steps. Contact us for more information about our programs and admission process.',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeedbackCard(Map<String, dynamic> feedback) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(child: Text(feedback['avatar'] ?? '👤')),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feedback['name'] ?? 'Anonymous',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        feedback['date'] ?? '',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              feedback['comment'] ?? '',
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[100],
                foregroundColor: Colors.amber[800],
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('${feedback['rating']} Stars'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccordion({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        trailing: Icon(
          isExpanded ? Icons.expand_less : Icons.expand_more,
          color: Colors.grey,
        ),
        onExpansionChanged: (bool expanded) {
          onTap();
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: child,
          ),
        ],
      ),
    );
  }
}
