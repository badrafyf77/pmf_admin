import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/core/utils/services/firestorage_service.dart';
import 'package:pmf_admin/core/utils/services/firestore_service.dart';
import 'package:pmf_admin/core/utils/failures.dart';
import 'package:pmf_admin/features/leagues/data/repo/league_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EventsRepoImplementation implements EventsRepo {
  final FirestoreService _firestoreService;
  final FirestorageService _firestorageService;

  EventsRepoImplementation(this._firestoreService, this._firestorageService);

  @override
  Future<Either<Failure, Unit>> addEvent(String title, String description,
      String place, DateTime date, XFile? image) async {
    try {
      var id = const Uuid().v4();
      String downloadUrl;
      if (image != null) {
        File selectedImagePath = File(image.path);
        downloadUrl = await _firestorageService.uploadFile(
            selectedImagePath, _firestorageService.eventsFolderName, title);
      } else {
        return left(PickImageFailure(errMessage: 'choisir une image'));
      }
      League event = League(
        id: id,
        title: title,
        downloadUrl: downloadUrl,
        startDate: Timestamp.fromDate(date),
        players: [],
      );
      await _firestoreService.addEvent(event);
      return right(unit);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirestoreFailure.fromFirestoreFailure(e));
      }
      return left(FirestoreFailure(
          errMessage: 'il y a une erreur, veuillez réessayer'));
    }
  }

  // @override
  // Future<Either<Failure, EventsInfo>> getEventsInfo() async {
  //   try {
  //     var eventsList = await _firestoreService.getEvents();
  //     var initialEvent = await _firestoreService.getInitialEvent();
  //     EventsInfo eventsInfo =
  //         EventsInfo(eventsList: eventsList, initialEvent: initialEvent);
  //     return right(eventsInfo);
  //   } catch (e) {
  //     if (e is FirebaseException) {
  //       return left(FirestoreFailure.fromFirestoreFailure(e));
  //     }
  //     return left(FirestoreFailure(errMessage: e.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, Unit>> setInitialEvent(League event) async {
    try {
      await _firestoreService.setInitialEvent(event);
      return right(unit);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirestoreFailure.fromFirestoreFailure(e));
      }
      return left(FirestoreFailure(
          errMessage: 'il y a une erreur, veuillez réessayer'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateEvent(
      League event, String oldTitle, bool oldImage, XFile? image) async {
    try {
      String downloadUrl;
      if (!oldImage) {
        if (image != null) {
          await _firestorageService.deleteFile(
              _firestorageService.eventsFolderName, oldTitle);
          File selectedImagePath = File(image.path);
          downloadUrl = await _firestorageService.uploadFile(selectedImagePath,
              _firestorageService.eventsFolderName, event.title);
        } else {
          return left(PickImageFailure(errMessage: 'choisir une image'));
        }
      } else {
        downloadUrl = await _firestorageService.updateFile(
            oldTitle, _firestorageService.eventsFolderName, event.title);
      }
      League e = League(
        id: event.id,
        title: event.title,
        downloadUrl: downloadUrl,
        startDate: event.startDate,
        players: [],
      );
      await _firestoreService.updateEvent(e);
      League initialEvent = await _firestoreService.getInitialEvent();
      if (initialEvent.id == event.id) {
        await _firestoreService.setInitialEvent(e);
      }
      return right(unit);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirestoreFailure.fromFirestoreFailure(e));
      }
      return left(FirestoreFailure(
          errMessage: 'il y a une erreur, veuillez réessayer'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteEvent(League event) async {
    try {
      League initialEvent = await _firestoreService.getInitialEvent();
      if (initialEvent.id == event.id) {
        return left(FirestoreFailure(
            errMessage: "vous ne pouvez pas supprimer l'événement initial"));
      }
      await _firestoreService.deleteEvent(event.id);
      await _firestorageService.deleteFile(
          _firestorageService.eventsFolderName, event.title);
      return right(unit);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirestoreFailure.fromFirestoreFailure(e));
      }
      return left(FirestoreFailure(
          errMessage: 'il y a une erreur, veuillez réessayer'));
    }
  }
}
