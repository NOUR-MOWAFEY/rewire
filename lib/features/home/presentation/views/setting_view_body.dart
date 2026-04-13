import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';

class SettingViewBody extends StatelessWidget {
  const SettingViewBody({super.key});

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
                  Navigator.pop(context);
                },
                icon: Icon(Icons.add_circle, color: AppColors.white, size: 26),
              ),
            ),
          ],
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.separated(
              itemCount: 5,
              itemBuilder: (context, index) => Column(
                children: [
                  index == 0
                      ? const SizedBox(height: 60)
                      : const SizedBox(height: 0),

                  LeaderboardItem(),

                  index == 4 ? const SizedBox(height: 100) : const SizedBox(),
                ],
              ),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 16);
              },
            ),
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
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14, top: 8),
          child: Text(
            'First group',
            style: AppStyles.textStyle22.copyWith(letterSpacing: 2),
          ),
        ),

        SizedBox(height: 8),

        Container(
          height: 290,
          width: double.infinity,

          padding: EdgeInsets.symmetric(vertical: 8),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.transparentPrimary.withValues(alpha: .2),
          ),

          child: Column(
            children: [
              LeaderboardStage(
                crownColor: AppColors.gold,
                numberIcon: FontAwesomeIcons.one,
              ),

              Divider(
                indent: 38,
                endIndent: 38,
                height: 4,
                color: AppColors.transparentPrimary,
              ),

              LeaderboardStage(
                crownColor: AppColors.silver,
                numberIcon: FontAwesomeIcons.two,
              ),

              Divider(
                indent: 38,
                endIndent: 38,
                height: 4,
                color: AppColors.transparentPrimary,
              ),

              LeaderboardStage(
                crownColor: AppColors.bronze,
                numberIcon: FontAwesomeIcons.three,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LeaderboardStage extends StatelessWidget {
  const LeaderboardStage({
    super.key,
    required this.crownColor,
    required this.numberIcon,
  });

  final Color crownColor;
  final IconData numberIcon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: .start,

              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Transform.rotate(
                    angle: -0.35,
                    child: Icon(FontAwesomeIcons.crown, color: crownColor),
                  ),
                ),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/pic.png'),
                      ),
                    ),

                    SizedBox(width: 8),

                    Text(
                      'Nour Mowafey',
                      style: AppStyles.textStyle16.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Spacer(),

            Row(
              children: [
                Icon(FontAwesomeIcons.hashtag, size: 22),
                Icon(numberIcon, size: 22),
              ],
            ),

            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
