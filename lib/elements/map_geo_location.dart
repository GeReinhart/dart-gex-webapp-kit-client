// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.map_geo_location;

import "dart:html";

import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:google_maps/google_maps.dart';

/**
 * Location of a gps point on a map
 * Requiered : define proper import in the main page: see https://github.com/a14n/dart-google-maps
 */
class MapGeoLocation extends Object with Showable {
  DivElement map;
  num mapSize;
  String markerUrl;
  num markerSize;
  num zindex;
  GMap _googleMap;

  MapGeoLocation(this.map, this.mapSize, this.markerUrl, this.markerSize, this.zindex) {
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

    map.style.position = "absolute";
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

  void geoLocation() {
    if (window.navigator.geolocation != null) {
      window.navigator.geolocation.getCurrentPosition().then((position) {
        final pos = new LatLng(position.coords.latitude, position.coords.longitude);
        _googleMap.center = pos;
      }, onError: (error) {
        _handleNoGeolocation();
      });
    } else {
      // Browser doesn't support Geolocation
      _handleNoGeolocation();
    }
  }

  void _handleNoGeolocation() {
    final options = new InfoWindowOptions()..position = new LatLng(45.148609248398735, 5.729827880859428);
    _googleMap.center = options.position;
  }
}
