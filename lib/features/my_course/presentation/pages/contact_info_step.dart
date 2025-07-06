part of 'registration_page.dart';

class ContactInfoStep extends StatefulWidget {
  final RegistrationController controller;
  const ContactInfoStep({super.key, required this.controller});

  @override
  State<ContactInfoStep> createState() => _ContactInfoStepState();
}

class _ContactInfoStepState extends State<ContactInfoStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Contact Information', style: boldTextStyle),
        const SizedBox(height: 10),
        KTextField(
          controller: widget.controller.addressController,
          labelText: 'Address',
          keyboardType: TextInputType.streetAddress,
        ),
        KTextField(
          controller: widget.controller.cityController,
          labelText: 'City',
        ),
        KTextField(
          controller: widget.controller.homeAddressController,
          labelText: 'Home Address',
          keyboardType: TextInputType.streetAddress,
        ),
        KTextField(
          controller: widget.controller.weredaController,
          labelText: 'Wereda',
        ),
        KTextField(
          controller: widget.controller.nearestPoliceStationController,
          labelText: 'Nearest Police Station',
        ),
        KDropDown(
          items: widget.controller.maritalStatusItems,
          labelText: 'Marital Status',
          selectedValue: widget.controller.selectedMaritalStatus,
          onChanged: (value) {
            setState(() {
              widget.controller.selectedMaritalStatus = value;
            });
          },
        ),
        const SizedBox(height: 20),
        KTextField(
          controller: widget.controller.numberOfChildrenController,
          labelText: 'Number of Children',
          keyboardType: TextInputType.number,
        ),
        KTextField(
          controller: widget.controller.mobileNumberController,
          labelText: 'Mobile Number',
          keyboardType: TextInputType.phone,
        ),
        KTextField(
          controller: widget.controller.alternateEmailAddressController,
          labelText: 'Alternate Email Address',
          keyboardType: TextInputType.emailAddress,
        ),
        KTextField(
          controller: widget.controller.postalAddressController,
          labelText: 'Postal Address',
          keyboardType: TextInputType.streetAddress,
        ),
      ],
    );
  }
}
