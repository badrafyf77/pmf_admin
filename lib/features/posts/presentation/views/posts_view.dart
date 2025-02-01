import 'package:flutter/material.dart';
import 'package:pmf_admin/core/utils/customs/header.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: PostsList(),
    );
  }
}

class PostsList extends StatefulWidget {
  const PostsList({
    super.key,
  });

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(
          buttonTitle: "Add Post",
          onPressedButton: () {},
          onPressedRefresh: () {},
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return const Column(
                children: [
                  PostItem(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: 242,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: constraints.maxWidth * .35,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: constraints.maxWidth * .57,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Expanded(child: LeagueInfo(league: league)),
                    // ManageButton(
                    //   onPressed: () {
                    //     AppRouter.navigateToWithExtra(
                    //         context, AppRouter.leagueTable, league);
                    //   },
                    // ),
                    // const SizedBox(width: 5),
                    // EditButton(
                    //   onPressed: () {
                    //     AppRouter.navigateToWithExtra(
                    //         context, AppRouter.editLeague, league);
                    //   },
                    // ),
                    // const SizedBox(width: 5),
                    // DeleteButton(
                    //   onPressed: () {
                    //     BlocProvider.of<LeaguesCubit>(context)
                    //         .deleteLeague(league);
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
