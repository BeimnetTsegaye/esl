import 'package:esl/core/loaders/loading_widget.dart';
import 'package:esl/core/shared/base_page.dart';
import 'package:esl/core/shared/constants.dart';
import 'package:esl/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:esl/features/home/domain/entities/feedback.dart'
    as feedback_entity;
import 'package:esl/features/home/presentation/blocs/feedback/feedback_bloc.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// Feedback event and state are imported through feedback_bloc.dart
import 'package:flutter/material.dart' hide Feedback;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// Temporary model for API response until we update the Feedback entity
class FeedbackItem {
  final String id;
  final String title;
  final String description;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<FeedbackRecipient> recipients;

  FeedbackItem({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.recipients,
  });

  factory FeedbackItem.fromJson(Map<String, dynamic> json) {
    return FeedbackItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'pending',
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
      recipients: (json['recipients'] as List<dynamic>? ?? [])
          .map((e) => FeedbackRecipient.fromJson(e))
          .toList(),
    );
  }
}

class FeedbackRecipient {
  final FeedbackUser user;

  FeedbackRecipient({required this.user});

  factory FeedbackRecipient.fromJson(Map<String, dynamic> json) {
    return FeedbackRecipient(user: FeedbackUser.fromJson(json['user'] ?? {}));
  }
}

class FeedbackUser {
  final String id;
  final String firstName;
  final String? lastName;
  final String? photo;
  FeedbackUser({
    required this.id,
    required this.firstName,
    this.lastName,
    this.photo,
  });

  factory FeedbackUser.fromJson(Map<String, dynamic> json) {
    return FeedbackUser(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'],
      photo: json['photo'],
    );
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class FeedbackPageWithBase extends StatelessWidget {
  const FeedbackPageWithBase({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(child: FeedbackPage());
  }
}

class _FeedbackPageState extends State<FeedbackPage> {
  int selectedRating = 0;
  final VoidCallback ontap = () => {};
  final TextEditingController _commentController = TextEditingController();
  bool isexpanded = false;

  final List<Map<String, dynamic>> _sampleFeedback = [
    {
      'name': 'Sarah Johnson',
      'date': 'July 2, 2025',
      'comment':
          'The tour was incredibly informative! The library facilities are state-of-the-art and the study spaces look very comfortable.',
      'rating': '5 Stars',
      'avatar': '👩‍🎓',
    },
    {
      'name': 'Michael Brown',
      'date': 'July 2, 2025',
      'comment':
          'Impressed by the sports complex and recreational areas. The campus has excellent facilities for both academics and extracurricular activities.',
      'rating': '5 Stars',
      'avatar': '🏃‍♂️',
    },
    {
      'name': 'Amina Hassan',
      'date': 'July 1, 2025',
      'comment':
          'The botanical garden is absolutely stunning! It\'s wonderful to see such green spaces on campus. Perfect for studying outdoors.',
      'rating': '4 Stars',
      'avatar': '🌿',
    },
    {
      'name': 'David Kim',
      'date': 'June 30, 2025',
      'comment':
          'The maritime training facilities are top-notch! The simulation labs are incredibly realistic and well-equipped.',
      'rating': '5 Stars',
      'avatar': '👨‍✈️',
    },
    {
      'name': 'Elena Rodriguez',
      'date': 'June 29, 2025',
      'comment':
          'The cafeteria has a great variety of food options. Love the lake view while having meals!',
      'rating': '4 Stars',
      'avatar': '🍽️',
    },
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedbackBloc, FeedbackState>(
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
                Card(
                  elevation: 0,
                  color: AppConstants.eslGreyText,
                  child: ExpansionTile(
                    title: Row(
                      children: [
                        Container(
                          color: AppConstants.eslGreyTint,
                          height: 70,
                          child: const Text(
                            'Share Your Thoughts on \n the Campus Tour!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(FluentIcons.link_12_regular, size: 30),
                      ],
                    ),
                    trailing: Icon(
                      isexpanded ? Icons.expand_less : Icons.expand_more,
                      color: Colors.black,
                      size: 35,
                    ),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        isexpanded = expanded;
                      });
                    },
                    children: [
                      Container(
                        color: AppConstants.eslWhite,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            children: [
                              Text(
                                'Let us know what you thought of the Babogaya Maritime and Logistics Academy tour! Did the video capture the beauty of the Lake Babogaya campus and the excitement of maritime training? Drop your feedback below!',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (_sampleFeedback.isNotEmpty) ...[
                                Divider(color: AppConstants.eslGreyTint),

                                const SizedBox(height: 10),
                                ..._sampleFeedback
                                    .map(
                                      (sample) => Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 1.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  child: Text(
                                                    sample['avatar'] ?? '👤',
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  sample['name'] ?? 'User',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const Spacer(),
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.amber,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 16,
                                                          horizontal: 10,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            30,
                                                          ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    sample['rating'],
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              sample['comment'] ?? '',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              sample['date'] ?? '',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const Divider(
                                              color: Colors.grey,
                                              thickness: 0.3,
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ],

                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      // borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                  child: Text(
                                    'Show More',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (index) {
                                  return IconButton(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    icon: Icon(
                                      index < selectedRating
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.black,
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
                              const SizedBox(height: 8),
                              TextField(
                                controller: _commentController,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText:
                                      'Share your thoughts about the tour...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                ),
                              ),

                              const SizedBox(height: 25),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: selectedRating > 0
                                      ? () {
                                          final authState = context
                                              .read<AuthBloc>()
                                              .state;
                                          if (authState is Authenticated) {
                                            context.read<FeedbackBloc>().add(
                                              FeedbackSubmitted(
                                                feedback_entity.Feedback(
                                                  userId: authState.user.id,
                                                  group: feedback_entity
                                                      .FeedbackGroup
                                                      .customer, // Default to guest for now
                                                  rating: selectedRating,
                                                  comment:
                                                      _commentController.text,
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
                                                'comment':
                                                    _commentController.text,
                                                'rating': selectedRating,
                                                'avatar': '👤',
                                              });
                                              _commentController.clear();
                                              selectedRating = 0;
                                            });

                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
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
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      // borderRadius: BorderRadius.circular(0),
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
