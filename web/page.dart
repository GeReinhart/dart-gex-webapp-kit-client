import 'dart:html';
import 'package:google_maps/google_maps.dart';

void main() {
  new MapGeoLocation("map", 300, "images/button/location76.png", 50, 100);
}

class MapGeoLocation {
  String mapId;
  num mapSize;
  String markerUrl;
  num markerSize;
  num zindex;
  GMap _googleMap;

  MapGeoLocation(this.mapId, this.mapSize, this.markerUrl, this.markerSize, this.zindex) {
    DivElement mapCanvas = new DivElement();
    mapCanvas.style
      ..height = "${mapSize}px"
      ..width = "${mapSize}px"
      ..zIndex = "${zindex}";

    ImageElement marker = new ImageElement(src: markerUrl, width: markerSize, height: markerSize);
    marker.style
      ..position = "absolute"
      ..top = "${mapSize / 2 - markerSize}px"
      ..left = "${mapSize / 2 - markerSize / 2}px"
      ..zIndex = "${zindex+1}";

    DivElement mapPosition = new DivElement();

    map.append(mapCanvas);
    map.append(marker);
    map.append(mapPosition);

    final mapOptions = new MapOptions()
      ..zoom = 6
      ..mapTypeId = MapTypeId.ROADMAP
      ..streetViewControl = false;
    _googleMap = new GMap(mapCanvas, mapOptions);

    _googleMap.onCenterChanged.listen((_) {
      mapPosition.innerHtml = "${_googleMap.center.lat}, ${_googleMap.center.lng}";
    });

    geoLocation();
  }

  DivElement get map => querySelector("#${mapId}") as DivElement;

  void geoLocation() {
    if (window.navigator.geolocation != null) {
      window.navigator.geolocation.getCurrentPosition().then((position) {
        final pos = new LatLng(position.coords.latitude, position.coords.longitude);

        final infowindow = new InfoWindow(new InfoWindowOptions()
          ..position = pos
          ..content = 'Location found using HTML5.');
        infowindow.open(_googleMap);
        _googleMap.center = pos;
      }, onError: (error) {
        _handleNoGeolocation(true);
      });
    } else {
      // Browser doesn't support Geolocation
      _handleNoGeolocation(false);
    }
  }

  void _handleNoGeolocation(bool errorFlag) {
    String content;
    if (errorFlag) {
      content = 'Error: The Geolocation service failed.';
    } else {
      content = 'Error: Your browser doesn\'t support geolocation.';
    }

    final options = new InfoWindowOptions()
      ..position = new LatLng(45.148609248398735, 5.729827880859428)
      ..content = content;

    final infowindow = new InfoWindow(options);
    infowindow.open(_googleMap);
    _googleMap.center = options.position;
  }
}
