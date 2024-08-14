import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/core/utils/helpers/show_toast.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/edit%20event%20bloc/edit_event_bloc.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/edit_event_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditEventView extends StatelessWidget {
  const EditEventView({super.key, required this.event});

  final League event;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditEventBloc, EditEventState>(
      listener: (context, state) {
        if (state is EditEventFailure) {
          myShowToastError(context, state.err);
        }
        if (state is EditEventSuccess) {
          myShowToastSuccess(context, state.msg);
          AppRouter.navigateTo(context, AppRouter.leagues);
        }
      },
      builder: (context, state) {
        if (state is EditEventLoading) {
          return const Center(child: CustomLoadingIndicator());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              EditEventBody(
                event: event,
              ),
            ],
          ),
        );
      },
    );
  }
}
