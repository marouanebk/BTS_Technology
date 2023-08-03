import 'package:flutter/material.dart';

class LivreursInfoPageView extends StatefulWidget {
  const LivreursInfoPageView({super.key});

  @override
  State<LivreursInfoPageView> createState() => _LivreursInfoPageViewState();
}

class _LivreursInfoPageViewState extends State<LivreursInfoPageView> {
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
              itemCount: 4,
              itemBuilder: (context, index) {
                return livreurContainerView(index);
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

  Widget livreurContainerView(int index) {
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
            padding: const EdgeInsets.only(left: 15,top: 30),
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
            child: const Text(
              "Livreur 1",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Inter",
                fontSize: 18,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          if (isUserDropDownVisibleList[index]) livreurContainerDropDown()
        ],
      ),
    );
  }

  Widget livreurContainerDropDown() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
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
