import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/album/controller/album_controller.dart';
import 'package:winto/features/organization/e_commerce/features/album/screens/photo_view_screen.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';

class AlbumPage extends StatelessWidget {
  final String userId; // معرف المستخدم

  const AlbumPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AlbumController albumController = Get.put(AlbumController());
var title=isArabicLocale() ?"الألبومات":"Album";
    return Scaffold(
      appBar:CustomAppBar(title: title),
      body: SafeArea(
        child: Obx(() {
          return ListView.builder(
            itemCount: albumController.albums.length,
            itemBuilder: (context, index) {
              final album = albumController.albums[index];
              return ListTile(
                title: Text(album.name),
                subtitle: Text("عدد الصور: ${album.photoCount} | الحجم: ${album.totalSize.toStringAsFixed(2)} MB"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.to(() => PhotoViewScreen(albumId: album.id, userId: userId));
                },
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            title: "إضافة ألبوم جديد",
            content: TextField(
              decoration: InputDecoration(labelText: "اسم الألبوم"),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  albumController.addAlbum(userId, value);
                  Get.back();
                }
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
