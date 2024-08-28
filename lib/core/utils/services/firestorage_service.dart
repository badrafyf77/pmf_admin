import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class FirestorageService {
  final leaguesFolderName = "leagues";
  Reference storageRef = FirebaseStorage.instance.ref();

  Future<String> uploadFile(
      File file, String folderName, String fileName) async {
    var result = await storageRef.child("$folderName/$fileName").putFile(file);
    return await result.ref.getDownloadURL();
  }

  Future<String> updateFile(
      String oldfileName, String folderName, String newfileName) async {
    Uint8List? file =
        await storageRef.child("$folderName/$oldfileName").getData();
    await deleteFile(folderName, oldfileName);
    var result =
        await storageRef.child("$folderName/$newfileName").putData(file!);
    return await result.ref.getDownloadURL();
  }

  Future<void> deleteFile(String folderName, String fileName) async {
    await storageRef.child("$folderName/$fileName").delete();
  }
}
