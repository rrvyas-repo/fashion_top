import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fashion_top/models/product_model.dart';
import 'package:fashion_top/models/school_model.dart';
import 'package:fashion_top/screen/products/product.dart';
import 'package:fashion_top/screen/products/product_bloc.dart';
import 'package:fashion_top/screen/schools/school.dart';
import 'package:fashion_top/screen/schools/school_bloc.dart';
import 'package:fashion_top/screen/sizes/size.dart';
import 'package:fashion_top/screen/stocks/stocks.dart';
import 'package:fashion_top/utils/colors.dart';
import 'package:fashion_top/utils/icons.dart';
import 'package:fashion_top/utils/string.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import '../../models/data.dart';
import 'home_page_widget.dart';

double screenHeight = 0;
double screenWidth = 0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

FirebaseDatabase db = FirebaseDatabase.instance;

class _HomePageState extends State<HomePage> {
  Widget pageNavigate(String f) {
    switch (f) {
      case 'Schools':
        return const SchoolList();
      case 'Sizes':
        return const SizeList();
      case 'All Products':
        return const ProductList();
      default:
        return const StockList();
    }
  }

  List<String> homePageListTile = [
    'Schools',
    'Products',
    'Sizes',
    'Stocks',
  ];
  List<IconData> homePageListTileIc = [
    Icons.school,
    Icons.pest_control_rodent_outlined,
    Icons.format_size,
    Icons.stop_circle_rounded,
  ];

  List<dynamic> streamCountCall = [
    SchoolBloc.totalSchoolBlocStream,
    ProductBloc.totalProductBlocStream,
  ];

  List<dynamic> dataIsNotEmpty = [
    schoolData.isNotEmpty,
    productData.isNotEmpty,
  ];
  List<dynamic> dataIsEmpty = [
    schoolData.isEmpty,
    productData.isEmpty,
  ];

  @override
  void initState() {
    super.initState();
    SchoolBloc.setData();
    ProductBloc.setData();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            stops: [0.2, 0.2],
            colors: [Color.fromRGBO(255, 255, 255, 0.1), Colors.white]),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Row(
                children: [
                  Expanded(child: stockDisplayContainer()),
                  // SizedBox(width: 10,),
                  Expanded(child: stockDisplayContainer()),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: homePageListTile.length,
                  itemBuilder: (context, index) => index >= 2
                      ? Card(
                          child: SizedBox(
                            height: 100.0,
                            child: listTilesHomePage(
                              ic: homePageListTileIc[index],
                              titles: homePageListTile[index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        pageNavigate(pageRoute[index].title),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Card(
                          child: StreamBuilder(
                            stream: streamCountCall[index],
                            builder: (context, AsyncSnapshot<int> snap) {
                              int? count = snap.data;
                              // print(dataIsNotEmpty[index]);
                              // SchoolBloc.setData();
                              // ProductBloc.setData();
                              return SizedBox(
                                height: 100.0,
                                child: listTilesHomePage(
                                  ic: homePageListTileIc[index],
                                  titles: homePageListTile[index],
                                  count: count == 1 && dataIsNotEmpty[index]
                                      ? count.toString()
                                      : '0',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => pageNavigate(
                                            pageRoute[index].title),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            backgroundColor: appFromClr,
            items: <Widget>[
              bottomNavigationBarIcon(
                bottomNavigationBarHomeIcon,
                navigationHome,
              ),
              bottomNavigationBarIcon(
                  bottomNavigationBarStockIcon, navigationStock),
              bottomNavigationBarIcon(
                  bottomNavigationBarProductIcon, navigationProduct),
              bottomNavigationBarIcon(
                  bottomNavigationBarShareIcn, navigationShare),
            ],
            onTap: (index) async {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              }
              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StockList(),
                  ),
                );
              }
              if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductList(),
                  ),
                );
              }
              if (index == 3) {
                await FlutterShare.share(
                  title: 'share type',
                  linkUrl: 'https://pub.dev/packages/url_launcher',
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
