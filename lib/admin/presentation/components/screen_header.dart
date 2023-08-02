import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget screenHeader(String title, String link) {
  return RichText(
    text: TextSpan(
      children: [
        WidgetSpan(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: SvgPicture.asset(
              link, // Replace with the actual path to your SVG image
              width: 21,
              height: 21,
            ),
          ),
        ),
         TextSpan(
          text: title,
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
