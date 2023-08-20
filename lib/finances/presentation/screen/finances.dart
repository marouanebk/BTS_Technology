import 'dart:developer';

import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/finances/domaine/entities/cashflow_entity.dart';
import 'package:bts_technologie/finances/domaine/entities/finance_entity.dart';
import 'package:bts_technologie/finances/presentation/controller/finance_bloc/finance_bloc.dart';
import 'package:bts_technologie/finances/presentation/controller/finance_bloc/finance_event.dart';
import 'package:bts_technologie/finances/presentation/controller/finance_bloc/finance_state.dart';
import 'package:bts_technologie/finances/presentation/screen/new_charge.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/livreur_entity.dart';
import 'package:bts_technologie/mainpage/presentation/components/screen_header.dart';
import 'package:bts_technologie/mainpage/presentation/components/snackbar.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_bloc.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_event.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FinancesPage extends StatefulWidget {
  final String role;
  const FinancesPage({required this.role, super.key});

  @override
  State<FinancesPage> createState() => _FinancesPageState();
}

class _FinancesPageState extends State<FinancesPage> {
  late List<_ChartData> data;
  late List<_ChartData> yearData;
  late List<_ChartData> monthData;
  late List<_ChartData> dayData;

  late TooltipBehavior _tooltip;
  String _selectedPeriod = 'Par mois';

  @override
  void initState() {
    data = [];
    _tooltip = TooltipBehavior(enable: true);
    _fetchFinancesChartData();
    super.initState();
    setState(() {
      data;
    });
  }

  Future<void> _fetchFinancesChartData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final response = await Dio().get(ApiConstance.getFinancesChart,
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ));
      final Map<String, dynamic> chartData =
          Map<String, dynamic>.from(response.data);

      for (final type in chartData.keys) {
        final List<dynamic> entries = chartData[type];
        final List<_ChartData> dataList = entries.map((entry) {
          final Map<String, dynamic> entryData =
              Map<String, dynamic>.from(entry);
          final String date = entryData.keys.first;
          final double value = entryData.values.first.toDouble();
          return _ChartData(date, value);
        }).toList();

        switch (type) {
          case 'year':
            yearData = dataList;
            break;
          case 'month':
            monthData = dataList;
            break;
          case 'day':
            dayData = dataList;
            break;
        }
      }      setState(() {
        data = monthData;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          content: CustomStyledSnackBar(
              message: "Error fetching finances chart data: $error'",
              success: false),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<FinanceBloc>()
            ..add(GetFinancesEvent())
            ..add(GetCashFlowEvent()),
        ),
        BlocProvider(
          create: (context) => sl<AccountBloc>()..add(GetLivreursEvent()),
        ),
      ],
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: RefreshIndicator(
              onRefresh: () async {
                _fetchFinancesChartData();

                context.read<FinanceBloc>()
                  ..add(GetFinancesEvent())
                  ..add(GetCashFlowEvent());
                context.read<AccountBloc>().add(GetLivreursEvent());
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: screenHeader("Finances",
                              'assets/images/navbar/finances_activated.svg')),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<AccountBloc, AccountState>(
                        builder: (context, state) {
                          if (state.getLivreursState == RequestState.loading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            );
                          } else if (state.getLivreursState ==
                              RequestState.error) {
                            return Text(
                              state.getLivreursmessage,
                              style: const TextStyle(color: Colors.red),
                            );
                          } else if (state.getLivreursState ==
                              RequestState.loaded) {
                                log("rebuilding");
                            return _topContainer(state.getLivreurs);
                          } else {
                            return Container();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<FinanceBloc, FinancesState>(
                        builder: (context, state) {
                          if (state.getCashFlowState == RequestState.loading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            );
                          }
                          if (state.getCashFlowState == RequestState.error) {
                            return Text(
                              state.getFinancesmessage,
                              style: const TextStyle(color: Colors.red),
                            );
                          }
                          if (state.getCashFlowState == RequestState.loaded) {
                            return _cashflow(state.getCashFlow!);
                          }

                          return Container();
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<FinanceBloc, FinancesState>(
                        builder: (context, state) {
                          if (state.getFinancesState == RequestState.loading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            );
                          }
                          if (state.getFinancesState == RequestState.error) {
                            return Text(
                              state.getFinancesmessage,
                              style: const TextStyle(color: Colors.red),
                            );
                          }
                          if (state.getFinancesState == RequestState.loaded) {
                            Map<String, List<FinanceEntity>> groupedData = {};
                            // for (Command command in state.getCommandes) {

                            for (FinanceEntity finance in state.getFinances) {
                              if (!groupedData.containsKey(finance.date)) {
                                groupedData[finance.date!] = [];
                              }
                              groupedData[finance.date]?.add(finance);
                            }
                            return revenueList(groupedData);
                          }

                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 20),
                child: Container(
                  height: 76,
                  width: 76,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (_) => NewFinanceCharge(
                              role: widget.role,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 35,
                      ),
                      color: Colors.white),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget revenueList(Map<String, List<FinanceEntity>> groupedData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (String date in groupedData.keys) ...[
          Text(
            date,
            style: const TextStyle(
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
              height: 14,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: groupedData[date]!.length,
            itemBuilder: (context, index) {
              FinanceEntity finance = groupedData[date]![index];
              final isRed = finance.money < 0;
              // final isRed = random.nextBool();

              return revenueItem(finance, isRed);
            },
          ),
          const SizedBox(
            height: 12,
          )
        ],
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  Widget revenueItem(FinanceEntity finance, bool isRed) {
    final backgroundColor = isRed ? Colors.red : Colors.green;

    return Container(
      width: double.infinity,
      height: 70,
      // padding: const EdgeInsets.only(right: 15, left: 15, top: 18, ),
      padding: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white, // Replace with your custom color if needed
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            offset: Offset(0, 0),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
              left: 15,
              top: 18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${finance.money} DA",
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
                  height: 8,
                ),
                Text(
                  isRed ? finance.label : "Com N° ${finance.label}",
                  style: const TextStyle(
                    color: Color(0xFF9F9F9F),
                    fontFamily: "Inter",
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 7),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: isRed
                  ? const Color.fromRGBO(255, 68, 68, 0.1)
                  : const Color.fromRGBO(7, 176, 24, 0.1),
            ),
            child: Center(
              child: Icon(
                isRed ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                size: 35,
                // color: Colors.red,
                color: backgroundColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _cashflow(CashFlow cashflow) {
    List<_ChartData> selectedData = [];

    if (_selectedPeriod == 'Par mois') {
      selectedData = monthData;
    } else if (_selectedPeriod == 'Par jour') {
      selectedData = dayData;
    } else if (_selectedPeriod == 'Par année') {
      selectedData = yearData;
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Analytiques du cashflow",
                  style: TextStyle(
                    color: Color(0xFF9F9F9F),
                    fontFamily: "Inter",
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    height: 1.0,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _selectedPeriod == 'Par mois'
                      ? '${cashflow.month} DA'
                      : _selectedPeriod == 'Par jour'
                          ? '${cashflow.day} DA'
                          : '${cashflow.year} DA',
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: "Inter",
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                  ),
                ),
              ],
            ),
            DropdownButton<String>(
              value: _selectedPeriod,
              items: const [
                DropdownMenuItem(
                  value: 'Par mois',
                  child: Text(
                    'Par mois',
                    style: TextStyle(
                      color: Color(0xFF9F9F9F),
                      fontFamily: "Inter",
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Par jour',
                  child: Text(
                    'Par jour',
                    style: TextStyle(
                      color: Color(0xFF9F9F9F),
                      fontFamily: "Inter",
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Par année',
                  child: Text(
                    'Par année',
                    style: TextStyle(
                      color: Color(0xFF9F9F9F),
                      fontFamily: "Inter",
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                    ),
                  ),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPeriod = newValue!;
                });
              },
            )
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        if (selectedData.isNotEmpty)
          SfCartesianChart(
            zoomPanBehavior:
                ZoomPanBehavior(enablePanning: true, zoomMode: ZoomMode.x),
            primaryXAxis: CategoryAxis(
              visibleMinimum: 0,
              visibleMaximum: 5,
            ),
            primaryYAxis: NumericAxis(),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<_ChartData, String>>[
              ColumnSeries<_ChartData, String>(
                dataSource: selectedData,
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                name: '',
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                color: const Color(0xFFECECEC),
                selectionBehavior: SelectionBehavior(
                  enable: true,
                  unselectedOpacity: 1.0,
                  selectedColor: Colors.black,
                  unselectedColor: const Color(0xFFECECEC),
                ),
              )
            ],
          )
        else if (monthData.isEmpty && dayData.isEmpty && yearData.isEmpty)
          // Show loading indicator or message when no data is available
          const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
      ],
    );
  }

  Widget _topContainer(livreurs) {
    double totalMoney = 0;
    List<Livreur> profitableLivreurs = [];

    for (Livreur livreur in livreurs) {
      totalMoney += livreur.money!;

      if (livreur.money! > 0) {
        profitableLivreurs.add(livreur);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Solde chez livreurs",
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
          height: 10,
        ),
        Container(
          // height: 80,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFFFFFFFF),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.15),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$totalMoney DA",
                style: const TextStyle(
                  color:
                      Color(0xFF111111), // Replace with your desired text color
                  fontFamily: "Inter",
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                height: 10,
              ),
              for (Livreur livreur in profitableLivreurs) ...[
                _livreurComp(livreur),
                const SizedBox(
                  height: 10,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _livreurComp(Livreur livreur) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          livreur.livreurName,
          style: const TextStyle(
            color: Color(0xFF111111), // Replace with your desired text color
            fontFamily: "Inter",
            fontSize: 14,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            height: 1.0,
          ),
          textAlign: TextAlign.right,
        ),
        Text(
          "${livreur.money} DA",
          style: const TextStyle(
            color: Color(0xFF9F9F9F), // Replace with your desired text color
            fontFamily: "Inter",
            fontSize: 14,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            height: 1.0,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
  @override
  String toString() {
    return '_ChartData{x: $x, y: $y}';
  }
}
