import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/features/home/presentation/manager/bloc/get_home_info_bloc.dart';
import 'package:pmf_admin/features/home/presentation/view/widgets/home_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    BlocProvider.of<GetHomeInfoBloc>(context).add(
      GetHomeInfo(date: DateTime.now()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const HomeBody();
  }
}
