import 'package:flutter/material.dart';
import 'package:mobigic_assignment/Screens/display_grid/grid_display_page.dart';

class GridInputPage extends StatefulWidget {
  final int m;
  final int n;
  final List<List<String>> grid;
  const GridInputPage(
      {super.key, required this.m, required this.n, required this.grid});

  @override
  State<GridInputPage> createState() => _GridInputPageState();
}

class _GridInputPageState extends State<GridInputPage> {
  int currentRow = 0;
  int currentCol = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Alphabate Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              if (widget.grid.isNotEmpty)
                const Text(
                  'Enter values in each grid cell',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              const SizedBox(height: 20),
              if (widget.grid.isNotEmpty) getInputForGrid(widget.grid),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _navigateToGridDisplay,
                child: const Text('Display Grid'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getInputForGrid(List<List<String>> grid) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: grid.asMap().entries.map((entry) {
        int rowIndex = entry.key;
        List<String> row = entry.value;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row.asMap().entries.map((cellEntry) {
            int colIndex = cellEntry.key;
            String cellValue = cellEntry.value;

            return Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    grid[rowIndex][colIndex] = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none,
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     getInputForGrid(grid),
    //     // Text('Enter row ${currentRow + 1} (use ${widget.n} alphabets):'),
    //     // TextField(
    //     //   onChanged: (value) {
    //     //     if (value.length == widget.n) {
    //     //       setState(() {
    //     //         widget.grid[currentRow] = value.split('');
    //     //         currentRow++;
    //     //         currentCol = 0;
    //     //       });
    //     //     }
    //     //   },
    //     // ),

    //     // const SizedBox(height: 20),

    //     // ElevatedButton(
    //     //   onPressed: () {
    //     //     if (widget.grid[currentRow].length == widget.n) {
    //     //       setState(() {
    //     //         currentRow++;
    //     //         currentCol = 0;
    //     //       });
    //     //     }
    //     //   },
    //     //   child: const Text('Next'),
    //     // ),
    //   ],
    // );
  }

  void _navigateToGridDisplay() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GridDisplayPage(
          grid: widget.grid,
          rowsCount: widget.m,
          columnCount: widget.n,
        ),
      ),
    );
  }
}
