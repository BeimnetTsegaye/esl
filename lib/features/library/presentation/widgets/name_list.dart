import 'package:esl/core/shared/constants.dart';
import 'package:flutter/material.dart';

class NameList extends StatefulWidget {
  const NameList({super.key, required this.authors});

  final List<String> authors;

  @override
  State<NameList> createState() => _NameListState();
}

class _NameListState extends State<NameList> {
  List<String> get authors => widget.authors;
  @override
  void initState() {
    super.initState();
    _selectedAuthor = authors.isNotEmpty ? authors.first : null;
  }

  String? _selectedAuthor;
  void _onAuthorSelected(String author) {
    setState(() {
      _selectedAuthor = author;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 10,
          children: authors
              .map(
                (author) => ElevatedButton(
                  onPressed: () {
                    _onAuthorSelected(author);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.eslGreyTint,
                  ),
                  child: Text(
                    author,
                    style: TextStyle(
                      color: _selectedAuthor != author
                          ? Colors.black
                          : AppConstants.eslGreen,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
