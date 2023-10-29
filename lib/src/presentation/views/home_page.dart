import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:neosurge_finance/src/presentation/bloc/transaction_bloc/transation_bloc.dart';
import 'package:neosurge_finance/src/presentation/views/add_expence.dart';
import 'package:neosurge_finance/src/presentation/views/add_income.dart';
import 'package:neosurge_finance/src/presentation/views/profile_screen.dart';
import 'package:neosurge_finance/src/presentation/widgets/custom_drawer.dart';
import 'line_chart_page.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  bool _isScrolled = false;
  double totalExpense = 0.0;
  double totalIncome = 0.0;

  final List<dynamic> _services = [
    ['Add Income', Iconsax.money, Colors.red],
    ['Add Expense', Iconsax.money_3, Colors.lightBlueAccent],
    ['Pie Chart', Iconsax.chart_1, Colors.yellow],
  ];

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    final itemBloc = BlocProvider.of<TransationBloc>(context);
    itemBloc.add(FetchTransationEvent());
    itemBloc.stream.listen((state) {
      if (state is TransactionLoded) {
        for (var entry in state.details) {
          if (entry['category'] == 'expense') {
            totalExpense += entry['amount'];
          }
          if (entry['category'] == 'income') {
            totalIncome += entry['amount'];
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _listenToScrollChange() {
    if (_scrollController.offset >= 100.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.grey.shade900,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade900,
            blurRadius: 20.0,
            spreadRadius: 5.0,
            offset: Offset(-20.0, 0.0),
          ),
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      drawer: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 80.0,
                    height: 80.0,
                    margin: EdgeInsets.only(
                      left: 20,
                      top: 24.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/images/avatar-1.png')),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    "Chetan Mali",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 50,),
                Divider(
                  color: Colors.grey.shade800,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const ProfilePage()));

                  },
                  leading: Icon(Iconsax.profile_2user),
                  title: Text('Profile'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LineChartPage(totalExpense: totalExpense, totalIncome: totalIncome,)));

                  },
                  leading: Icon(Iconsax.home),
                  title: Text('Dashboard'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LineChartPage(totalExpense: totalExpense, totalIncome: totalIncome,)));

                  },
                  leading: Icon(Iconsax.chart_2),
                  title: Text('Analytics'),
                ),

                // ListTile(
                //   onTap: () {},
                //   leading: Icon(Iconsax.transaction_minus),
                //   title: Text('Transactions'),
                // ),
                SizedBox(
                  height: 50,
                ),


                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Version 1.0.0',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: CustomScrollView(controller: _scrollController, slivers: [
            SliverAppBar(
              expandedHeight: 250.0,
              elevation: 0,
              pinned: true,
              stretch: true,
              toolbarHeight: 80,
              backgroundColor: Colors.white,
              leading: IconButton(
                color: Colors.black,
                onPressed: _handleMenuButtonPressed,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Iconsax.close_square : Iconsax.menu,
                        key: ValueKey<bool>(value.visible),
                      ),
                    );
                  },
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Iconsax.more, color: Colors.grey.shade700),
                  onPressed: () {},
                ),
              ],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              centerTitle: true,
              title: AnimatedOpacity(
                opacity: _isScrolled ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    Text(
                      '${totalIncome - totalExpense}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 30,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                titlePadding: const EdgeInsets.only(left: 20, right: 20),
                title: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _isScrolled ? 0.0 : 1.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Total Balance',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\Rs',
                              style: TextStyle(
                                  color: Colors.grey.shade800, fontSize: 16),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              '${totalIncome - totalExpense}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FadeIn(
                            duration: const Duration(milliseconds: 500),
                            child: MaterialButton(
                              height: 30,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '\Rs${totalIncome}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 8),
                                  ),
                                  Text(
                                    'Total Income',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                ],
                              ),
                              color: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey.shade300, width: 1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          FadeIn(
                            duration: const Duration(milliseconds: 500),
                            child: MaterialButton(
                              height: 30,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '\Rs${totalExpense}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 8),
                                  ),
                                  Text(
                                    'Total Expence',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                ],
                              ),
                              color: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey.shade300, width: 1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 30,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                height: 115,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _services.length,
                  itemBuilder: (context, index) {
                    return FadeInDown(
                      duration: Duration(milliseconds: (index + 1) * 100),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: GestureDetector(
                          onTap: () {
                            switch (_services[index][0]) {
                              case 'Add Income':
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddIncome()));
                                break;
                              case 'Add Expense':
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddExpencePage()));
                                break;
                              case 'Pie Chart':
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LineChartPage(totalExpense: totalExpense, totalIncome: totalIncome,)));
                                break;
                              default:
                              // Handle other cases or provide a default action
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade900,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Icon(
                                    _services[index][1],
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                _services[index][0],
                                style: TextStyle(
                                    color: Colors.grey.shade800, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ])),
            SliverFillRemaining(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  children: [
                    FadeInDown(
                      duration: Duration(milliseconds: 500),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today',
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('\Rs${totalIncome - totalExpense}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                )),
                          ]),
                    ),
                    Expanded(
                      child: BlocBuilder<TransationBloc, TransationState>(
                        builder: (context, state) {
                          if (state is TransactionLoding) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is TransactionLoded) {
                            final data = state.details;
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final res = data[index];
                                int d = res['amount'];
                                final String dataNow = 'Rs $d';

                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 10, left: 10),
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                          blurRadius: 5,
                                          spreadRadius: 1,
                                          offset: Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            if (res['category'] == "expense")
                                              Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    color: Colors.red.shade300,
                                                  ),
                                                  child: Icon(
                                                    Icons.arrow_downward,
                                                    color: Colors.red,
                                                  )),
                                            if (res['category'] != "expense")
                                              Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    color:
                                                        Colors.green.shade600,
                                                  ),
                                                  child: Icon(
                                                    Icons.arrow_upward,
                                                    color: Colors.greenAccent,
                                                  )),
                                            SizedBox(width: 15),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(res['category'],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade900,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14)),
                                                SizedBox(height: 5),
                                                Text(res['description'],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontSize: 12)),
                                                Text(res['date'],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade700,
                                                        fontSize: 8)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        if (res['category'] == "expense")
                                          Text(dataNow,
                                              style: TextStyle(
                                                  color: Colors.red.shade800,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                        if (res['category'] != "expense")
                                          Text(dataNow,
                                              style: TextStyle(
                                                  color: Colors.green.shade300,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (state is TransactionError) {
                            return Center(child: Text(state.error));
                          } else {
                            return Center(
                                child: Text('Press the refresh button'));
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ])),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
