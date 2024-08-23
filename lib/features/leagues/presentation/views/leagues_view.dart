import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/core/utils/customs/header.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/leagues_list.dart';
import 'package:flutter/material.dart';

class LeaguesView extends StatefulWidget {
  const LeaguesView({super.key});

  @override
  State<LeaguesView> createState() => _LeaguesViewState();
}

class _LeaguesViewState extends State<LeaguesView> {
  bool loading1 = false;
  bool loading2 = false;
  @override
  void initState() {
    super.initState();
    transitionProblemSolutionProcess();
  }

  transitionProblemSolutionProcess() async {
    await Future.delayed(const Duration(milliseconds: 500), () {});
    setState(() {
      loading1 = true;
    });
    await Future.delayed(const Duration(milliseconds: 500), () {});
    setState(() {
      loading2 = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading1
        ? loading2
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    
                    Header(
                      buttonTitle: "Add league",
                      onPressedButton: () {
                        AppRouter.navigateTo(context, AppRouter.addLeague);
                      },
                      onPressedRefresh: () {},
                    ),
                    const LeaguesList(),
                  ],
                ),
              )
            : const CustomLoadingIndicator()
        : AnimatedContainer(
            duration: const Duration(milliseconds: 250),
          );
  }
}
