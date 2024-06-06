import 'package:template/pages/export.dart';


class MapBoxView extends StatelessWidget {
  const MapBoxView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Map Direction'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const ShowMap(),
    );
  }
}
