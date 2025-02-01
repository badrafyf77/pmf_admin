import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmf_admin/features/posts/data/models/post_model.dart';
import 'package:pmf_admin/features/posts/data/repo/posts_repo.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepo _postsRepo;
  PostsCubit(this._postsRepo) : super(PostsInitial());

  Future<void> addPost(
      String description,
      DateTime date,
      XFile? image) async {
    emit(Postslaoding());
    var result = await _postsRepo.addPost(
        description, date, image);
    result.fold((left) {
      emit(PostsFailure(err: left.errMessage));
    }, (right) {
      emit(PostsSuccess());
    });
  }

  Future<void> deletePost(Post post) async {
    emit(Postslaoding());
    var result = await _postsRepo.deletePost(post);
    result.fold((left) {
      emit(PostsFailure(err: left.errMessage));
    }, (right) {
      emit(PostsSuccess());
    });
  }

  Future<void> getPosts() async {
    emit(Postslaoding());
    var result = await _postsRepo.getPosts();
    result.fold((left) {
      emit(PostsFailure(err: left.errMessage));
    }, (right) {
      emit(GetPostsSuccess(postsList: right));
    });
  }
}
