import 'package:esl/core/loaders/loading_widget.dart';
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:esl/features/home/domain/entities/feedback.dart';
import 'package:esl/features/home/presentation/blocs/feedback/feedback_bloc.dart';
import 'package:flutter/material.dart' hide Feedback;
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int selectedRating = 0;
  FeedbackGroup? selectedGroup;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FeedbackBloc, FeedbackState>(
        listener: (context, state) {
          if (state is FeedbackSubmittedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Feedback submitted successfully')),
            );
            Navigator.pop(context);
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
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text('We value your Feedback', style: boldTextStyle),
              const SizedBox(height: 16),
              const Text(
                '''At ESL, your voice matters. Whether you're a student navigating your academic journey, a staff member contributing to our mission, or a guest exploring our services, we welcome your feedback. Your insights help us enhance our programs, services, and community.''',
              ),
              const SizedBox(height: 16),
              const Text('Please select the group that best describes you:'),
              const SizedBox(height: 16),
              DropdownButtonFormField<FeedbackGroup>(
                value: selectedGroup,
                items: FeedbackGroup.values.map((group) {
                  return DropdownMenuItem(
                    value: group,
                    child: Text(group.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (FeedbackGroup? value) {
                  setState(() {
                    selectedGroup = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select One',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Rate your overall experience with us'),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      index < selectedRating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedRating = index + 1;
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 16),
              const Text('Tell us more'),
              const SizedBox(height: 16),
              TextField(
                controller: _commentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText:
                      'Was there a specific service or interaction you’d like to highlight?\nAre there areas where we can do better?\nSuggestions, complaints, or words of encouragement are all welcome!',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (selectedGroup == null || selectedRating == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please select a group and provide a rating',
                        ),
                      ),
                    );
                    return;
                  }
                  final authState = context.read<AuthBloc>().state;
                  if (authState is Authenticated) {
                    context.read<FeedbackBloc>().add(
                      FeedbackSubmitted(
                        Feedback(
                          userId: authState.user.id,
                          group: selectedGroup!,
                          rating: selectedRating,
                          comment: _commentController.text,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please login to submit feedback'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.eslGreen,
                ),
                child: const Text(
                  'Submit Feedback',
                  style: TextStyle(color: AppConstants.eslWhite),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
