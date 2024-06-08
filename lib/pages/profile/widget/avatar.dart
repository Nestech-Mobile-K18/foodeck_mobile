import 'package:template/source/export.dart';

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
        child: CachedNetworkImage(
            errorWidget: (context, url, error) => Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                  child: const Center(
                    child: Text('No Image'),
                  ),
                ),
            placeholder: (context, url) => Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                  child: const CircularProgressIndicator(
                    color: AppColor.globalPink,
                  ),
                ),
            imageUrl: imageUrl!,
            imageBuilder: (context, imageProvider) => Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)))));
  }
}
