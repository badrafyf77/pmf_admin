import 'package:dartz/dartz.dart';
import 'package:pmf_admin/core/utils/failures.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmf_admin/features/posts/data/models/post_model.dart';

abstract class PostsRepo {
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, Unit>> addPost(
      String description,
      DateTime date,
      XFile? image,);
  Future<Either<Failure, Unit>> deletePost(Post post);
}
