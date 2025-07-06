part of 'registration_page.dart';

class ResourceUploadStep extends StatefulWidget {
  final RegistrationController controller;
  const ResourceUploadStep({super.key, required this.controller});

  @override
  State<ResourceUploadStep> createState() => _ResourceUploadStepState();
}

class _ResourceUploadStepState extends State<ResourceUploadStep> {
  @override
  Widget build(BuildContext context) {
    final bool isConvicted = widget.controller.generalCheckdata.entries.first.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Upload Required Documents', style: boldTextStyle),
        const SizedBox(height: 20),
        FileChoosingWidget(
          selectedFile: widget.controller.passportSizePhotoPath ?? '',
          title: 'Passport Size Photo',
          onFilePicked: (path) {
            setState(() {
              widget.controller.passportSizePhotoPath = path;
            });
          },
        ),
        if (isConvicted)
          FileChoosingWidget(
            selectedFile: widget.controller.crimeRecordDocumentPath ?? '',
            title: 'Crime Record Document',
            onFilePicked: (path) {
              setState(() {
                widget.controller.crimeRecordDocumentPath = path;
              });
            },
          ),
        // Display required documents from the selected program
        ...widget.controller.selectedProgramRequiredDocuments.map(
          (doc) => FileChoosingWidget(
            selectedFile: widget.controller.requiredDocumentsPath[doc.id!] ?? '',
            title: doc.name ?? 'Required Document',
            onFilePicked: (path) {
              setState(() {
                if (doc.id != null) {
                  widget.controller.requiredDocumentsPath[doc.id!] = path;
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
