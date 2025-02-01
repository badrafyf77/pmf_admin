import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/features/home/presentation/manager/bloc/get_home_info_bloc.dart';
import 'package:pmf_admin/features/home/presentation/view/widgets/analytic.dart';
import 'package:pmf_admin/features/home/presentation/view/widgets/home_body_item.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHomeInfoBloc, GetHomeInfoState>(
      builder: (context, state) {
        if (state is GetHomeInfoFailure) {
          return Center(
            child: IconButton(
              onPressed: () {
                BlocProvider.of<GetHomeInfoBloc>(context).add(
                  GetHomeInfo(date: DateTime.now()),
                );
              },
              icon: const Icon(Icons.refresh),
            ),
          );
        }
        if (state is GetHomeInfoSuccess) {
          return ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              children: [
                // const HomeHeader(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DashboardItem(
                            title: 'Number of leagues',
                            nmbr: state.homeInfo.leagues,
                            onTap: () {},
                          ),
                          DashboardItem(
                            title: 'Number of users',
                            nmbr: state.homeInfo.users,
                            onTap: () {},
                          ),
                          DashboardItem(
                            title: 'Visits this month',
                            nmbr: state.homeInfo.monthVisits,
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DashboardItem(
                            title: 'Number of posts',
                            nmbr: state.homeInfo.posts,
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
                      SiteAnalytic(
                        date: state.homeInfo.date,
                        visitsList: state.homeInfo.visitsList,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(child: CustomLoadingIndicator());
      },
    );
  }
}
