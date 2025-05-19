import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/features/album/model/album_model.dart';
import 'package:winto/features/organization/e_commerce/features/album/model/photo_model.dart';

class AlbumController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var albums = <AlbumModel>[].obs;
  var photos = <PhotoModel>[].obs;

  void fetchAlbums(String userId) async {
    var snapshot =
        await firestore.collection('albums').where('userId', isEqualTo: userId).get();
    albums.value = snapshot.docs.map((doc) => AlbumModel.fromJson(doc.data())).toList();
  }

  void addAlbum(String userId, String albumName) async {
    var newAlbum = AlbumModel(
      id: firestore.collection('albums').doc().id,
      name: albumName,
      userId: userId,
    );
    await firestore.collection('albums').doc(newAlbum.id).set(newAlbum.toJson());
    albums.add(newAlbum);
  }

  void updateAlbumName(String albumId, String newName) async {
    await firestore.collection('albums').doc(albumId).update({'name': newName});
    albums.firstWhere((album) => album.id == albumId).name = newName;
    albums.refresh();
  }

  void deleteAlbum(String albumId) async {
    await firestore.collection('albums').doc(albumId).delete();
    albums.removeWhere((album) => album.id == albumId);
  }

  void fetchPhotos(String albumId) async {
    var snapshot = await firestore.collection('photos').where('albumId', isEqualTo: albumId).get();
    photos.value = snapshot.docs.map((doc) => PhotoModel.fromJson(doc.data())).toList();
  }

  void addPhoto(String albumId, String userId, String url, double size) async {
    var newPhoto = PhotoModel(
      id: firestore.collection('photos').doc().id,
      url: url,
      size: size,
      albumId: albumId,
      userId: userId,
    );
    await firestore.collection('photos').doc(newPhoto.id).set(newPhoto.toJson());

    var album = albums.firstWhere((album) => album.id == albumId);
    album.photoCount++;
    album.totalSize += size;
    await firestore.collection('albums').doc(albumId).update({
      'photoCount': album.photoCount,
      'totalSize': album.totalSize,
    });

    photos.add(newPhoto);
  }

  void deletePhoto(String photoId, String albumId, double size) async {
    await firestore.collection('photos').doc(photoId).delete();
    photos.removeWhere((photo) => photo.id == photoId);

    var album = albums.firstWhere((album) => album!.id == albumId);
    album.photoCount--;
    album.totalSize -= size;
    await firestore.collection('albums').doc(albumId).update({
      'photoCount': album.photoCount,
      'totalSize': album.totalSize,
    });
  }
}
