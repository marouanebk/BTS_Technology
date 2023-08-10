import 'package:flutter/material.dart';

class CustomStyledSnackBar extends StatelessWidget {
  final String message;
  final bool success;

  CustomStyledSnackBar({required this.message, this.success = true});

  @override
  Widget build(BuildContext context) {
    Color iconColor = success ? Colors.green : Colors.red;
    IconData iconData = success ? Icons.verified_rounded : Icons.error_outline;

    return 
    
    // SnackBar(
    //   backgroundColor: Colors.transparent,
    //   content: 
      
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 0),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              iconData,
              color: iconColor,
            ),
            const SizedBox(width: 10),
            Text(
              message,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "Inter",
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
          ],
        ),
      // ),
    );
  }
}
