import 'package:flutter/material.dart';

Widget searchContainer(String hinttext) {
  return Container(
    height: 40,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: const Color(0xFF9F9F9F),
        width: 1.0,
      ),
    ),
    padding: const EdgeInsets.only(
      left: 20,
      right: 20,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: hinttext,
              hintStyle: const TextStyle(
                color: Color(0xFF9F9F9F),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        const Icon(
          Icons.search,
          color: Color(0xFF9F9F9F),
        ),
      ],
    ),
  );
}
