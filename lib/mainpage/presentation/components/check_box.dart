import 'package:flutter/material.dart';

class RoundedCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;

  const RoundedCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: Theme.of(context).unselectedWidgetColor,
              ),
            ),
            child: value
                ? Center(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(
              width: 6), // Add some space between the checkbox and text
          Text(
            label,
            style: TextStyle(
              color: value
                  ? const Color(0xFF111111) // Black color if activated
                  : const Color(0xFF9F9F9F), // Grey color if not activated
              fontFamily: 'Inter',
              fontSize: 14,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
