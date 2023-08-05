import 'package:flutter/material.dart';

Widget buildSelectField({
  required String label,
  required String hintText,
  required String? value,
  required String errorText,
  required void Function(String?) onChanged,
  required List<String> items, // List of strings for labels

  bool formSubmitted = false,
}) {
  final bool isEmpty = value?.isEmpty ?? true;

  final bool showErrorText = formSubmitted && isEmpty;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF9F9F9F)),
      ),
      const SizedBox(height: 8),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            hint: Text(hintText),
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
            items: items.map<DropdownMenuItem<String>>((label) {
              return DropdownMenuItem<String>(
                value: label,
                child: Text(label),
              );
            }).toList(),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Align(
        alignment: Alignment.centerRight,
        child: Text(
          showErrorText ? errorText : "",
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}
