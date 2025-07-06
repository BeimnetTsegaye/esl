part of 'registration_page.dart';

class GeneralInfoStep extends StatefulWidget {
  final RegistrationController controller;
  const GeneralInfoStep({super.key, required this.controller});

  @override
  State<GeneralInfoStep> createState() => _GeneralInfoStepState();
}

class _GeneralInfoStepState extends State<GeneralInfoStep> {
  @override
  Widget build(BuildContext context) {
    final bool isConvicted = widget.controller.generalCheckdata.entries.first.value;
    final bool isImpaired = widget.controller.generalCheckdata.entries.last.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('General Information', style: boldTextStyle),
        const SizedBox(height: 10),
        const Text('Language Proficiency', style: boldTextStyle),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.controller.languageControllers.length,
          itemBuilder: (context, index) {
            return _LanguageProficiencyEntry(
              controller: widget.controller.languageControllers[index],
              onRemove: () {
                if (widget.controller.languageControllers.length > 1) {
                  setState(() {
                    widget.controller.languageControllers.removeAt(index);
                  });
                }
              },
              proficiencyLevels: widget.controller.proficiencyLevels,
            );
          },
        ),
        TextButton.icon(
          onPressed: () {
            setState(() {
              widget.controller.languageControllers.add(LanguageProficiencyController());
            });
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Language'),
        ),
        const SizedBox(height: 20),
        CheckPoint(
          data: widget.controller.generalCheckdata.keys.first,
          value: isConvicted,
          onChanged: (value) {
            setState(() {
              widget.controller.generalCheckdata[widget.controller.generalCheckdata.keys.first] = value ?? false;
            });
          },
        ),
        if (isConvicted)
          KTextField(
            controller: widget.controller.convictedCrimeDescriptionController,
            labelText: 'Please describe the crime',
          ),
        const SizedBox(height: 10),
        CheckPoint(
          data: widget.controller.generalCheckdata.keys.last,
          value: isImpaired,
          onChanged: (value) {
            setState(() {
              widget.controller.generalCheckdata[widget.controller.generalCheckdata.keys.last] = value ?? false;
            });
          },
        ),
        if (isImpaired)
          KTextField(
            controller: widget.controller.healthIssueController,
            labelText: 'Please describe the health issue',
          ),
        const SizedBox(height: 20),
        const Text('Goals and Aspirations'),
        KTextField(
          controller: widget.controller.goalsMaritimeAcademyController,
          labelText: 'What are your goals in joining the maritime academy?',
          keyboardType: TextInputType.multiline,
          maxLines: 3,
        ),
        const SizedBox(height: 20),
        KTextField(
          controller: widget.controller.careerAspirationsController,
          labelText: 'Describe your career aspirations 10 years from now.',
          keyboardType: TextInputType.multiline,
          maxLines: 3,
        ),
      ],
    );
  }
}

class _LanguageProficiencyEntry extends StatefulWidget {
  const _LanguageProficiencyEntry({
    required this.controller,
    required this.onRemove,
    required this.proficiencyLevels,
  });

  final LanguageProficiencyController controller;
  final VoidCallback onRemove;
  final List<String> proficiencyLevels;

  @override
  State<_LanguageProficiencyEntry> createState() =>
      __LanguageProficiencyEntryState();
}

class __LanguageProficiencyEntryState extends State<_LanguageProficiencyEntry> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Language', style: boldTextStyle),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: widget.onRemove,
                ),
              ],
            ),
            KTextField(
              controller: widget.controller.languageNameController,
              labelText: 'Language Name (e.g., English)',
            ),
            const SizedBox(height: 10),
            KDropDown(
              items: widget.proficiencyLevels,
              labelText: 'Reading Proficiency',
              onChanged: (value) => setState(() => widget.controller.reading = value),
              selectedValue: widget.controller.reading,
            ),
            const SizedBox(height: 10),
            KDropDown(
              items: widget.proficiencyLevels,
              labelText: 'Writing Proficiency',
              onChanged: (value) => setState(() => widget.controller.writing = value),
              selectedValue: widget.controller.writing,
            ),
            const SizedBox(height: 10),
            KDropDown(
              items: widget.proficiencyLevels,
              labelText: 'Speaking Proficiency',
              onChanged: (value) => setState(() => widget.controller.speaking = value),
              selectedValue: widget.controller.speaking,
            ),
            const SizedBox(height: 10),
            KDropDown(
              items: widget.proficiencyLevels,
              labelText: 'Listening Proficiency',
              onChanged: (value) => setState(() => widget.controller.listening = value),
              selectedValue: widget.controller.listening,
            ),
          ],
        ),
      ),
    );
  }
}

class CheckPoint extends StatelessWidget {
  const CheckPoint({super.key, this.onChanged, this.value, required this.data});
  final ValueChanged<bool?>? onChanged;
  final bool? value;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Expanded(child: Text(data)),
      ],
    );
  }
}
