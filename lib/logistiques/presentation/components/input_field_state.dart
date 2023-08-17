import 'dart:developer';

import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? errorText;
  final TextEditingController? controller;
  final bool isNumeric;
  final bool formSubmitted;
  final bool isMoney;
  final bool readOnly;
  final bool showNote;
  final bool noteAbove;
  final int? quantityAlert;

  const InputField({
    Key? key,
    this.label,
    this.hintText,
    this.errorText,
    this.controller,
    this.isNumeric = false,
    this.formSubmitted = false,
    this.isMoney = false,
    this.readOnly = false,
    this.showNote = false,
    this.noteAbove = false,
    this.quantityAlert,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool showQuantityAlert = false;

  @override
  void initState() {
    super.initState();

    // Add a listener to the controller to listen for changes in its value
    widget.controller?.addListener(() {
      log(widget.quantityAlert.toString());
      // Call setState to rebuild the widget and update the showQuantityAlert value
      setState(() {
        showQuantityAlert = widget.quantityAlert != null &&
            (int.tryParse(widget.controller?.text ?? '') ?? 0) >
                widget.quantityAlert!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = widget.controller?.text.isEmpty ?? false;
    final bool showErrorText = widget.formSubmitted && isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label!,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9F9F9F)),
            ),
            if (showQuantityAlert) ...[
              const SizedBox(
                width: 4,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromRGBO(255, 68, 68, 0.1),
                ),
                child: Text(
                  "il rest ${widget.quantityAlert}",
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                ),
              ),
            ]
          ],
        ),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextField(
              controller: widget.controller,
              readOnly: widget.readOnly,
              keyboardType:
                  widget.isNumeric ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9F9F9F)),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: const UnderlineInputBorder(),
              ),
            ),
            // Show "DA" at the end for numeric fields (isNumeric = true)
            if (widget.isNumeric && widget.isMoney)
              const Positioned(
                right: 0,
                child: Text(
                  "DA",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            // Add a new condition to display a red text on the right of the label text if the value entered by the user is greater than the quantityAlert value
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            showErrorText ? widget.errorText! : "",
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
