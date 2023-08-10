import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_bloc.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_event.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_state.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/livreurs_page_view.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/new/new_livreur_page.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/new/new_page.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/new/new_user_page.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/pages_view.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/user_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountManager extends StatefulWidget {
  const AccountManager({super.key});

  @override
  State<AccountManager> createState() => _AccountManagerState();
}

class _AccountManagerState extends State<AccountManager> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AccountBloc>()
        ..add(GetAllAccountsEvent())
        ..add(GetPagesEvent())
        ..add(GetLivreursEvent()),
      child: BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {},
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: const CustomAppBar(
              titleText: "Gestionnaire des comptes",
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      pageViewController(0, "Utilisateurs"),
                      pageViewController(1, "Pages"),
                      pageViewController(2, "Livreurs"),
                    ],
                  ),
                ),
                // Container for the PageView
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                    children: [
                      BlocBuilder<AccountBloc, AccountState>(
                        builder: (context, state) {
                          if (state.getAccountState == RequestState.loading) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.black,
                            ));
                          } else if (state.getAccountState ==
                              RequestState.loaded) {
                            return UsersInfoPageVIew(users: state.getAccount);
                          } else if (state.getAccountState ==
                              RequestState.error) {
                            return Container();
                          } else {
                            return Container();
                          }
                        },
                      ),
                      BlocBuilder<AccountBloc, AccountState>(
                        builder: (context, state) {
                          if (state.getPagesState == RequestState.loading) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.black,
                            ));
                          } else if (state.getPagesState ==
                              RequestState.loaded) {
                            return PagesInfoPageView(pages: state.getPages);
                          } else if (state.getPagesState ==
                              RequestState.error) {
                            return Container();
                          } else {
                            return Container();
                          }
                        },
                      ),
                      BlocBuilder<AccountBloc, AccountState>(
                        builder: (context, state) {
                          if (state.getLivreursState == RequestState.loading) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.black,
                            ));
                          } else if (state.getLivreursState ==
                              RequestState.loaded) {
                            return LivreursInfoPageView(
                                livreurs: state.getLivreurs);
                          } else if (state.getLivreursState ==
                              RequestState.error) {
                            return Container();
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: CustomPopupMenuButton(
              onItemSelected: (value) {
                if (value == 'Ajouter une page') {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed('/createPage');

                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (_) => const NewPageAccount(),
                  //   ),
                  // );
                } else if (value == 'Ajouter un utilisateur') {
                  final accountBloc = BlocProvider.of<AccountBloc>(context);
                  final state = accountBloc.state;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => NewUserPage(
                        pages: state.getPages,
                      ),
                    ),
                  );
                } else if (value == 'Ajouter un livreur') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const NewLivreurAccount(),
                    ),
                  );
                }

                setState(() {
                  _isMenuOpen = false;
                });
              },
              isMenuOpen: _isMenuOpen,
            ),
          );
        }),
      ),
    );
  }

  Widget pageViewController(int index, String text) {
    final isSelected = index == _currentPageIndex;
    final textStyle = TextStyle(
      color: isSelected
          ? const Color(0xFF111111)
          : const Color(0xFF9F9F9F), // Conditional color
      fontFamily: 'Inter',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.0, // line-height normal
    );

    return InkWell(
      onTap: () {
        setState(() {
          _pageController.jumpToPage(index);
        });
      },
      child: Column(
        children: [
          Text(
            text,
            style: textStyle,
          ),
          if (isSelected)
            Center(
              child: Container(
                height: 3,
                width: 90,
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(22),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CustomPopupMenuButton extends StatelessWidget {
  final bool isMenuOpen;

  final Function(String) onItemSelected;

  const CustomPopupMenuButton(
      {super.key, required this.isMenuOpen, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 75,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
      child: PopupMenuButton<String>(
        offset: const Offset(-50, -150), // Move the button 50 pixels up
        color: Colors.black,
        onSelected: (value) {
          onItemSelected(value);
        },

        icon: Icon(
          isMenuOpen
              ? Icons.close
              : Icons.add, // Change the icon based on the menu state
          size: 35,
          color: Colors.white,
        ),
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'Ajouter une page',
            child: Text(
              "Ajouter une page",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Inter",
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
          ),
          const PopupMenuItem(
            value: 'Ajouter un utilisateur',
            child: Text(
              "Ajouter un utilisateur",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Inter",
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
          ),
          const PopupMenuItem(
            value: 'Ajouter un livreur',
            child: Text(
              "Ajouter un livreur",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Inter",
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
