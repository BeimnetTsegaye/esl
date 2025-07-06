part of 'registration_page.dart';

class LanguageProficiencyController {
  final languageNameController = TextEditingController();
  String? reading;
  String? writing;
  String? speaking;
  String? listening;
}

class EducationalBackgroundController {
  final instituteNameController = TextEditingController();
  final qualificationController = TextEditingController();
  final fieldOfStudyController = TextEditingController();
  final statedDateController = TextEditingController();
  final endDateController = TextEditingController();
  String? certificatePath;
  DateTime selectedStatedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
}

class EmploymentHistoryController {
  final jobTitleController = TextEditingController();
  final companyNameController = TextEditingController();
  EmploymentType? selectedEmploymentType;
  final statedDateController = TextEditingController();
  final endDateController = TextEditingController();
  bool isCurrentJob = false;
  DateTime selectedStatedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
}

class EnrollmentReferenceController {
  final titleController = TextEditingController();
  final institutionController = TextEditingController();
  final contactNumberController = TextEditingController();
}

class RegistrationController {
  final programIdController = TextEditingController();

  // Personal Info
  final dobController = TextEditingController();
  DateTime selectedDob = DateTime.now();
  String? selectedGender;
  final birthCityController = TextEditingController();
  final birthCountryController = TextEditingController();
  String? selectedIdType;
  final idNumberController = TextEditingController();
  String? selectedNationality;
  final religionController = TextEditingController();
  final seamanBookController = TextEditingController();
  String? idDocumentPath;
  String? passportSizePhotoPath;

  final genderItems = ['Male', 'Female'];
  final idTypeItems = [
    'National ID',
    'Passport',
    'Kebele ID',
    'Driver License',
  ];
  final nationalityItems = ['Ethiopian', 'Foreigner'];

  // Contact Info
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final homeAddressController = TextEditingController();
  final weredaController = TextEditingController();
  final nearestPoliceStationController = TextEditingController();
  String? selectedMaritalStatus;
  final numberOfChildrenController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final alternateEmailAddressController = TextEditingController();
  final postalAddressController = TextEditingController();
  final maritalStatusItems = ['Single', 'Married', 'Divorced', 'Widowed'];

  // Educational Background
  List<EducationalBackgroundController> educationalBackgrounds = [
    EducationalBackgroundController(),
  ];

  // Employment History
  List<EmploymentHistoryController> employmentHistories = [
    EmploymentHistoryController(),
  ];

  // References
  List<EnrollmentReferenceController> references = [
    EnrollmentReferenceController(),
  ];

  // Emergency Contact
  final emergencyPersonNameController = TextEditingController();
  String? selectedEmergencyRelationship;
  final emergencyPersonAddressController = TextEditingController();
  final emergencyPersonPhoneNumberController = TextEditingController();
  final emergencyPersonAlternatePhoneNumberController = TextEditingController();
  final emergencyRelationshipItems = [
    'Father',
    'Mother',
    'Spouse',
    'Sibling',
    'Child',
    'Guardian',
    'Relative',
    'Colleague',
    'Friend',
    'Other',
  ];

  // Resource Upload
  String? crimeRecordDocumentPath;
  final Map<String, String> requiredDocumentsPath = {};
  List<RequiredDocument> selectedProgramRequiredDocuments = [];

  // Method to set the selected program's required documents
  void setSelectedProgramRequiredDocuments(List<RequiredDocument> documents) {
    selectedProgramRequiredDocuments = documents;
  }

  // General Info
  final healthIssueController = TextEditingController();
  final convictedCrimeDescriptionController = TextEditingController();
  final goalsMaritimeAcademyController = TextEditingController();
  final careerAspirationsController = TextEditingController();

  Map<String, bool> generalCheckdata = {
    'Have you ever been convicted of a crime?': false,
    'Do you have any physical disability, impairment or long-term medical condition which may affect your studies?':
        false,
  };

  final List<String> proficiencyLevels = [
    'Basic',
    'Intermediate',
    'Advanced',
    'Native',
  ];
  List<LanguageProficiencyController> languageControllers = [
    LanguageProficiencyController(),
  ];

  //* General Info Step
  final TextEditingController generalCityController = TextEditingController();

  final generalControllers = {
    'Employment Experience – Please provide a brief summary of your previous work experience over the past five years. If applicable, please provide the EMPLOYER NAME, DATES OF EMPLOYMENT, and YOUR POSITION':
        TextEditingController(),
    'Please describe in your own words, what are your goals in joining the maritime academy Note: The response must contain at least 50 words.':
        TextEditingController(),
    'Please describe your plans and aspirations for your career, 10 years from today. Note: The response must contain at least 100 words.':
        TextEditingController(),
  };

  final String resourceLongPolicyText = '''
I hereby declare that the information stated in this application is true and accurate.
I have no commitments or relationships with any institute, government, or private company.
I understand that providing inaccurate information may lead to cancellation and liability for damages.
I authorize EMTI to request my official records from former institutions or employers.
''';

  bool _validateField(
    String? value,
    String label,
    List<ValueValidator> validators,
  ) {
    return Validator(
          validators: validators,
        ).validate(label: label, value: value) ==
        null;
  }

  bool validatePersonalInfo() => [
    _validateField(dobController.text, 'Date of Birth', [
      const RequiredValidator(),
    ]),
    _validateField(birthCityController.text, 'City of Birth', [
      const RequiredValidator(),
    ]),
    _validateField(birthCountryController.text, 'Country of Birth', [
      const RequiredValidator(),
    ]),
    _validateField(idNumberController.text, 'ID Number', [
      const RequiredValidator(),
    ]),
    _validateField(selectedIdType, 'ID Type', [const RequiredValidator()]),
    selectedGender != null,
    selectedNationality != null,
  ].every((isValid) => isValid);

  bool validateContactInfo() => [
    _validateField(addressController.text, 'Address', [
      const RequiredValidator(),
    ]),
    _validateField(cityController.text, 'City', [const RequiredValidator()]),
    _validateField(weredaController.text, 'Wereda', [
      const RequiredValidator(),
    ]),
    _validateField(
      nearestPoliceStationController.text,
      'Nearest Police Station',
      [const RequiredValidator()],
    ),
    _validateField(numberOfChildrenController.text, 'Number of Children', [
      const RequiredValidator(),
      const NumberValidator(),
    ]),
    _validateField(mobileNumberController.text, 'Mobile Number', [
      const RequiredValidator(),
      const PhoneNumberValidator(),
    ]),
    _validateField(alternateEmailAddressController.text, 'Alternate Email', [
      const EmailValidator(),
    ]),
    selectedMaritalStatus != null,
  ].every((isValid) => isValid);

  bool validateEducationalBackground() => [
    _validateField(
      educationalBackgrounds[0].instituteNameController.text,
      'Institute Name',
      [const RequiredValidator()],
    ),
    _validateField(
      educationalBackgrounds[0].statedDateController.text,
      'Enroll Year',
      [const RequiredValidator()],
    ),
    _validateField(
      educationalBackgrounds[0].endDateController.text,
      'Grad Year',
      [const RequiredValidator()],
    ),
    _validateField(
      educationalBackgrounds[0].qualificationController.text,
      'Degree Title',
      [const RequiredValidator()],
    ),
    _validateField(
      educationalBackgrounds[0].fieldOfStudyController.text,
      'Stream',
      [const RequiredValidator()],
    ),
  ].every((isValid) => isValid);

  bool validateEmergencyContact() => [
    _validateField(emergencyPersonNameController.text, 'Full Name', [
      const RequiredValidator(),
    ]),
    _validateField(emergencyPersonAddressController.text, 'Address', [
      const RequiredValidator(),
    ]),
    _validateField(emergencyPersonPhoneNumberController.text, 'Mobile Number', [
      const RequiredValidator(),
    ]),
    selectedEmergencyRelationship != null,
  ].every((isValid) => isValid);

  bool validateResourceUpload() {
    // Check if passport size photo is uploaded
    if (passportSizePhotoPath == null || passportSizePhotoPath!.isEmpty) {
      return false;
    }

    // Check if crime record document is uploaded when convicted
    if (generalCheckdata.entries.first.value &&
        (crimeRecordDocumentPath == null || crimeRecordDocumentPath!.isEmpty)) {
      return false;
    }

    // Check if all required documents from the selected program are uploaded
    for (final doc in selectedProgramRequiredDocuments) {
      if (doc.id != null &&
          (requiredDocumentsPath[doc.id!] == null ||
              requiredDocumentsPath[doc.id!]!.isEmpty)) {
        return false;
      }
    }

    return true;
  }

  bool validateGeneralInfo() => [
    _validateField(generalCityController.text, 'City', [
      const RequiredValidator(),
    ]),
    generalCheckdata.values.every((value) => value == true),
    generalControllers.values.every(
      (controller) => _validateField(controller.text, controller.text, [
        const RequiredValidator(),
      ]),
    ),
  ].every((isValid) => isValid);

  // New comprehensive validation method
  bool validateAllRequiredFields() {
    // Personal Info validation
    if (!validatePersonalInfo()) return false;

    // Contact Info validation
    if (!validateContactInfo()) return false;

    // Educational Background validation
    if (!validateEducationalBackground()) return false;

    // Emergency Contact validation
    if (!validateEmergencyContact()) return false;

    // Resource Upload validation
    if (!validateResourceUpload()) return false;

    // General Info validation
    if (!validateGeneralInfo()) return false;

    // Additional required field validations
    if (programIdController.text.isEmpty) return false;

    // Validate employment histories
    for (final emp in employmentHistories) {
      if (emp.jobTitleController.text.isEmpty ||
          emp.companyNameController.text.isEmpty ||
          emp.selectedEmploymentType == null ||
          emp.statedDateController.text.isEmpty ||
          emp.endDateController.text.isEmpty) {
        return false;
      }
    }

    // Validate references
    for (final ref in references) {
      if (ref.titleController.text.isEmpty ||
          ref.institutionController.text.isEmpty ||
          ref.contactNumberController.text.isEmpty) {
        return false;
      }
    }

    // Validate language proficiencies
    for (final lang in languageControllers) {
      if (lang.languageNameController.text.isEmpty ||
          lang.reading == null ||
          lang.writing == null ||
          lang.speaking == null ||
          lang.listening == null) {
        return false;
      }
    }

    return true;
  }

  // Get validation error messages
  List<String> getValidationErrors() {
    final errors = <String>[];

    // Personal Info errors
    if (dobController.text.isEmpty) errors.add('Date of Birth is required');
    if (birthCityController.text.isEmpty)
      errors.add('City of Birth is required');
    if (birthCountryController.text.isEmpty)
      errors.add('Country of Birth is required');
    if (idNumberController.text.isEmpty) errors.add('ID Number is required');
    if (selectedIdType == null) errors.add('ID Type is required');
    if (selectedGender == null) errors.add('Gender is required');
    if (selectedNationality == null) errors.add('Nationality is required');

    // Contact Info errors
    if (addressController.text.isEmpty) errors.add('Address is required');
    if (cityController.text.isEmpty) errors.add('City is required');
    if (weredaController.text.isEmpty) errors.add('Wereda is required');
    if (nearestPoliceStationController.text.isEmpty)
      errors.add('Nearest Police Station is required');
    if (numberOfChildrenController.text.isEmpty)
      errors.add('Number of Children is required');
    if (mobileNumberController.text.isEmpty)
      errors.add('Mobile Number is required');
    if (selectedMaritalStatus == null) errors.add('Marital Status is required');

    // Emergency Contact errors
    if (emergencyPersonNameController.text.isEmpty)
      errors.add('Emergency Person Name is required');
    if (emergencyPersonAddressController.text.isEmpty)
      errors.add('Emergency Person Address is required');
    if (emergencyPersonPhoneNumberController.text.isEmpty)
      errors.add('Emergency Person Phone Number is required');
    if (selectedEmergencyRelationship == null)
      errors.add('Emergency Relationship is required');

    // Resource Upload errors
    if (passportSizePhotoPath == null || passportSizePhotoPath!.isEmpty) {
      errors.add('Passport Size Photo is required');
    }

    if (generalCheckdata.entries.first.value &&
        (crimeRecordDocumentPath == null || crimeRecordDocumentPath!.isEmpty)) {
      errors.add('Crime Record Document is required when convicted');
    }

    // Program ID error
    if (programIdController.text.isEmpty) errors.add('Program ID is required');

    return errors;
  }

  bool submit() => [
    validatePersonalInfo(),
    validateContactInfo(),
    validateEducationalBackground(),
    validateEmergencyContact(),
    validateResourceUpload(),
    validateGeneralInfo(),
  ].every((isValid) => isValid);

  void reset() {
    // Clear all text controllers
    dobController.clear();
    birthCityController.clear();
    birthCountryController.clear();
    idNumberController.clear();
    religionController.clear();
    seamanBookController.clear();
    addressController.clear();
    cityController.clear();
    homeAddressController.clear();
    weredaController.clear();
    nearestPoliceStationController.clear();
    numberOfChildrenController.clear();
    mobileNumberController.clear();
    alternateEmailAddressController.clear();
    postalAddressController.clear();
    emergencyPersonNameController.clear();
    emergencyPersonAddressController.clear();
    emergencyPersonPhoneNumberController.clear();
    emergencyPersonAlternatePhoneNumberController.clear();
    healthIssueController.clear();
    convictedCrimeDescriptionController.clear();
    goalsMaritimeAcademyController.clear();
    careerAspirationsController.clear();

    // Reset selected values
    selectedDob = DateTime.now();
    selectedGender = null;
    selectedIdType = null;
    selectedNationality = null;
    idDocumentPath = null;
    passportSizePhotoPath = null;
    selectedMaritalStatus = null;
    selectedEmergencyRelationship = null;
    crimeRecordDocumentPath = null;
    requiredDocumentsPath.clear();
    selectedProgramRequiredDocuments.clear();

    // Reset lists
    educationalBackgrounds = [EducationalBackgroundController()];
    languageControllers = [LanguageProficiencyController()];
    employmentHistories = [EmploymentHistoryController()];
    references = [EnrollmentReferenceController()];

    // Reset employment type selections
    for (final empCtrl in employmentHistories) {
      empCtrl.selectedEmploymentType = null;
    }

    // Reset checkboxes
    generalCheckdata.updateAll((key, value) => false);
  }

  void dispose() {
    for (final controller in [
      dobController,
      birthCityController,
      birthCountryController,
      idNumberController,
      religionController,
      seamanBookController,
      addressController,
      cityController,
      homeAddressController,
      weredaController,
      nearestPoliceStationController,
      numberOfChildrenController,
      mobileNumberController,
      alternateEmailAddressController,
      postalAddressController,
      emergencyPersonNameController,
      emergencyPersonAddressController,
      emergencyPersonPhoneNumberController,
      emergencyPersonAlternatePhoneNumberController,
      healthIssueController,
      convictedCrimeDescriptionController,
      goalsMaritimeAcademyController,
      careerAspirationsController,
      ...educationalBackgrounds.expand(
        (c) => [
          c.instituteNameController,
          c.qualificationController,
          c.fieldOfStudyController,
          c.statedDateController,
          c.endDateController,
        ],
      ),
      ...languageControllers.map((c) => c.languageNameController),
      ...employmentHistories.expand(
        (c) => [
          c.jobTitleController,
          c.companyNameController,
          c.statedDateController,
          c.endDateController,
        ],
      ),
      ...references.expand(
        (c) => [
          c.titleController,
          c.institutionController,
          c.contactNumberController,
        ],
      ),
    ]) {
      controller.dispose();
    }
  }

  // Save form data to local storage
  Future<void> saveFormData() async {
    final formData = {
      // Personal Info
      'dob': dobController.text,
      'selectedDob': selectedDob.toIso8601String(),
      'selectedGender': selectedGender,
      'birthCity': birthCityController.text,
      'birthCountry': birthCountryController.text,
      'selectedIdType': selectedIdType,
      'idNumber': idNumberController.text,
      'selectedNationality': selectedNationality,
      'religion': religionController.text,
      'seamanBook': seamanBookController.text,
      'idDocumentPath': idDocumentPath,
      'passportSizePhotoPath': passportSizePhotoPath,

      // Contact Info
      'address': addressController.text,
      'city': cityController.text,
      'homeAddress': homeAddressController.text,
      'wereda': weredaController.text,
      'nearestPoliceStation': nearestPoliceStationController.text,
      'selectedMaritalStatus': selectedMaritalStatus,
      'numberOfChildren': numberOfChildrenController.text,
      'mobileNumber': mobileNumberController.text,
      'alternateEmailAddress': alternateEmailAddressController.text,
      'postalAddress': postalAddressController.text,

      // Emergency Contact
      'emergencyPersonName': emergencyPersonNameController.text,
      'selectedEmergencyRelationship': selectedEmergencyRelationship,
      'emergencyPersonAddress': emergencyPersonAddressController.text,
      'emergencyPersonPhoneNumber': emergencyPersonPhoneNumberController.text,
      'emergencyPersonAlternatePhoneNumber':
          emergencyPersonAlternatePhoneNumberController.text,

      // Resource Upload
      'crimeRecordDocumentPath': crimeRecordDocumentPath,
      'requiredDocumentsPath': requiredDocumentsPath,
      'selectedProgramRequiredDocuments': selectedProgramRequiredDocuments
          .map(
            (doc) => {
              'id': doc.id,
              'name': doc.name,
              'description': doc.description,
            },
          )
          .toList(),

      // General Info
      'healthIssue': healthIssueController.text,
      'convictedCrimeDescription': convictedCrimeDescriptionController.text,
      'goalsMaritimeAcademy': goalsMaritimeAcademyController.text,
      'careerAspirations': careerAspirationsController.text,
      'generalCheckdata': generalCheckdata,

      // Educational Backgrounds
      'educationalBackgrounds': educationalBackgrounds
          .map(
            (bg) => {
              'instituteName': bg.instituteNameController.text,
              'qualification': bg.qualificationController.text,
              'fieldOfStudy': bg.fieldOfStudyController.text,
              'statedDate': bg.statedDateController.text,
              'endDate': bg.endDateController.text,
              'certificatePath': bg.certificatePath,
              'selectedStatedDate': bg.selectedStatedDate.toIso8601String(),
              'selectedEndDate': bg.selectedEndDate.toIso8601String(),
            },
          )
          .toList(),

      // Employment Histories
      'employmentHistories': employmentHistories
          .map(
            (emp) => {
              'jobTitle': emp.jobTitleController.text,
              'companyName': emp.companyNameController.text,
              'selectedEmploymentType': emp.selectedEmploymentType?.name,
              'statedDate': emp.statedDateController.text,
              'endDate': emp.endDateController.text,
              'isCurrentJob': emp.isCurrentJob,
              'selectedStatedDate': emp.selectedStatedDate.toIso8601String(),
              'selectedEndDate': emp.selectedEndDate.toIso8601String(),
            },
          )
          .toList(),

      // References
      'references': references
          .map(
            (ref) => {
              'title': ref.titleController.text,
              'institution': ref.institutionController.text,
              'contactNumber': ref.contactNumberController.text,
            },
          )
          .toList(),

      // Language Proficiencies
      'languageControllers': languageControllers
          .map(
            (lang) => {
              'languageName': lang.languageNameController.text,
              'reading': lang.reading,
              'writing': lang.writing,
              'speaking': lang.speaking,
              'listening': lang.listening,
            },
          )
          .toList(),
    };

    await RegistrationStorageService.saveFormData(formData);
  }

  // Load form data from local storage
  Future<void> loadFormData() async {
    final formData = await RegistrationStorageService.loadFormData();
    if (formData == null) return;

    // Personal Info
    dobController.text = (formData['dob'] as String?) ?? '';
    selectedDob =
        DateTime.tryParse((formData['selectedDob'] as String?) ?? '') ??
        DateTime.now();
    selectedGender = formData['selectedGender'] as String?;
    birthCityController.text = (formData['birthCity'] as String?) ?? '';
    birthCountryController.text = (formData['birthCountry'] as String?) ?? '';
    selectedIdType = formData['selectedIdType'] as String?;
    idNumberController.text = (formData['idNumber'] as String?) ?? '';
    selectedNationality = formData['selectedNationality'] as String?;
    religionController.text = (formData['religion'] as String?) ?? '';
    seamanBookController.text = (formData['seamanBook'] as String?) ?? '';
    idDocumentPath = formData['idDocumentPath'] as String?;
    passportSizePhotoPath = formData['passportSizePhotoPath'] as String?;

    // Contact Info
    addressController.text = (formData['address'] as String?) ?? '';
    cityController.text = (formData['city'] as String?) ?? '';
    homeAddressController.text = (formData['homeAddress'] as String?) ?? '';
    weredaController.text = (formData['wereda'] as String?) ?? '';
    nearestPoliceStationController.text =
        (formData['nearestPoliceStation'] as String?) ?? '';
    selectedMaritalStatus = formData['selectedMaritalStatus'] as String?;
    numberOfChildrenController.text =
        (formData['numberOfChildren'] as String?) ?? '';
    mobileNumberController.text = (formData['mobileNumber'] as String?) ?? '';
    alternateEmailAddressController.text =
        (formData['alternateEmailAddress'] as String?) ?? '';
    postalAddressController.text = (formData['postalAddress'] as String?) ?? '';

    // Emergency Contact
    emergencyPersonNameController.text =
        (formData['emergencyPersonName'] as String?) ?? '';
    selectedEmergencyRelationship =
        formData['selectedEmergencyRelationship'] as String?;
    emergencyPersonAddressController.text =
        (formData['emergencyPersonAddress'] as String?) ?? '';
    emergencyPersonPhoneNumberController.text =
        (formData['emergencyPersonPhoneNumber'] as String?) ?? '';
    emergencyPersonAlternatePhoneNumberController.text =
        (formData['emergencyPersonAlternatePhoneNumber'] as String?) ?? '';

    // Resource Upload
    crimeRecordDocumentPath = formData['crimeRecordDocumentPath'] as String?;
    requiredDocumentsPath.clear();
    if (formData['requiredDocumentsPath'] != null) {
      requiredDocumentsPath.addAll(
        Map<String, String>.from(formData['requiredDocumentsPath'] as Map),
      );
    }

    // Load selected program required documents
    selectedProgramRequiredDocuments.clear();
    if (formData['selectedProgramRequiredDocuments'] != null) {
      final docs = formData['selectedProgramRequiredDocuments'] as List;
      for (final doc in docs) {
        selectedProgramRequiredDocuments.add(
          RequiredDocument(
            id: doc['id'] as String?,
            name: doc['name'] as String?,
          ),
        );
      }
    }

    // General Info
    healthIssueController.text = (formData['healthIssue'] as String?) ?? '';
    convictedCrimeDescriptionController.text =
        (formData['convictedCrimeDescription'] as String?) ?? '';
    goalsMaritimeAcademyController.text =
        (formData['goalsMaritimeAcademy'] as String?) ?? '';
    careerAspirationsController.text =
        (formData['careerAspirations'] as String?) ?? '';
    if (formData['generalCheckdata'] != null) {
      generalCheckdata.clear();
      generalCheckdata.addAll(
        Map<String, bool>.from(formData['generalCheckdata'] as Map),
      );
    }

    // Educational Backgrounds
    if (formData['educationalBackgrounds'] != null) {
      final backgrounds = formData['educationalBackgrounds'] as List;
      educationalBackgrounds.clear();
      for (final bg in backgrounds) {
        final controller = EducationalBackgroundController();
        controller.instituteNameController.text =
            (bg['instituteName'] as String?) ?? '';
        controller.qualificationController.text =
            (bg['qualification'] as String?) ?? '';
        controller.fieldOfStudyController.text =
            (bg['fieldOfStudy'] as String?) ?? '';
        controller.statedDateController.text =
            (bg['statedDate'] as String?) ?? '';
        controller.endDateController.text = (bg['endDate'] as String?) ?? '';
        controller.certificatePath = bg['certificatePath'] as String?;
        controller.selectedStatedDate =
            DateTime.tryParse((bg['selectedStatedDate'] as String?) ?? '') ??
            DateTime.now();
        controller.selectedEndDate =
            DateTime.tryParse((bg['selectedEndDate'] as String?) ?? '') ??
            DateTime.now();
        educationalBackgrounds.add(controller);
      }
    }

    // Employment Histories
    if (formData['employmentHistories'] != null) {
      final histories = formData['employmentHistories'] as List;
      employmentHistories.clear();
      for (final emp in histories) {
        final controller = EmploymentHistoryController();
        controller.jobTitleController.text = (emp['jobTitle'] as String?) ?? '';
        controller.companyNameController.text =
            (emp['companyName'] as String?) ?? '';
        controller.selectedEmploymentType =
            emp['selectedEmploymentType'] != null
            ? EmploymentType.values.firstWhere(
                (e) => e.name == (emp['selectedEmploymentType'] as String),
                orElse: () => EmploymentType.fullTime,
              )
            : null;
        controller.statedDateController.text =
            (emp['statedDate'] as String?) ?? '';
        controller.endDateController.text = (emp['endDate'] as String?) ?? '';
        controller.isCurrentJob = emp['isCurrentJob'] as bool? ?? false;
        controller.selectedStatedDate =
            DateTime.tryParse((emp['selectedStatedDate'] as String?) ?? '') ??
            DateTime.now();
        controller.selectedEndDate =
            DateTime.tryParse((emp['selectedEndDate'] as String?) ?? '') ??
            DateTime.now();
        employmentHistories.add(controller);
      }
    }

    // References
    if (formData['references'] != null) {
      final refs = formData['references'] as List;
      references.clear();
      for (final ref in refs) {
        final controller = EnrollmentReferenceController();
        controller.titleController.text = (ref['title'] as String?) ?? '';
        controller.institutionController.text =
            (ref['institution'] as String?) ?? '';
        controller.contactNumberController.text =
            (ref['contactNumber'] as String?) ?? '';
        references.add(controller);
      }
    }

    // Language Proficiencies
    if (formData['languageControllers'] != null) {
      final langs = formData['languageControllers'] as List;
      languageControllers.clear();
      for (final lang in langs) {
        final controller = LanguageProficiencyController();
        controller.languageNameController.text =
            (lang['languageName'] as String?) ?? '';
        controller.reading = lang['reading'] as String?;
        controller.writing = lang['writing'] as String?;
        controller.speaking = lang['speaking'] as String?;
        controller.listening = lang['listening'] as String?;
        languageControllers.add(controller);
      }
    }
  }

  // Clear saved form data
  Future<void> clearSavedData() async {
    await RegistrationStorageService.clearRegistrationData();
  }
}
