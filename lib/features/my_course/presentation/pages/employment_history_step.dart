part of 'registration_page.dart';

class EmploymentHistoryStep extends StatefulWidget {
  final RegistrationController controller;
  const EmploymentHistoryStep({super.key, required this.controller});

  @override
  State<EmploymentHistoryStep> createState() => _EmploymentHistoryStepState();
}

class _EmploymentHistoryStepState extends State<EmploymentHistoryStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Employment History', style: boldTextStyle),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.controller.employmentHistories.length,
          itemBuilder: (context, index) {
            return _EmploymentHistoryEntry(
              controller: widget.controller.employmentHistories[index],
              onRemove: () {
                if (widget.controller.employmentHistories.length > 1) {
                  setState(() {
                    widget.controller.employmentHistories.removeAt(index);
                  });
                }
              },
            );
          },
        ),
        TextButton.icon(
          onPressed: () {
            setState(() {
              widget.controller.employmentHistories.add(
                EmploymentHistoryController(),
              );
            });
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Employment History'),
        ),
      ],
    );
  }
}

class _EmploymentHistoryEntry extends StatefulWidget {
  const _EmploymentHistoryEntry({
    required this.controller,
    required this.onRemove,
  });

  final EmploymentHistoryController controller;
  final VoidCallback onRemove;

  @override
  State<_EmploymentHistoryEntry> createState() =>
      __EmploymentHistoryEntryState();
}

class __EmploymentHistoryEntryState extends State<_EmploymentHistoryEntry> {
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
              controller: widget.controller.jobTitleController,
              labelText: 'Job Title',
            ),
            KTextField(
              controller: widget.controller.companyNameController,
              labelText: 'Company Name',
            ),
            KDropDown(
              items: EmploymentType.displayNames,
              labelText: 'Employment Type',
              selectedValue: widget.controller.selectedEmploymentType?.displayName,
              onChanged: (value) {
                setState(() {
                  widget.controller.selectedEmploymentType = value != null 
                      ? EmploymentType.fromString(value)
                      : null;
                });
              },
            ),
            const SizedBox(height: 20),
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
            CheckboxListTile(
              title: const Text('Is this your current job?'),
              value: widget.controller.isCurrentJob,
              onChanged: (bool? value) {
                setState(() {
                  widget.controller.isCurrentJob = value ?? false;
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
    if (mounted) {
      setState(() {
        if (isStatedDate) {
          widget.controller.selectedStatedDate = pickedDate;
          widget.controller.statedDateController.text = formatDateToDDMMYYYY(
            pickedDate.toString(),
          );
        } else {
          widget.controller.selectedEndDate = pickedDate;
          widget.controller.endDateController.text = formatDateToDDMMYYYY(
            pickedDate.toString(),
          );
        }
      });
    }
  }
}
