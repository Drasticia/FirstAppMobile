import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Report_Received extends StatelessWidget {
  const Report_Received({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'Report Received',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 682,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'List Report',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        width: 400,
                        height: 1,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2.5)
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(255, 192, 65, 0.800),
                              Color.fromRGBO(249, 61, 61, 0.800)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: Colors.red,
                              size: 50,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fire',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Name : Sueb Saefullah',
                                  style: TextStyle(
                                    fontSize: 13
                                  ),
                                ),
                                Text(
                                  'Number : 0812356781',
                                  style: TextStyle(
                                    fontSize: 13
                                  ),
                                ),
                                Text(
                                  'Location : Cianjut, Jawa Barat',
                                  style: TextStyle(
                                    fontSize: 13
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                SizedBox(
                                  width: 90,
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: () {

                                    },
                                    child: Text(
                                      'Rejec',
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromARGB(255, 188, 45, 34),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                SizedBox(
                                  width: 90,
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      
                                    },
                                    child: Text(
                                      'Map',
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromARGB(255, 188, 45, 34),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                SizedBox(
                                  width: 90,
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: () {

                                    },
                                    child: Text(
                                      'Send',
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromARGB(255, 188, 45, 34),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}