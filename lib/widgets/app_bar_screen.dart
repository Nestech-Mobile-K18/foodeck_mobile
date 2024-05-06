import 'package:template/pages/export.dart';

class AppBarScreen extends StatelessWidget implements PreferredSizeWidget{
  const AppBarScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(
        title,
        style: TextStyle(fontSize: 22.dp, fontWeight: FontWeight.bold),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(8.dp),
        child: Divider(
          thickness: 8.dp,
          height: 0.dp,
          color: Colors.grey.shade100,
        ),
      ),
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize =>   Size.fromHeight(60.0.dp);
}
