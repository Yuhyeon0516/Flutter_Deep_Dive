import 'package:dusty_dust/component/category_stat.dart';
import 'package:dusty_dust/component/hourly_stat.dart';
import 'package:dusty_dust/component/main_stat.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Region region = Region.seoul;
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    StatRepository.fetchData();

    scrollController.addListener(() {
      // appBar의 최대 높이인 500 - 기본 appbarheight의 값보다 offset이 작으면 접힌것
      bool isExpanded = scrollController.offset < (500 - kToolbarHeight);

      if (isExpanded != this.isExpanded) {
        setState(() {
          this.isExpanded = isExpanded;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatModel?>(
      future: GetIt.I<Isar>()
          .statModels
          .filter()
          .regionEqualTo(region)
          .itemCodeEqualTo(ItemCode.PM10)
          .sortByDataTimeDesc()
          .findFirst(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }

        final statModel = snapshot.data!;
        final statusModel =
            StatusUtils.getStatusModelFromStat(statModel: statModel);

        return Scaffold(
          backgroundColor: statusModel.primaryColor,
          drawer: Drawer(
            backgroundColor: statusModel.darkColor,
            child: ListView(
              children: [
                const DrawerHeader(
                  margin: EdgeInsets.zero,
                  child: Text(
                    '지역 선택',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                ...Region.values.map(
                  (e) => ListTile(
                    selected: e == region,
                    tileColor: Colors.white,
                    selectedTileColor: statusModel.lightColor,
                    selectedColor: Colors.black,
                    onTap: () {
                      setState(() {
                        region = e;
                      });

                      Navigator.of(context).pop();
                    },
                    title: Text(
                      e.krName,
                    ),
                  ),
                )
              ],
            ),
          ),
          body: CustomScrollView(
            controller: scrollController,
            slivers: [
              MainStat(
                region: region,
                primaryColor: statusModel.primaryColor,
                isExpanded: isExpanded,
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CategoryStat(
                      region: region,
                      darkColor: statusModel.darkColor,
                      lightColor: statusModel.lightColor,
                    ),
                    HourlyStat(
                      region: region,
                      darkColor: statusModel.darkColor,
                      lightColor: statusModel.lightColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
