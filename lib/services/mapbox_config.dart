import 'package:latlong2/latlong.dart';

class MapBoxConfig {
  static const MY_POSITION = LatLng(11.0190, 106.6902);
  // ignore: constant_identifier_names
  static const MAPBOX_ACCESS_TOKEN =
      'pk.eyJ1Ijoia3VuaGFuMTIxMiIsImEiOiJjbHJid2FkcGEwbW4zMmpwMXdyOG5yaWVyIn0.Gl4zaYhezd7U7Mhl7GoHNw';
  static const URL_TEMPLATE =
      'https://api.mapbox.com/styles/v1/kunhan1212/clm4cv8yt00t201r7e0vrchbt/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia3VuaGFuMTIxMiIsImEiOiJjbHJid2FkcGEwbW4zMmpwMXdyOG5yaWVyIn0.Gl4zaYhezd7U7Mhl7GoHNw';
  static const BASE_URL_MAPBOX =
      'https://api.mapbox.com/geocoding/v5/mapbox.places/';
}
