import 'package:flutter/material.dart';

class ReqCard extends StatelessWidget {
  final String title;
  final Map<String, dynamic> description;
  final IconData? icon;
  final Color? iconColor;

  const ReqCard({
    super.key, 
    required this.title, 
    required this.description,
    this.icon = Icons.description,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and title
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon ?? Icons.description,
                  color: iconColor ?? Theme.of(context).primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Documents list
          if (description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildDocumentList(description),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'No documents required',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildDocumentList(Map<String, dynamic> description) {
    final List<Widget> widgets = [];
    
    // Handle different description structures
    if (description.containsKey('document') && description['document'] is List) {
      // If description has a 'document' key with list value
      final documents = description['document'] as List;
      for (var doc in documents) {
        if (doc is Map) {
          widgets.add(_buildDocumentItem(doc['name'] ?? 'Document', doc['description']));
        } else if (doc is String) {
          widgets.add(_buildDocumentItem(doc));
        }
      }
    } else {
      // If description is a map with document items
      description.forEach((key, value) {
        if (value is Map) {
          widgets.add(_buildDocumentItem(key, value['description'] ?? ''));
        } else if (value is String) {
          widgets.add(_buildDocumentItem(key, value));
        }
      });
    }

    return widgets;
  }

  Widget _buildDocumentItem(String title, [String? description]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, size: 20, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (description != null && description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
