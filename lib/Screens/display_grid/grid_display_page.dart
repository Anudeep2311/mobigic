import 'package:flutter/material.dart';
import 'package:mobigic_assignment/Screens/display_grid/widgets/search_input_section.dart';

class GridDisplayPage extends StatefulWidget {
  final List<List<String>> grid;
  final int rowsCount;
  final int columnCount;

  const GridDisplayPage(
      {super.key,
      required this.grid,
      required this.rowsCount,
      required this.columnCount});

  @override
  State<GridDisplayPage> createState() => _GridDisplayPageState();
}

class _GridDisplayPageState extends State<GridDisplayPage> {
  String userInput = '';
  List<HighlightedPosition> highlightedPositions = [];
  int occurrenceCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Grid Display'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              showGrid(widget.grid),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                height: 40,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      userInput = value;
                      highlightedPositions =
                          findUserInputPositions(widget.grid);
                      // Update occurrence count dynamically
                      occurrenceCount = findOccurrenceCount(widget.grid);
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter User Input',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Ocurance of the word: $occurrenceCount",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<HighlightedPosition> findUserInputPositions(List<List<String>> grid) {
    List<HighlightedPosition> positions = [];

    if (userInput.isNotEmpty && grid.isNotEmpty) {
      for (int row = 0; row < widget.rowsCount; row++) {
        for (int col = 0; col < widget.columnCount; col++) {
          String cellValue = grid[row][col].toLowerCase();

          for (int i = 0; i <= cellValue.length - userInput.length; i++) {
            if (cellValue.substring(i, i + userInput.length) ==
                userInput.toLowerCase()) {
              positions.add(
                  HighlightedPosition(row, col, i, i + userInput.length - 1));
            }
          }
        }
      }
    }

    return positions;
  }

  int findOccurrenceCount(List<List<String>> grid) {
    int occurrenceCount = 0;

    if (userInput.isNotEmpty && grid.isNotEmpty) {
      for (int row = 0; row < widget.rowsCount; row++) {
        for (int col = 0; col < widget.columnCount; col++) {
          String cellValue = grid[row][col].toLowerCase();

          for (int i = 0; i <= cellValue.length - userInput.length; i++) {
            if (cellValue.substring(i, i + userInput.length) ==
                userInput.toLowerCase()) {
              occurrenceCount++;
            }
          }
        }
      }
    }

    return occurrenceCount;
  }

  Widget showGrid(List<List<String>> grid) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: grid.asMap().entries.map((entry) {
        int rowIndex = entry.key;
        List<String> row = entry.value;

        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: row.asMap().entries.map((cellEntry) {
            int colIndex = cellEntry.key;
            String cellValue = cellEntry.value;

            List<Widget> cellChildren = [];

            if (highlightedPositions.any((position) =>
                position.row == rowIndex &&
                position.col == colIndex &&
                position.startIndex <= cellValue.length - 1 &&
                position.endIndex <= cellValue.length)) {
              for (int i = 0; i < cellValue.length; i++) {
                final char = cellValue[i];

                bool isHighlightedChar = highlightedPositions.any((position) =>
                    position.row == rowIndex &&
                    position.col == colIndex &&
                    i >= position.startIndex &&
                    i <= position.endIndex);

                cellChildren.add(
                  Text(
                    char,
                    style: TextStyle(
                      color: isHighlightedChar ? Colors.red : Colors.black,
                    ),
                  ),
                );
              }
            } else {
              cellChildren.add(
                Text(
                  cellValue,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }

            return GestureDetector(
              onTap: () {
                // Handle cell tap if needed
              },
              child: Container(
                width: width * 0.18,
                height: 50,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: highlightedPositions.any((position) =>
                          position.row == rowIndex && position.col == colIndex)
                      ? Colors.yellow
                      : null,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: cellChildren,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}

class HighlightedPosition {
  final int row;
  final int col;
  final int startIndex;
  final int endIndex;

  HighlightedPosition(this.row, this.col, this.startIndex, this.endIndex);
}
