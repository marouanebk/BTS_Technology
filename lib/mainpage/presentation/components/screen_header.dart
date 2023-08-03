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

Widget smallRichText(String title, String link) {
  return RichText(
    text: TextSpan(
      children: [
        WidgetSpan(
          child: Padding(
            padding: const EdgeInsets.only(right: 8 , bottom: 2),
            child: SvgPicture.asset(
              link,
              width: 10,
              height: 10,
              color: Color(0xFF9F9F9F),
            ),
          ),
        ),
        TextSpan(
          text: title,
          style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF9F9F9F),
              fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}
