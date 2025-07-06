part of 'registration_page.dart';

class ReferencesStep extends StatefulWidget {
  final RegistrationController controller;
  const ReferencesStep({super.key, required this.controller});

  @override
  State<ReferencesStep> createState() => _ReferencesStepState();
}

class _ReferencesStepState extends State<ReferencesStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('References', style: boldTextStyle),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.controller.references.length,
          itemBuilder: (context, index) {
            return _ReferenceEntry(
              controller: widget.controller.references[index],
              onRemove: () {
                if (widget.controller.references.length > 1) {
                  setState(() {
                    widget.controller.references.removeAt(index);
                  });
                }
              },
            );
          },
        ),
        TextButton.icon(
          onPressed: () {
            setState(() {
              widget.controller.references.add(EnrollmentReferenceController());
            });
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Reference'),
        ),
      ],
    );
  }
}

class _ReferenceEntry extends StatefulWidget {
  const _ReferenceEntry({
    required this.controller,
    required this.onRemove,
  });

  final EnrollmentReferenceController controller;
  final VoidCallback onRemove;

  @override
  State<_ReferenceEntry> createState() => __ReferenceEntryState();
}

class __ReferenceEntryState extends State<_ReferenceEntry> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: widget.onRemove,
                ),
              ],
            ),
            KTextField(
              controller: widget.controller.titleController,
              labelText: 'Title/Name',
            ),
            KTextField(
              controller: widget.controller.institutionController,
              labelText: 'Institution/Company',
            ),
            KTextField(
              controller: widget.controller.contactNumberController,
              labelText: 'Contact Number',
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
} 