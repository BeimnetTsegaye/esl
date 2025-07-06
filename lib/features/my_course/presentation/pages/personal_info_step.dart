part of 'registration_page.dart';

class PersonalInfoStep extends StatefulWidget {
  final RegistrationController controller;
  const PersonalInfoStep({super.key, required this.controller});

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoStep> {
  @override
  void initState() {
    super.initState();
    if (widget.controller.dobController.text.isEmpty) {
      widget.controller.dobController.text = formatDateToDDMMYYYY(
        widget.controller.selectedDob.toString(),
      );
    }
  }

  Future<void> _pickDate() async {
    final pickedDate = await datePickerDialog(
      context: context,
      selectedDate: widget.controller.selectedDob,
    );
    if (mounted) {
      setState(() {
        widget.controller.selectedDob = pickedDate;
        widget.controller.dobController.text =
            formatDateToDDMMYYYY(pickedDate.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Personal Information', style: boldTextStyle),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style: authGreyTextStyle,
            children: [
              const TextSpan(text: 'Please contact '),
              TextSpan(
                text: 'registral@bmla.com',
                style: underlinedTextStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Handle email tap
                    //  launchUrl(Uri(
                    //    scheme: 'mailto',
                    //    path: 'registral@esles.com',
                    //  ));
                  },
              ),
              const TextSpan(
                text:
                    ' if you have any questions or concerns regarding the online application.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
       
        TextField(
          controller: widget.controller.dobController,
          readOnly: true,
          enableInteractiveSelection: false,
          onTap: _pickDate,
          decoration: InputDecoration(
            labelText: 'Date of Birth',
            suffixIcon: IconButton(
              icon: const Icon(FluentIcons.calendar_24_regular),
              onPressed: _pickDate,
            ),
          ),
        ),
        const SizedBox(height: 20),
        KTextField(
          controller: widget.controller.birthCountryController,
          labelText: 'Country of Birth',
        ),
        KTextField(
          controller: widget.controller.birthCityController,
          labelText: 'City of Birth',
        ),
        KDropDown(
          items: widget.controller.genderItems,
          labelText: 'Select Gender',
          selectedValue: widget.controller.selectedGender,
          onChanged: (String? value) {
            setState(() {
              widget.controller.selectedGender = value;
            });
          },
        ),
        const SizedBox(height: 20),
        KDropDown(
          items: widget.controller.nationalityItems,
          labelText: 'Select Nationality',
          selectedValue: widget.controller.selectedNationality,
          onChanged: (String? value) {
            setState(() {
              widget.controller.selectedNationality = value;
            });
          },
        ),
        const SizedBox(height: 20),
        KDropDown(
          items: widget.controller.idTypeItems,
          labelText: 'Select ID Type',
          selectedValue: widget.controller.selectedIdType,
          onChanged: (String? value) {
            setState(() {
              widget.controller.selectedIdType = value;
            });
          },
        ),
        const SizedBox(height: 20),
        KTextField(
          controller: widget.controller.idNumberController,
          labelText: 'ID Number',
        ),
        FileChoosingWidget(
          title: 'Upload ID Document',
          selectedFile: widget.controller.idDocumentPath ?? '',
          onFilePicked: (path) {
            setState(() {
              widget.controller.idDocumentPath = path;
            });
          },
        ),
        const SizedBox(height: 20),
        KTextField(
          controller: widget.controller.religionController,
          labelText: 'Religion',
        ),
        KTextField(
          controller: widget.controller.seamanBookController,
          labelText: 'Seaman Book Number (If you have one)',
        ),
      ],
    );
  }
}
