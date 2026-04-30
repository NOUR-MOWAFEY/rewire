import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/custom_circular_loading.dart';
import '../../../../../auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import '../../../../data/models/checkin_model.dart';
import '../../../view_model/days_cubit/days_cubit.dart';
import '../../../../../../core/widgets/custom_underline_text_field.dart';

class PopUpMenuBody extends StatefulWidget {
  const PopUpMenuBody({
    super.key,
    required this.checkIn,
    required this.isCurrentUser,
    required this.isTodayItem,
  });
  final CheckInModel checkIn;
  final bool isCurrentUser;
  final bool isTodayItem;

  @override
  State<PopUpMenuBody> createState() => _PopUpMenuBodyState();
}

class _PopUpMenuBodyState extends State<PopUpMenuBody> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.checkIn.messagePublic);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !widget.isCurrentUser || !widget.isTodayItem
        ? Text(
            'Message: ${widget.checkIn.messagePublic ?? "No message"}',
            style: AppStyles.textStyle16,
          )
        : BlocConsumer<DaysCubit, DaysState>(
            listener: (context, state) {
              if (state is DaysCheckinUpdateLoaded) {
                FocusScope.of(context).unfocus();
              }
            },
            builder: (context, state) {
              return CustomUnderlineTextField(
                controller: _controller,
                hintText: 'Message',
                suffixIcon: state is DaysCheckinUpdateLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CustomCircularLoading(size: 16),
                      )
                    : IconButton(
                        onPressed: () {
                          final userId = context
                              .read<AuthCubit>()
                              .getUser()!
                              .uid;
                          context.read<DaysCubit>().updateCheckInMessage(
                            userId,
                            _controller.text,
                          );
                        },
                        icon: const Icon(Icons.send_rounded, size: 22),
                      ),
                maxLines: 2,
              );
            },
          );
  }
}
