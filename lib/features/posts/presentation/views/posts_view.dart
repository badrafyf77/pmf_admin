import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/customs/header.dart';
import 'package:pmf_admin/core/utils/styles.dart';

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
          onPressedButton: () {
            AppRouter.navigateTo(context, AppRouter.addPost);
          },
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
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      BoardDateFormat('yyyy/MM/dd HH:mm')
                          .format(DateTime.now()),
                      style: Styles.normal12.copyWith(color: Colors.grey),
                    ),
                    Text(
                      'Quis autercitation labore in culpa mollit consequat ut ullamco. Amet qui exercitation est nostrud.',
                      style: Styles.normal14,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    height: 350,
                    width: 500,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                ),
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
        ),
      );
    });
  }
}
