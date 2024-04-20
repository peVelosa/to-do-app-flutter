import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key, required this.controller, required this.onChanged});

  final TextEditingController controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onTapOutside: (PointerDownEvent pointerDownEvent) {
        FocusScope.of(context).unfocus();
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Search for a to do...',
        prefixIcon: Icon(Icons.search),
        label: Text('Search'),
      ),
    );
  }
}
