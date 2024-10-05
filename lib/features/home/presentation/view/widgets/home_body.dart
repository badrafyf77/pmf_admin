import 'package:pmf_admin/core/utils/services/firestore_service.dart';
import 'package:pmf_admin/features/home/presentation/view/widgets/home_body_item.dart';
import 'package:pmf_admin/features/home/presentation/view/widgets/home_header.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView(
        children: [
          const HomeHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DashboardItem(
                      title: 'Number of leagues',
                      nmbr: 2,
                      onTap: () async {
                        await addParticipationsFieldToUsers();
                      },
                    ),
                    DashboardItem(
                      title: 'Number of cups',
                      nmbr: 2,
                      onTap: () {},
                    ),
                    DashboardItem(
                      title: 'Visits this month',
                      nmbr: 2,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DashboardItem(
                      title: 'Number of players',
                      nmbr: 2,
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 100,
                      width: 270,
                    ),
                    const SizedBox(
                      height: 100,
                      width: 270,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // SiteAnalytic(
                //   date: state.eventsWeekInfo.date,
                //   visitsList: state.eventsWeekInfo.visitsList,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
