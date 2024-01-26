import 'package:flutter/material.dart';

class SearchInputSection extends StatefulWidget {
  final List<List<String>> grid;
  const SearchInputSection({super.key, required this.grid});

  @override
  State<SearchInputSection> createState() => _SearchInputSectionState();
}

class _SearchInputSectionState extends State<SearchInputSection> {
  String searchText = '';
  String searchResult = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Enter text to search:'),
        TextField(
          onChanged: (value) {
            setState(() {
              searchText = value;
              searchResult = _searchTextInGrid(value);
            });
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              searchResult = _searchTextInGrid(searchText);
            });
          },
          child: const Text('Search'),
        ),
        const SizedBox(height: 20),
        Text('Search Result: $searchResult'),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Restart'),
        ),
      ],
    );
  }

  String _searchTextInGrid(String text) {
    return 'Meow';
  }
}
