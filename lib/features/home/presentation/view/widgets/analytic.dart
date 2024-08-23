import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/assets.dart';
import 'package:pmf_admin/features/home/presentation/manager/get%20events%20week%20info%20bloc/get_events_week_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:pmf_admin/features/home/presentation/view/widgets/bar_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

class SiteAnalytic extends StatelessWidget {
  const SiteAnalytic({
    super.key,
    required this.date,
    required this.visitsList,
  });

  final DateTime date;
  final List visitsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          AnalyticHeader(
            date: date,
          ),
          SizedBox(
            width: 600,
            height: 320,
            child: (visitsList.isEmpty)
                ? Lottie.asset(AppAssets.noData)
                : BarChartSample3(
                    date: date,
                    visitsList: visitsList,
                  ),
          ),
        ],
      ),
    );
  }
}

class AnalyticHeader extends StatefulWidget {
  const AnalyticHeader({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  State<AnalyticHeader> createState() => _AnalyticHeaderState();
}

class _AnalyticHeaderState extends State<AnalyticHeader> {
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _date = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Nombre de visites sur le site',
            style: Styles.normal16,
          ),
          TextButton(
            onPressed: () async {
              final selected =
                  await SimpleMonthYearPicker.showMonthYearPickerDialog(
                context: context,
                titleTextStyle: Styles.normal16,
                monthTextStyle: Styles.normal14,
                selectionColor: Colors.grey,
                yearTextStyle:
                    Styles.normal16.copyWith(color: AppColors.kPrimaryColor),
                disableFuture: true,
              );
              setState(() {
                _date = selected;
              });
              // ignore: use_build_context_synchronously
              BlocProvider.of<GetEventsWeekInfoBloc>(context)
                  .add(GetEventsWeekInfo(date: _date));
            },
            child: Text(
              BoardDateFormat('MM-yyyy').format(_date),
              style: Styles.normal14,
            ),
          ),
        ],
      ),
    );
  }
}
