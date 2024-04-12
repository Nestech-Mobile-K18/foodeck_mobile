import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, this.imageUrl, required this.onUpload});

  final String? imageUrl;
  final void Function(String) onUpload;

  void updatePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final imageExtension = image.path.split('.').last.toLowerCase();
    final imageBytes = await image.readAsBytes();
    final userId = supabase.auth.currentUser!.id;
    final imagePath = '/$userId/profile';
    await supabase.storage.from('profiles').uploadBinary(
          imagePath,
          imageBytes,
          fileOptions: FileOptions(
            upsert: true,
            contentType: 'image/$imageExtension',
          ),
        );
    String imageUrl = supabase.storage.from('profiles').getPublicUrl(imagePath);
    imageUrl = Uri.parse(imageUrl).replace(queryParameters: {
      't': DateTime.now().millisecondsSinceEpoch.toString()
    }).toString();
    onUpload(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: updatePicture,
      child: imageUrl != null
          ? Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(imageUrl!), fit: BoxFit.cover)))
          : Container(
              width: 88,
              height: 88,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt),
                    Text('No Image'),
                  ],
                ),
              ),
            ),
    );
  }
}
