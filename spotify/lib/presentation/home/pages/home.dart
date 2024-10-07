import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/basic_app_bar.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vetors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/home/widgets/news_songs.dart';
import 'package:spotify/presentation/home/widgets/play_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVetors.logo,
          height: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _homeArtistCard(),
            _tabs(),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,
                children: [
                  const NewsSongs(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const PlayList(),
          ],
        ),
      ),
    );
  }

  Widget _homeArtistCard() {
    return Stack(
      children: [
        SizedBox(
          height: 188,
          width: double.infinity,
          child: SvgPicture.asset(AppVetors.homeTopCard),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 60,
            ),
            child: Image.asset(AppImages.homeArtist),
          ),
        ),
      ],
    );
  }

  Widget _tabs() {
    const textStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
    );
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      tabAlignment: TabAlignment.center,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      indicatorColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.tab,
      padding: const EdgeInsets.only(top: 40, bottom: 40, right: 25),
      dividerHeight: 0,
      tabs: const [
        Text(
          'News',
          style: textStyle,
        ),
        Text(
          'Videos',
          style: textStyle,
        ),
        Text(
          'Artists',
          style: textStyle,
        ),
        Text(
          'Podcasts',
          style: textStyle,
        ),
      ],
    );
  }
}
