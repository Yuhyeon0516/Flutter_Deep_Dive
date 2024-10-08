import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vetors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/choose_mode/pages/choose_mode.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.introBG),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 40,
            ),
            color: Colors.black.withOpacity(0.15),
            child: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(AppVetors.logo),
                  ),
                  const Spacer(),
                  const Text(
                    'Enjoy Listening To Music',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  const Text(
                    '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
''',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  BasicAppButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChooseModePage(),
                          ),
                        );
                      },
                      title: 'Get Started')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
