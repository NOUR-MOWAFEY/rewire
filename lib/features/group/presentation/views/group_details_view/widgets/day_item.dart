import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import '../../../../data/models/checkin_model.dart';
import '../../../view_model/days_cubit/days_cubit.dart';
import 'check_icon_button.dart';

class DayItem extends StatelessWidget {
  const DayItem({super.key, required this.date, required this.dayCheckins});

  final String date;
  final List<CheckInModel> dayCheckins;

  static const int _rowSize = 5;
  static const double _rowHeight = 85.0;
  static const double _dividerHeight = 8.0;

  /// Splits [list] into chunks of [size].
  List<List<T>> _chunk<T>(List<T> list, int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < list.length; i += size) {
      chunks.add(
        list.sublist(i, i + size > list.length ? list.length : i + size),
      );
    }
    return chunks;
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<AuthCubit>().getUser()!.uid;
    final isTodayItem = context.read<DaysCubit>().today == date;

    final sortedCheckins = List<CheckInModel>.from(dayCheckins);
    sortedCheckins.sort((a, b) {
      if (a.userId == currentUserId) return -1;
      if (b.userId == currentUserId) return 1;
      return 0;
    });

    if (dayCheckins.isEmpty && !Skeletonizer.of(context).enabled) {
      return const SizedBox.shrink();
    }

    final displayCheckins = dayCheckins.isEmpty
        ? [
            CheckInModel.fakeData(),
            CheckInModel.fakeData(),
            CheckInModel.fakeData(),
            CheckInModel.fakeData(),
          ]
        : sortedCheckins;

    final rows = _chunk(displayCheckins, _rowSize);
    final rowCount = rows.length;
    final containerHeight =
        rowCount * _rowHeight + (rowCount - 1) * _dividerHeight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 4),
          child: Text(
            date.isEmpty ? '0000-00-00' : date,
            style: AppStyles.textStyle14,
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          height: containerHeight,
          decoration: BoxDecoration(
            color: AppColors.transparentPrimary,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            children: [
              for (int i = 0; i < rows.length; i++) ...[
                if (i > 0)
                  Divider(
                    color: AppColors.primary,
                    indent: 12,
                    endIndent: 12,
                    height: _dividerHeight,
                  ),
                _buildRow(context, rows[i], currentUserId, isTodayItem),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(
    BuildContext context,
    List<CheckInModel>? checkins,
    String currentUserId,
    bool isTodayItem,
  ) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: checkins?.length ?? 5,
        itemBuilder: (context, index) {
          final checkIn = checkins?[index] ?? CheckInModel.fakeData();
          return CheckIconButton(
            checkIn: checkIn,
            isCurrentUser: checkIn.userId == currentUserId,
            isTodayItem: isTodayItem,
          );
        },
        separatorBuilder: (context, index) => VerticalDivider(
          color: AppColors.primary,
          indent: 16,
          endIndent: 16,
          width: 14,
        ),
      ),
    );
  }
}
