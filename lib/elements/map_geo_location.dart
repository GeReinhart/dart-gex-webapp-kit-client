// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.map_geo_location;

import "dart:html";

import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:google_maps/google_maps.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';

/**
 * Location of a gps point on a map
 * Requiered : define proper import in the main page: see https://github.com/a14n/dart-google-maps
 */
class MapGeoLocation extends Object with Showable {
  DivElement map;
  num mapSize;
  String markerUrl;
  User user;
  num markerSize;
  num zindex;
  GMap _googleMap;
  Marker _marker;

  MapGeoLocation(this.map, this.mapSize, this.markerUrl, this.markerSize, this.user) {
    DivElement mapCanvas = new DivElement();
    mapCanvas.style
      ..height = "${mapSize}px"
      ..width = "${mapSize}px"
      ..zIndex = "${zindex}";

    DivElement mapPosition = new DivElement();

    map.append(mapCanvas);
    map.append(mapPosition);

    final mapOptions = new MapOptions()
      ..zoom = 6
      ..mapTypeId = MapTypeId.ROADMAP
      ..streetViewControl = false;

    _googleMap = new GMap(mapCanvas, mapOptions);

    _googleMap.onCenterChanged.listen((_) {
      if (_marker != null) {
        _marker.position = _googleMap.center;
      }
      mapPosition.innerHtml = "${_googleMap.center.lat}, ${_googleMap.center.lng}";
    });

    if (user.hasLocation) {
      _googleMap.center = new LatLng(user.locationLat, user.locationLng);
      setMarker(_googleMap.center);
    } else {
      geoLocation();
    }
  }

  void geoLocation() {
    if (window.navigator.geolocation != null) {
      window.navigator.geolocation.getCurrentPosition().then((position) {
        final pos = new LatLng(position.coords.latitude, position.coords.longitude);
        _googleMap.center = pos;
        setMarker(pos);
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
    setMarker(options.position);
  }

  LatLng get location => _googleMap.center;
  set location(LatLng value) => _googleMap.center = value;

  void setMarker(LatLng location) {
    // Add markers to the map

    // Marker sizes are expressed as a Size of X,Y
    // where the origin of the image (0,0) is located
    // in the top left of the image.

    // Origins, anchor positions and coordinates of the marker
    // increase in the X direction to the right and in
    // the Y direction down.
    // TODO issue for MarkerImage deprecated
    final image = new Icon()
      ..url = user.avatarUrl
      // This marker is 20 pixels wide by 32 pixels tall.
      ..size = new Size(20, 32)
      // The origin for this image is 0,0.
      ..origin = new Point(0, 0)
      // The anchor for this image is the base of the flagpole at 0,32.
      ..anchor = new Point(0, 32);
    // TODO issue for MarkerImage deprecated
    final shadow = new Icon()
      ..url = this.markerUrl
      // The shadow image is larger in the horizontal dimension
      // while the position and offset are the same as for the main image.
      ..size = new Size(37, 32)
      ..origin = new Point(0, 0)
      ..anchor = new Point(0, 32);
    // Shapes define the clickable region of the icon.
    // The type defines an HTML &lt;area&gt; element 'poly' which
    // traces out a polygon as a series of X,Y points. The final
    // coordinate closes the poly by connecting to the first
    // coordinate.
    final shape = new MarkerShape()
      ..coords = [1, 1, 1, 20, 18, 20, 18, 1]
      ..type = MarkerShapeType.POLY;
    var myLatLng = location;
    _marker = new Marker(new MarkerOptions()
      ..position = myLatLng
      ..map = _googleMap
      //  ..shadow = shadow
      //  ..icon = image
      //  ..shape = shape
      ..title = user.displayName);
  }
}
