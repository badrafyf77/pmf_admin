import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pmf_admin/core/utils/services/firestorage_service.dart';
import 'package:pmf_admin/core/utils/services/firestore_service.dart';
import 'package:pmf_admin/core/utils/failures.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmf_admin/features/posts/data/models/post_model.dart';
import 'package:pmf_admin/features/posts/data/repo/posts_repo.dart';
import 'package:uuid/uuid.dart';

class PostsRepoImplementation implements  PostsRepo{
  final FirestoreService _firestoreService;
  final FirestorageService _firestorageService;

  PostsRepoImplementation(this._firestoreService, this._firestorageService);

  @override
  Future<Either<Failure, Unit>> addPost(
      String description,
      DateTime date,
      XFile? image,) async {
    try {
      var id = const Uuid().v4();
      String downloadUrl;
      if (image != null) {
        File selectedImagePath = File(image.path);
        downloadUrl = await _firestorageService.uploadFile(
            selectedImagePath, _firestorageService.postsFolderName, id);
      } else {
        return left(PickImageFailure(errMessage: 'choisir une image.'));
      }
      Post post = Post(
        id: id,
        description: description,
        downloadUrl: downloadUrl,
        date: Timestamp.fromDate(date),
      );
      await _firestoreService.addPost(post);
      return right(unit);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirestoreFailure.fromFirestoreFailure(e));
      }
      return left(FirestoreFailure(
          errMessage: 'il y a une erreur, veuillez réessayer.'));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      List<Post> postsList = await _firestoreService.getPosts();
      return right(postsList);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirestoreFailure.fromFirestoreFailure(e));
      }
      return left(FirestoreFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(Post post) async {
    try {
      await _firestoreService.deletePost(post.id);
      await _firestorageService.deleteFile(
          _firestorageService.postsFolderName, post.id);
      return right(unit);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirestoreFailure.fromFirestoreFailure(e));
      }
      return left(FirestoreFailure(errMessage: e.toString()));
    }
  }
}
