import 'package:flutter/material.dart';

Widget buildInputField({
  String? label,
  String? hintText,
  String? errorText,
  TextEditingController? controller,
  bool isNumeric = false,
  bool formSubmitted = false,
  bool isMoney = false,
  bool readOnly = false,
  bool showNote = false,
  bool noteAbove = false,
}) {
  final bool isEmpty = controller?.text.isEmpty ?? false;
  final bool showErrorText = formSubmitted && isEmpty;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label!,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF9F9F9F)),
      ),
      Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            controller: controller,
            readOnly: readOnly,
            keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
            enableSuggestions: false, 
            enableInteractiveSelection: false, 

            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9F9F9F)),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              border: const UnderlineInputBorder(),
            ),
          ),
          // Show "DA" at the end for numeric fields (isNumeric = true)
          if (isNumeric && isMoney)
            const Positioned(
              right: 0,
              child: Text(
                "DA",
                style: TextStyle(color: Colors.black),
              ),
            ),
        ],
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Text(
          showErrorText ? errorText! : "",
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.right,
        ),
      ),
      if (showNote && !noteAbove)
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Note",
            style: TextStyle(color: Colors.black),
          ),
        ),
    ],
  );
}
