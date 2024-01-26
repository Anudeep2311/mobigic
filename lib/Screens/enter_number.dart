import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobigic_assignment/Screens/grid_alphabates/grid_input.dart';

class EnterNumber extends StatefulWidget {
  const EnterNumber({super.key});

  @override
  State<EnterNumber> createState() => _EnterNumberState();
}

class _EnterNumberState extends State<EnterNumber> {
  int rowsNumber = 0;
  int columnNumbers = 0;
  List<List<String>> grid =
      List.generate(0, (row) => List.generate(0, (col) => ""));

  TextEditingController rowsController = TextEditingController();
  TextEditingController colController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Words Demo',
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () => exit(0),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Enter the number of rows:'),
              TextField(
                controller: rowsController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.purple.shade100,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.black54, width: 1.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.purple.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.purple.shade200),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    rowsNumber = int.tryParse(value) ?? 0;
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text('Enter the number of columns:'),
              TextField(
                controller: colController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.purple.shade100,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.black54, width: 1.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.purple.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.purple.shade200),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    columnNumbers = int.tryParse(value) ?? 0;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Needs To Provide Form Validator Here....
              ElevatedButton(
                  onPressed: () {
                    if (rowsNumber > 0 && columnNumbers > 0) {
                      rowsController.clear();
                      colController.clear();
                      _navigateToGridInput();
                    } else {
                      return;
                    }
                  },
                  child: const Text('Next')),
            ],
          ),
        ));
  }

  void _navigateToGridInput() {
    setState(() {
      grid = List.generate(
          rowsNumber, (row) => List.generate(columnNumbers, (col) => ""));
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            GridInputPage(m: rowsNumber, n: columnNumbers, grid: grid),
      ),
    );
  }
}
