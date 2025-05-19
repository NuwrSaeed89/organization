import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/features/album/controller/album_controller.dart';
import 'package:winto/features/organization/e_commerce/features/album/controller/image_services.dart';


class PhotoViewScreen extends StatelessWidget {
  final String albumId;
  final String userId;

  const PhotoViewScreen({Key? key, required this.albumId, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AlbumController albumController = Get.find<AlbumController>();

    return Scaffold(
      appBar: AppBar(title: const Text("صور الألبوم")),
      body: SafeArea(
        child: Obx(() {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: albumController.photos.length,
            itemBuilder: (context, index) {
              final photo = albumController.photos[index];
              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(photo.url, fit: BoxFit.cover),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => albumController.deletePhoto(photo.id, albumId, photo.size),
                    ),
                  ),
                ],
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
           final imageData = await ImagePickerService.pickImage();
          if (imageData != null) {
            albumController.addPhoto(albumId, userId, imageData.url, imageData.size);
          }
        },
        child: Icon(Icons.upload),
      ),
    );
  }
}
