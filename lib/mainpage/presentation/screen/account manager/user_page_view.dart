import 'package:flutter/material.dart';

class UsersInfoPageVIew extends StatefulWidget {
  const UsersInfoPageVIew({super.key});

  @override
  State<UsersInfoPageVIew> createState() => _UsersInfoPageVIewState();
}

class _UsersInfoPageVIewState extends State<UsersInfoPageVIew> {
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
            const Text(
              "Admins de l'application ",
              style: TextStyle(
                color:
                    Color(0xFF9F9F9F), // Replace with your custom color if needed
                fontFamily: "Inter", // Replace with the desired font family
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0, // Default line height is normal (1.0)
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 12,
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
                return userContainerView(index);
              },
            ),
            const Text(
              "Admins des pages ",
              style: TextStyle(
                color:
                    Color(0xFF9F9F9F), // Replace with your custom color if needed
                fontFamily: "Inter", // Replace with the desired font family
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0, // Default line height is normal (1.0)
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 12,
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
                return userContainerView(index);
              },
            ),
            const Text(
              "Responsable Logistics ",
              style: TextStyle(
                color:
                    Color(0xFF9F9F9F), // Replace with your custom color if needed
                fontFamily: "Inter", // Replace with the desired font family
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0, // Default line height is normal (1.0)
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 12,
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
                return userContainerView(index);
              },
            ),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }

  Widget userContainerView(int index) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Aziz berrazouane",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          height: 1.0,
                        ),
                      ),
                      TextSpan(
                        text: " @aziz",
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
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "mot de passe: ",
                        style: TextStyle(
                          color: Color(0xFF9F9F9F),
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          height: 1.0,
                        ),
                      ),
                      TextSpan(
                        text: " ********",
                        style: TextStyle(
                          color: Color(0xFF9F9F9F),
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          height: 1.0,
                        ),
                      ),
                      WidgetSpan(
                          child: SizedBox(
                        width: 4,
                      )),
                      WidgetSpan(
                        child: Icon(
                          Icons.visibility,
                          color: Color(0xFF9F9F9F),
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isUserDropDownVisibleList[index]) usersContainerDropDown()
        ],
      ),
    );
  }

  Widget usersContainerDropDown() {
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
                border: Border.all(
                  color: const Color(
                      0xFF111111), // Replace with your desired border color
                  width: 1,
                ),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: const Text(
                  "Modifier L'article",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
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
                  "Supprimer l'article",
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
