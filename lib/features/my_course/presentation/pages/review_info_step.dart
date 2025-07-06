part of 'registration_page.dart';

class ReviewInfoStep extends StatelessWidget {
  final RegistrationController controller;
  const ReviewInfoStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Preview Forum Information', style: boldTextStyle),
        const SizedBox(height: 10),
        const Text(
          'Please review all provided information. Ensure personal details, academic background, and uploaded documents are accurate. Changes may require administrative approval after submission.',
          style: TextStyle(color: AppConstants.eslRed),
        ),
        const SizedBox(height: 20),
        ...[
          PersonalInfoStep(controller: controller),
          ContactInfoStep(controller: controller),
          EmergencyContactStep(controller: controller),
          EducationalBackgroundStep(controller: controller),
          EmploymentHistoryStep(controller: controller),
          ReferencesStep(controller: controller),
          GeneralInfoStep(controller: controller),
          ResourceUploadStep(controller: controller),
        ].map(
          (widget) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: widget,
          ),
        ),
      ],
    );
  }
}
