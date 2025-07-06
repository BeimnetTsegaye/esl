part of 'registration_page.dart';

class EmergencyContactStep extends StatefulWidget {
  final RegistrationController controller;
  const EmergencyContactStep({super.key, required this.controller});

  @override
  State<EmergencyContactStep> createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContactStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Emergency Contact Information', style: boldTextStyle),
        const SizedBox(height: 10),
        KDropDown(
          items: widget.controller.emergencyRelationshipItems,
          labelText: 'Relationship',
          selectedValue: widget.controller.selectedEmergencyRelationship,
          onChanged: (value) {
            setState(() {
              widget.controller.selectedEmergencyRelationship = value;
            });
          },
        ),
        const SizedBox(height: 20),
        KTextField(
          controller: widget.controller.emergencyPersonNameController,
          labelText: 'Full Name',
          keyboardType: TextInputType.name,
        ),
        KTextField(
          controller: widget.controller.emergencyPersonAddressController,
          labelText: 'Address(Region/City/Kebele)',
          keyboardType: TextInputType.streetAddress,
        ),
        KTextField(
          controller: widget.controller.emergencyPersonPhoneNumberController,
          labelText: 'Mobile Number',
          keyboardType: TextInputType.phone,
        ),
        KTextField(
          controller: widget.controller.emergencyPersonAlternatePhoneNumberController,
          labelText: 'Alternate Mobile Number',
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}
