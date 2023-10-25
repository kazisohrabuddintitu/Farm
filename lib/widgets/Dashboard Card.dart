import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final Function onTap;
  const DashboardCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child:  Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

