import 'package:template/pages/export.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({ Key? key }) : super(key: key);

  @override
  _AboutUsViewState createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: const AppBarScreen(
        title: AppStrings.aboutUs,
      
      ),
    );
  }
}