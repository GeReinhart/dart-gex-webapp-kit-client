// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.map_geo_location;

import "dart:html";
import "dart:async";
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:google_maps/google_maps.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';

/**
 * Location of a gps point on a map
 * Requiered : define proper import in the main page: see https://github.com/a14n/dart-google-maps
 */
class MapGeoLocation extends Object with Showable {
  final LatLng defaultPosition = new LatLng(45.148609248398735, 5.729827880859428);

  DivElement map;
  num mapSize;
  String markerUrl;
  User _user;
  num markerSize;
  num zindex;
  GMap _googleMap;
  Marker _marker;
  DivElement mapPosition;
  bool editionMode = true;

  MapGeoLocation(this.map, this.mapSize, this.markerUrl, this.markerSize, {this.editionMode}) {
    this.map.style
      ..position = "relative"
      ..visibility = null;
    init();
  }

  set user(User value) {
    _user = value;
    if (_user.hasLocation) {
      _setMarker(new LatLng(_user.locationLat, _user.locationLng));
    }
  }

  void init() {
    DivElement mapCanvas = new DivElement();
    mapCanvas.style
      ..height = "${mapSize}px"
      ..width = "${mapSize}px"
      ..zIndex = "${zindex}";

    mapPosition = new DivElement();

    map.append(mapCanvas);
    map.append(mapPosition);

    final mapOptions = new MapOptions()
      ..center = defaultPosition
      ..zoom = 6
      ..mapTypeId = MapTypeId.ROADMAP
      ..streetViewControl = false;

    _googleMap = new GMap(mapCanvas, mapOptions);
    _googleMap.onCenterChanged.listen((_) {
      _keepMarkerInCenter();
    });
    _googleMap.onMouseover.listen((_) {
      _canKeepMarkerInCenter = true;
    });
    _googleMap.onDrag.listen((_) {
      _canKeepMarkerInCenter = true;
    });
  }

  @override
  bool isShowed() {
    return map.style.display != "hidden";
  }

  @override
  void show() {
    map.style.display = null;
    event.trigger(_googleMap, 'resize', []);
    if (_marker != null) {
      _googleMap.panTo(_marker.position);
    }
  }

  bool _canKeepMarkerInCenter = false;
  void _keepMarkerInCenter() {
    if (_canKeepMarkerInCenter && editionMode) {
      if (_marker != null) {
        _marker.position = _googleMap.center;
        mapPosition.innerHtml = "${_googleMap.center.lat}, ${_googleMap.center.lng}";
      }
    }
  }

  @override
  void hide() {
    map.style.display = "hidden";
  }

  void geoLocation() {
    if (window.navigator.geolocation != null) {
      window.navigator.geolocation.getCurrentPosition().then((position) {
        _setMarker(new LatLng(position.coords.latitude, position.coords.longitude));
      }, onError: (error) {
        _handleNoGeolocation();
      });
    } else {
      // Browser doesn't support Geolocation
      _handleNoGeolocation();
    }
  }

  void _handleNoGeolocation() {
    _googleMap.center = defaultPosition;
    _setMarker(defaultPosition);
  }

  LatLng get location => _googleMap.center;

  void _setMarker(LatLng location) {
    // Add markers to the map

    // Marker sizes are expressed as a Size of X,Y
    // where the origin of the image (0,0) is located
    // in the top left of the image.

    // Origins, anchor positions and coordinates of the marker
    // increase in the X direction to the right and in
    // the Y direction down.
    // TODO issue for MarkerImage deprecated
    final image = new Icon()
      ..url = _user.avatarUrl
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

    var markerOptions = new MarkerOptions()
      ..position = location
      ..map = _googleMap
      //  ..shadow = shadow
      //  ..icon = image
      //  ..shape = shape
      ..title = _user.displayName;

    if (_marker == null) {
      _marker = new Marker(markerOptions);
    } else {
      _marker.options = markerOptions;
    }
    _googleMap.panTo(location);
  }
}
