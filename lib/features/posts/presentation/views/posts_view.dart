import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/customs/cashed_network_image.dart';
import 'package:pmf_admin/core/utils/customs/header.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/core/utils/customs/manage_buttons.dart';
import 'package:pmf_admin/core/utils/helpers/show_toast.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:pmf_admin/features/posts/data/models/post_model.dart';
import 'package:pmf_admin/features/posts/presentation/manager/cubit/posts_cubit.dart';

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
    BlocProvider.of<PostsCubit>(context).getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is PostsSuccess) {
          BlocProvider.of<PostsCubit>(context).getPosts();
          myShowToastSuccess(context, "Post deleted successfully!");
        }
      },
      builder: (context, state) {
        if (state is PostsFailure) {
          return RefreshIcon(
            onPressed: () {
              BlocProvider.of<PostsCubit>(context).getPosts();
            },
          );
        }
        if (state is GetPostsSuccess) {
          return Column(
            children: [
              Header(
                buttonTitle: "Add Post",
                onPressedButton: () {
                  AppRouter.navigateTo(context, AppRouter.addPost);
                },
                onPressedRefresh: () {
                  BlocProvider.of<PostsCubit>(context).getPosts();
                },
              ),
              state.postsList.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          "No Posts to show",
                          style: Styles.normal16.copyWith(color: Colors.grey),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: state.postsList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              PostItem(
                                post: state.postsList[index],
                              ),
                              const SizedBox(
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
        return const CustomLoadingIndicator();
      },
    );
  }
}

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.post,
  });

  final Post post;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  BoardDateFormat('yyyy/MM/dd HH:mm')
                      .format(post.date.toDate()),
                  style: Styles.normal12.copyWith(color: Colors.grey),
                ),
                Text(
                  post.description,
                  style: Styles.normal14,
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CustomCashedNetworkImage(
                    url: post.downloadUrl,
                    height: 350,
                    width: 500,
                  ),
                ),
                const SizedBox(height: 5),
                DeleteButton(
                  onPressed: () async {
                    final confirmation = await showCustomDialog(context);
                    if (confirmation ?? false) {
                      if (!context.mounted) return;
                      BlocProvider.of<PostsCubit>(context).deletePost(post);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<bool?> showCustomDialog(BuildContext context) => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 10,
          title: const Column(
            children: [
              Icon(Icons.warning_amber_rounded, size: 60, color: Colors.amber),
              SizedBox(height: 10),
              Text('Confirm Action',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            ],
          ),
          content: Text('Are you sure you want to perform this action?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[800])),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[800],
                      side: BorderSide(color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
