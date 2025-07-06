import 'package:flutter/material.dart';
import 'package:flutter_lexical_reader/flutter_lexical_reader.dart';

class LexicalDescriptionView extends StatelessWidget {
  final Map<String, dynamic>? description;

  const LexicalDescriptionView({super.key, this.description});

  @override
  Widget build(BuildContext context) {
    if (description == null || description!.isEmpty) {
      return const SizedBox.shrink();
    }

    return LexicalParser(sourceMap: description);
  }
}
