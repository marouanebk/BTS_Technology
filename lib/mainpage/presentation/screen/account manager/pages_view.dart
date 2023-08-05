import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';
import 'package:flutter/material.dart';

class PagesInfoPageView extends StatefulWidget {
  final List<FacePage> pages;

  const PagesInfoPageView({required this.pages, super.key});

  @override
  State<PagesInfoPageView> createState() => _PagesInfoPageViewState();
}

class _PagesInfoPageViewState extends State<PagesInfoPageView> {
  List<bool> isUserDropDownVisibleList = List.generate(15, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            ListView.separated(
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => const SizedBox(
                height: 12,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.pages.length,
              itemBuilder: (context, index) {
                return pageContainerView(widget.pages[index], index);
              },
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget pageContainerView(FacePage page, index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isUserDropDownVisibleList[index] = !isUserDropDownVisibleList[index];
        });
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 70,
            padding: const EdgeInsets.only(left: 15, top: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(5),
                bottom: isUserDropDownVisibleList[index]
                    ? const Radius.circular(
                        0) // Remove bottom-left and bottom-right radius
                    : const Radius.circular(
                        5), // Keep radius when dropdown is not visible
              ),
              color: Colors.white,
              boxShadow: isUserDropDownVisibleList[index]
                  ? [
                      const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: Offset(-5, -5), // Add shadows to top-left
                      ),
                      const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: Offset(5, -5), // Add shadows to top-right
                      ),
                      const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: Offset(0, -5), // Add shadow to top
                      ),
                    ]
                  : [
                      const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: Offset(0, 0), // Add shadows to all sides
                      ),
                    ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  page.pageName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: "Inter",
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Amir Massi",
                  style: TextStyle(
                    color: Color(0xFF9F9F9F),
                    fontFamily: "Inter",
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
          if (isUserDropDownVisibleList[index]) pageContainerDropDown()
        ],
      ),
    );
  }

  Widget pageContainerDropDown() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(5), // Remove top-left and top-right radius
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(-5, 5), // Add shadows to bottom-left
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(5, 5), // Add shadows to bottom-right
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(0, 5), // Add shadow to bottom
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 50, // Set the height to 50
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: const Text(
                  "Supprimer la page",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
