import 'package:template/src/pages/export.dart';


class MapBoxPage extends StatelessWidget {
  const MapBoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Map Direction'),
        // backgroundColor: ColorsGlobal.blue2Accent,
      ),
      body: const ShowMap(),
    );
  }
}
