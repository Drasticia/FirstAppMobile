import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Report',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color : Colors.grey),
                borderRadius: BorderRadius.circular(15)
              ),
              padding: EdgeInsets.all(372),
              child: Column(
                children: [
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}