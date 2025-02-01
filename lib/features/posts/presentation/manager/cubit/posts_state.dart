part of 'posts_cubit.dart';

sealed class PostsState {}

final class PostsInitial extends PostsState {}

final class Postslaoding extends PostsState {}

final class PostsSuccess extends PostsState {}

final class PostsFailure extends PostsState {
  final String err;

  PostsFailure({required this.err});
}

final class GetPostsSuccess extends PostsState {
  final List<Post> postsList;

  GetPostsSuccess({required this.postsList});
}