import 'package:template/pages/export.dart';

class Category extends StatelessWidget {
  const Category(
      {Key? key,
       this.height,
       this.width,
      required this.img,
      required this.title,
      this.decription,
      this.right,
      this.left,
      this.bottom,
      this.top})
      : super(key: key);
  final double? height;
  final double? width;
  final String img;
  final String title;
  final String? decription;
  final double? right;
  final double? left;
  final double? bottom;
  final double? top;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.fromLTRB(left??0, top??0, right??0, bottom??0),
      // padding: EdgeInsets.fromLTRB(left??0, top??0, right??0, bottom??0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.dp),
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0.dp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              softWrap: true,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.dp,
                  fontWeight: FontWeight.w400),
            ),
            Text(decription ?? '',
                softWrap: true,
                style: TextStyle(color: Colors.white, fontSize: 16.dp))
          ],
        ),
      ),
    );
  }
}
