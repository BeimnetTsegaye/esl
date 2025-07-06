part of 'registration_page.dart';

class EducationalBackgroundStep extends StatefulWidget {
  final RegistrationController controller;
  const EducationalBackgroundStep({super.key, required this.controller});

  @override
  State<EducationalBackgroundStep> createState() =>
      _EducationalBackgroundStepState();
}

class _EducationalBackgroundStepState extends State<EducationalBackgroundStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Educational Background', style: boldTextStyle),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.controller.educationalBackgrounds.length,
          itemBuilder: (context, index) {
            return _EducationalBackgroundEntry(
              controller: widget.controller.educationalBackgrounds[index],
              onRemove: () {
                if (widget.controller.educationalBackgrounds.length > 1) {
                  setState(() {
                    widget.controller.educationalBackgrounds.removeAt(index);
                  });
                }
              },
            );
          },
        ),
        TextButton.icon(
          onPressed: () {
            setState(() {
              widget.controller.educationalBackgrounds
                  .add(EducationalBackgroundController());
            });
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Educational Background'),
        ),
      ],
    );
  }
}

class _EducationalBackgroundEntry extends StatefulWidget {
  const _EducationalBackgroundEntry({
    required this.controller,
    required this.onRemove,
  });

  final EducationalBackgroundController controller;
  final VoidCallback onRemove;

  @override
  State<_EducationalBackgroundEntry> createState() =>
      __EducationalBackgroundEntryState();
}

class __EducationalBackgroundEntryState
    extends State<_EducationalBackgroundEntry> {
  @override
  void initState() {
    super.initState();
    widget.controller.statedDateController.text = formatDateToDDMMYYYY(
      widget.controller.selectedStatedDate.toString(),
    );
    widget.controller.endDateController.text = formatDateToDDMMYYYY(
      widget.controller.selectedEndDate.toString(),
    );
  }

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
              controller: widget.controller.instituteNameController,
              labelText: 'Institute Name',
            ),
            KTextField(
              controller: widget.controller.qualificationController,
              labelText: 'Qualification (e.g., BSc, MSc)',
            ),
            KTextField(
              controller: widget.controller.fieldOfStudyController,
              labelText: 'Field of Study',
            ),
            TextField(
              controller: widget.controller.statedDateController,
              readOnly: true,
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                labelText: 'Start Date',
                suffixIcon: IconButton(
                  icon: const Icon(FluentIcons.calendar_24_regular),
                  onPressed: () => _pickDate(isStatedDate: true),
                ),
              ),
              onTap: () => _pickDate(isStatedDate: true),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: widget.controller.endDateController,
              readOnly: true,
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                labelText: 'End Date',
                suffixIcon: IconButton(
                  icon: const Icon(FluentIcons.calendar_24_regular),
                  onPressed: () => _pickDate(isStatedDate: false),
                ),
              ),
              onTap: () => _pickDate(isStatedDate: false),
            ),
            const SizedBox(height: 20),
            FileChoosingWidget(
              title: 'Upload Certificate',
              selectedFile: widget.controller.certificatePath ?? '',
              onFilePicked: (path) {
                setState(() {
                  widget.controller.certificatePath = path;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate({required bool isStatedDate}) async {
    final pickedDate = await datePickerDialog(
      context: context,
      selectedDate: isStatedDate
          ? widget.controller.selectedStatedDate
          : widget.controller.selectedEndDate,
    );
    setState(() {
      if (isStatedDate) {
        widget.controller.selectedStatedDate = pickedDate;
        widget.controller.statedDateController.text =
            formatDateToDDMMYYYY(pickedDate.toString());
      } else {
        widget.controller.selectedEndDate = pickedDate;
        widget.controller.endDateController.text =
            formatDateToDDMMYYYY(pickedDate.toString());
      }
    });
  }
}
