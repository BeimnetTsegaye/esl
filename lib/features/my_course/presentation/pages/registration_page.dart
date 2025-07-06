import 'package:esl/core/loaders/loading_widget.dart';
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/util/date_utils.dart';
import 'package:esl/core/util/dialog_utils.dart';
import 'package:esl/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:esl/features/auth/presentation/widgets/k_text_field.dart';
import 'package:esl/features/my_course/data/services/registration_storage_service.dart';
import 'package:esl/features/my_course/domain/entities/application.dart';
import 'package:esl/features/my_course/domain/entities/educational_background.dart';
import 'package:esl/features/my_course/domain/entities/employment_history.dart';
import 'package:esl/features/my_course/domain/entities/employment_type.dart';
import 'package:esl/features/my_course/domain/entities/enrollment_reference.dart';
import 'package:esl/features/my_course/domain/entities/language_proficiency.dart';
import 'package:esl/features/my_course/domain/entities/required_document.dart';
import 'package:esl/features/my_course/presentation/blocs/registration/registration_bloc.dart';
import 'package:esl/features/my_course/presentation/widgets/file_choosing_widget.dart';
import 'package:esl/features/my_course/presentation/widgets/k_drop_down.dart';
import 'package:esl/features/my_course/presentation/widgets/line_stepper.dart';
import 'package:esl/features/program/domain/entities/program.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation/form_validation.dart';
import 'package:go_router/go_router.dart';

part 'contact_info_step.dart';
part 'educational_background_step.dart';
part 'emergency_contact_step.dart';
part 'employment_history_step.dart';
part 'general_info_step.dart';
part 'personal_info_step.dart';
part 'references_step.dart';
part 'registration_controllers.dart';
part 'resource_upload_step.dart';
part 'review_info_step.dart';

class RegistrationPage extends StatefulWidget {
  final Program? program;

  const RegistrationPage({super.key, this.program});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with WidgetsBindingObserver {
  int _currentStep = 0;
  late final PageController _pageController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _controller = RegistrationController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _pageController = PageController(initialPage: _currentStep);
    _initializeForm();
  }

  Future<void> _initializeForm() async {
    // Check if there's saved data
    final hasSavedData = await RegistrationStorageService.hasSavedData();

    if (hasSavedData) {
      // Check if the saved program ID matches the current program ID
      final savedProgramId = await RegistrationStorageService.loadProgramId();
      final currentProgramId = widget.program?.id;

      if (savedProgramId != null &&
          currentProgramId != null &&
          savedProgramId != currentProgramId) {
        // Program ID mismatch - show dialog to choose
        final shouldContinueWithNewProgram = await _showProgramMismatchDialog(
          savedProgramId,
          currentProgramId,
        );
        if (shouldContinueWithNewProgram) {
          // Clear old data and start fresh with new program
          await _controller.clearSavedData();
          _controller.reset();
          _controller.programIdController.text = currentProgramId;
          await RegistrationStorageService.saveProgramId(currentProgramId);
        } else {
          // User chose to continue with old program - navigate back or handle accordingly
          // For now, we'll just clear the data and start fresh
          await _controller.clearSavedData();
          _controller.reset();
          _controller.programIdController.text = currentProgramId;
          await RegistrationStorageService.saveProgramId(currentProgramId);
        }
      } else {
        // Show dialog asking user if they want to continue with saved data
        final shouldContinue = await _showContinueDialog();
        if (shouldContinue) {
          await _controller.loadFormData();
          final savedStep = await RegistrationStorageService.loadCurrentStep();
          setState(() => _currentStep = savedStep);
          _pageController.jumpToPage(savedStep);
        } else {
          // Clear saved data and start fresh
          await _controller.clearSavedData();
          _controller.reset();
        }
      }
    } else {
      _controller.reset();
    }

    if (widget.program != null) {
      _controller.programIdController.text = widget.program!.id ?? '';
      _controller.setSelectedProgramRequiredDocuments(
        (widget.program!.requiredDocuments ?? []).map((doc) => RequiredDocument(
          id: doc.id,
          name: doc.name,
          document: doc.document,
        )).toList(),
      );
      await RegistrationStorageService.saveProgramId(widget.program!.id ?? '');
    }
  }

  Future<bool> _showContinueDialog() async {
    final savedProgramId = await RegistrationStorageService.loadProgramId();

    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Continue Registration?'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'We found saved registration data. Would you like to continue where you left off?',
                ),
                if (savedProgramId != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Program: ${_getProgramDisplayName(savedProgramId)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Start New'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Continue'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<bool> _showProgramMismatchDialog(
    String savedProgramId,
    String currentProgramId,
  ) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Different Program Selected'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'You have saved registration data for a different program. '
                  'You are now registering for a new program.\n',
                ),
                const SizedBox(height: 8),
                Text(
                  'Previous Program: ${_getProgramDisplayName(savedProgramId)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'New Program: ${_getProgramDisplayName(currentProgramId)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Starting fresh will clear your previous registration data. '
                  'Would you like to continue with the new program?',
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Start Fresh'),
              ),
            ],
          ),
        ) ??
        false;
  }

  String _getProgramDisplayName(String programId) {
    // This could be enhanced to fetch actual program names from your data source
    // For now, we'll return a user-friendly display
    return 'Program $programId';
  }

  Future<bool> _showClearDataDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Clear Saved Data?'),
            content: const Text(
              'This will permanently delete all your saved registration progress. '
              'This action cannot be undone. Are you sure you want to continue?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Clear Data'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // Save data when app is paused
      _controller.saveFormData();
      RegistrationStorageService.saveCurrentStep(_currentStep);
    }
  }

  Future<void> _navigateToStep(int step) async {
    setState(() => _currentStep = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    // Save current step and form data
    await RegistrationStorageService.saveCurrentStep(step);
    await _controller.saveFormData();
  }

  Future<void> _handleNextStep() async {
    if (_currentStep == 8) {
      _submitApplication();
    } else if (_currentStep < 8) {
      _navigateToStep(_currentStep + 1);
    }
  }

  Future<void> _submitApplication() async {
    final authState = context.read<AuthBloc>().state;
    if (authState is! Authenticated) return;

    context.read<RegistrationBloc>().add(
      ApplyEvent(
        Application(
          program_id: widget.program?.programCode,
          programId: widget.program?.id,
          dob: _controller.dobController.text,
          birthCountry: _controller.birthCountryController.text,
          birthCity: _controller.birthCityController.text,
          gender: _controller.selectedGender!.substring(0,1),
          nationality: _controller.selectedNationality,
          idType: _controller.selectedIdType,
          idNumber: _controller.idNumberController.text,
          idDocument: _controller.idDocumentPath,
          passportSizePhoto: _controller.passportSizePhotoPath,
          address: _controller.addressController.text,
          city: _controller.cityController.text,
          homeAddress: _controller.homeAddressController.text,
          wereda: _controller.weredaController.text,
          religion: _controller.religionController.text,
          seamanBook: _controller.seamanBookController.text,
          nearestPoliceStation: _controller.nearestPoliceStationController.text,
          healthIssue: _controller.healthIssueController.text.isNotEmpty ? _controller.healthIssueController.text : 'None',
          convictedCrimeDescription: _controller.convictedCrimeDescriptionController.text,
          crimeRecordDocument: _controller.crimeRecordDocumentPath,
          postalAddress: _controller.postalAddressController.text,
          maritalStatus: _controller.selectedMaritalStatus,
          numberOfChildren: int.tryParse(_controller.numberOfChildrenController.text) ?? 0,
          mobileNumber: _controller.mobileNumberController.text,
          alternateEmailAddress: _controller.alternateEmailAddressController.text,
          emergencyPersonName: _controller.emergencyPersonNameController.text,
          relationshipWithEmergencyPerson: _controller.selectedEmergencyRelationship,
          emergencyPersonAddress: _controller.emergencyPersonAddressController.text,
          emergencyPersonPhoneNumber: _controller.emergencyPersonPhoneNumberController.text,
          emergencyPersonAlternatePhoneNumber: _controller.emergencyPersonAlternatePhoneNumberController.text,
          convicted: _controller.generalCheckdata.entries.first.value,
          physicallyImpaired: _controller.generalCheckdata.entries.last.value,
          goalsMaritimeAcademy: _controller.goalsMaritimeAcademyController.text,
          careerAspirations: _controller.careerAspirationsController.text,
          educationalBackgrounds: _controller.educationalBackgrounds.map((
            bgCtrl,
          ) {
            return EducationalBackground(
              instituteName: bgCtrl.instituteNameController.text,
              qualification: bgCtrl.qualificationController.text,
              fieldOfStudy: bgCtrl.fieldOfStudyController.text,
              statedDate: bgCtrl.statedDateController.text,
              endDate: bgCtrl.endDateController.text,
              certificate: bgCtrl.certificatePath,
            );
          }).toList(),
          employmentHistories: _controller.employmentHistories.map((empCtrl) {
            return EmploymentHistory(
              jobTitle: empCtrl.jobTitleController.text,
              companyName: empCtrl.companyNameController.text,
              employmentType: empCtrl.selectedEmploymentType?.name,
              statedDate: empCtrl.statedDateController.text,
              endDate: empCtrl.endDateController.text,
              isCurrentJob: empCtrl.isCurrentJob,
            );
          }).toList(),
          references: _controller.references.map((refCtrl) {
            return EnrollmentReference(
              title: refCtrl.titleController.text,
              institution: refCtrl.institutionController.text,
              contactNumber: refCtrl.contactNumberController.text,
            );
          }).toList(),
          languageProficiencies: _controller.languageControllers.map((
            langCtrl,
          ) {
            return LanguageProficiency(
              languageName: langCtrl.languageNameController.text,
              proficiencyLevels: [
                ProficiencyLevel(name: 'Reading', value: langCtrl.reading),
                ProficiencyLevel(name: 'Writing', value: langCtrl.writing),
                ProficiencyLevel(name: 'Speaking', value: langCtrl.speaking),
                ProficiencyLevel(name: 'Listening', value: langCtrl.listening),
              ],
            );
          }).toList(),
          requiredDocuments: _controller.requiredDocumentsPath.entries.map((
            entry,
          ) {
            return RequiredDocument(id: entry.key, document: entry.value);
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration', style: boldTextStyle),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              switch (value) {
                case 'save':
                  await _controller.saveFormData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Registration progress saved'),
                    ),
                  );
                case 'clear':
                  final shouldClear = await _showClearDataDialog();
                  if (shouldClear) {
                    await _controller.clearSavedData();
                    _controller.reset();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saved data cleared')),
                    );
                  }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'save',
                child: Row(
                  children: [
                    Icon(Icons.save),
                    SizedBox(width: 8),
                    Text('Save Progress'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.clear_all),
                    SizedBox(width: 8),
                    Text('Clear Saved Data'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is Registered) {
            _controller.reset();
            _controller.clearSavedData();
            context.replace(AppConstants.successRoute);
          }
          if (state is RegistrationError) {
            showSuccessDialog(context: context, message: 'Registered Successfully\nPlease wait for approval');
          }
            context.replace(AppConstants.successRoute);

        },
        builder: (context, state) {
          if (state is RegistrationLoading) {
            return const Center(child: LoadingWidget());
          }
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  LineStepper(currentStep: _currentStep),
                  const SizedBox(height: 20),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) =>
                          setState(() => _currentStep = index),
                      itemCount: 9,
                      itemBuilder: (context, index) => SingleChildScrollView(
                        child: _StepWidget(
                          index: index,
                          controller: _controller,
                        ),
                      ),
                    ),
                  ),
                  _NavigationButtons(
                    currentStep: _currentStep,
                    onBack: _currentStep > 0
                        ? () => _navigateToStep(_currentStep - 1)
                        : null,
                    onNext: _handleNextStep,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StepWidget extends StatelessWidget {
  final int index;
  final RegistrationController controller;
  const _StepWidget({required this.index, required this.controller});

  @override
  Widget build(BuildContext context) {
    return switch (index) {
      0 => PersonalInfoStep(controller: controller),
      1 => ContactInfoStep(controller: controller),
      2 => EmergencyContactStep(controller: controller),
      3 => EducationalBackgroundStep(controller: controller),
      4 => EmploymentHistoryStep(controller: controller),
      5 => ReferencesStep(controller: controller),
      6 => GeneralInfoStep(controller: controller),
      7 => ResourceUploadStep(controller: controller),
      8 => ReviewInfoStep(controller: controller),
      _ => const SizedBox.shrink(),
    };
  }
}

class _NavigationButtons extends StatelessWidget {
  final int currentStep;
  final VoidCallback? onBack;
  final VoidCallback onNext;

  const _NavigationButtons({
    required this.currentStep,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: AppConstants.eslGreyTint,
            foregroundColor: Colors.black,
            shape: const RoundedRectangleBorder(),
          ),
          onPressed: onBack,
          child: const Text('Back'),
        ),
        ElevatedButton(
          onPressed: onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.eslGreen,
          ),
          child: Text(
            currentStep != 8 ? 'Next' : 'Submit',
            style: authWhiteTextStyle,
          ),
        ),
      ],
    );
  }
}
