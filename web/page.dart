import 'dart:html';
import 'package:google_maps/google_maps.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:gex_webapp_kit_client/elements/map_geo_location.dart';

void main() {
  User user = new User();
  user.locationLat = 48.71767488407381;
  user.locationLng = 2.3899841308593883;
  MapGeoLocation map = new MapGeoLocation(querySelector("#map_canvas"), 300, "images/button/location76.png", 50, user);
  MapGeoLocation map2 =
      new MapGeoLocation(querySelector("#map_canvas2"), 300, "images/button/location76.png", 50, user);
  map.show();
  map2.show();
}
