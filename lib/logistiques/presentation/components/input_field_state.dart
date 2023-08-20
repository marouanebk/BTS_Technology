import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String errorText;
  final TextEditingController? controller;
  final bool isNumeric;
  final bool formSubmitted;

  final bool readOnly;
  final bool showNote;
  final bool noteAbove;
  final int? quantityAlert;
  final String? unity;
  final int? variantQuantity;

  const InputField({
    Key? key,
    this.label,
    this.hintText,
    this.errorText = "Vous devez entrer une valid nombre",
    this.controller,
    this.isNumeric = false,
    this.formSubmitted = false,
    this.readOnly = false,
    this.showNote = false,
    this.noteAbove = false,
    this.quantityAlert,
    this.variantQuantity,
    this.unity,
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
      // Call setState to rebuild the widget and update the showQuantityAlert value
      setState(() {
        int currentValue = int.tryParse(widget.controller?.text ?? '') ?? 0;
        showQuantityAlert = widget.quantityAlert != null &&
            widget.quantityAlert != null &&
            ((currentValue >
                    (widget.variantQuantity! - widget.quantityAlert!)) ||
                (widget.variantQuantity! < widget.quantityAlert!));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = widget.controller?.text.isEmpty ?? false;

    int? currentValue = int.tryParse(widget.controller?.text ?? '');
    bool isNotInt = currentValue == null;
    bool isNegative = currentValue != null && currentValue < 0;
    final bool showErrorText = widget.formSubmitted && isEmpty ||
        widget.formSubmitted && (isNegative || isNotInt);

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
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color.fromRGBO(255, 68, 68, 0.1),
                ),
                child: Text(
                  "il reste ${widget.variantQuantity}",
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
            if (widget.isNumeric && widget.unity != null)
              Positioned(
                right: 0,
                child: Text(
                  widget.unity!,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            showErrorText
                ? (isNegative
                    ? "Vous devez entrer une valeur positive"
                    : widget.errorText)
                : "",
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
