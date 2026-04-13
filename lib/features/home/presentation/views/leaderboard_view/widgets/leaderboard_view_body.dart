import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/presentation/views/settings_view.dart';

class LeaderboardViewBody extends StatelessWidget {
  const LeaderboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const SizedBox(height: 60),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: const Text('Leaderboard', style: AppStyles.textStyle28),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsView()),
                  );
                },
                icon: Icon(Icons.add_circle, color: AppColors.white, size: 26),
              ),
            ),
          ],
        ),
        const SizedBox(height: 60),

        Expanded(
          child: ListView.separated(
            itemCount: 5,
            itemBuilder: (context, index) => LeaderboardItem(),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 16);
            },
          ),
        ),
      ],
    );
  }
}

class LeaderboardItem extends StatelessWidget {
  const LeaderboardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),

      height: 290,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,

      decoration: BoxDecoration(
        color: AppColors.transparentPrimary.withValues(alpha: 0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            Align(
              alignment: .topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 6, top: 18),
                child: Text(
                  'First Group',
                  style: AppStyles.textStyle22.copyWith(
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const Spacer(),

            Row(
              crossAxisAlignment: .end,
              children: [
                LeaderboardStage(
                  bgColor: AppColors.silver.withValues(alpha: 0.2),
                  borderColor: AppColors.silver,
                  crownColor: const Color.fromARGB(255, 223, 223, 223),
                  iconAtTheTop: FontAwesomeIcons.two,
                  height: 150,
                ),

                const SizedBox(width: 8),

                LeaderboardStage(
                  bgColor: AppColors.gold.withValues(alpha: 0.2),
                  borderColor: AppColors.gold,
                  crownColor: Colors.yellowAccent,
                  iconAtTheTop: FontAwesomeIcons.one,
                  height: 180,
                ),

                const SizedBox(width: 8),

                LeaderboardStage(
                  bgColor: AppColors.bronze.withValues(alpha: 0.2),
                  borderColor: AppColors.bronze,
                  crownColor: const Color.fromARGB(255, 255, 159, 63),
                  iconAtTheTop: FontAwesomeIcons.three,
                  height: 115,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LeaderboardStage extends StatelessWidget {
  const LeaderboardStage({
    super.key,
    required this.bgColor,
    required this.crownColor,
    required this.height,
    required this.borderColor,
    required this.iconAtTheTop,
  });

  final Color bgColor;
  final Color borderColor;
  final Color crownColor;
  final double height;
  final IconData iconAtTheTop;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: .stretch,

        children: [
          Row(
            mainAxisAlignment: .center,

            children: [
              Icon(FontAwesomeIcons.hashtag, size: 22),
              Icon(iconAtTheTop, size: 22),
            ],
          ),

          SizedBox(height: 8),

          Container(
            height: height,

            decoration: BoxDecoration(
              color: bgColor,

              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),

              border: Border.all(color: borderColor, width: 2),
            ),

            child: Column(
              mainAxisAlignment: .center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Transform.rotate(
                    angle: -0.3,
                    child: Icon(FontAwesomeIcons.crown, color: crownColor),
                  ),
                ),

                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/pic.png'),
                ),

                const SizedBox(height: 4),

                Text(
                  'Nour Mowafey',
                  style: AppStyles.textStyle12.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
