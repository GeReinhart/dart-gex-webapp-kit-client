// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_common;

abstract class Bean {
  Map toJson();

  void fromJson(Map json);
}

class User implements Bean {
  @Id() String id;
  @Field() String openId;
  @Field() String email;
  @Field() String displayName;
  @Field() String avatarUrl;
  @Field() num locationLat;
  @Field() num locationLng;
  @Field() String locationAddress;
  @Field() num creationDateInMilliseconds ;
  @Field() num lastUpdateDateInMilliseconds ;  

  User([String this.id, String this.openId, String this.email, String this.displayName, String this.avatarUrl,
      num this.locationLat, num this.locationLng, String this.locationAddress]);

  User.fromFields({String this.id, String this.openId, String this.email, String this.displayName,
      String this.avatarUrl, num this.locationLat, num this.locationLng, String this.locationAddress}) {}

  User.loadJSON(Map json) {
    fromJson(json);
  }

  @override
  String toString() =>
      "User: openId:${openId}, email:${email}, displayName:${displayName}, imageUrl:${avatarUrl}, locationLat:${locationLat}, locationLng:${locationLng}, locationAddress:${locationAddress}";

  User clone() {
    return new User.fromFields(
        id: id,
        openId: openId,
        email: email,
        displayName: displayName,
        avatarUrl: avatarUrl,
        locationLat: locationLat,
        locationLng: locationLng,
        locationAddress: locationAddress);
  }

  bool get hasLocation => locationLat != null;

  DateTime get creationDate => (_buildDate(this.creationDateInMilliseconds));
  
  DateTime get lastUpdateDate  => (_buildDate(this.lastUpdateDateInMilliseconds));
  
  DateTime _buildDate(int millisecondsSinceEpoch){
    if (millisecondsSinceEpoch== null){
      return new DateTime.now();
    }else{
      return new DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    }
  }
  
  void creation(){
    this.creationDateInMilliseconds = new DateTime.now().millisecondsSinceEpoch;
    this.lastUpdateDateInMilliseconds = this.creationDateInMilliseconds;
  }
  
  void update(){
    this.lastUpdateDateInMilliseconds = new DateTime.now().millisecondsSinceEpoch;
  }
  
  @override
  Map toJson() {
    return {
      "id": id,
      "openId": openId,
      "email": email,
      "displayName": displayName,
      "avatarUrl": avatarUrl,
      "locationLat": locationLat,
      "locationLng": locationLng,
      "locationAddress": locationAddress
    };
  }

  @override
  void fromJson(Map json) {
    id = json["id"];
    openId = json["openId"];
    email = json["email"];
    displayName = json["displayName"];
    avatarUrl = json["avatarUrl"];
    locationLat = json["locationLat"];
    locationLng = json["locationLng"];
    locationAddress = json["locationAddress"];
  }
  
  
}

enum ScreenOrientation {
  LANDSCAPE,
  PORTRAIT
}

class Parameter {
  String _key;
  String _value;

  Parameter(this._key, this._value);

  String get key => _key;
  String get value => _value;

  Parameter clone() {
    return new Parameter(this._key, this._value);
  }

  @override
  String toString() => "Parameter: key:${_key}, value: ${_value}";

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + _key.hashCode;
    result = 37 * result + _value.hashCode;
    return result;
  }

  @override
  bool operator ==(other) {
    if (other is! Parameters) return false;
    Parameters that = other;
    return (that.hashCode == this.hashCode);
  }
}

class Parameters {
  List<Parameter> _parameters;

  Parameters(List<Parameter> parameters) {
    if (parameters == null) {
      _parameters = new List<Parameter>();
    } else {
      _parameters = parameters;
    }
  }

  Parameters.empty() {
    _parameters = new List<Parameter>();
  }

  Parameters.withOneParam(String key, String value) {
    _parameters = new List<Parameter>();
    _parameters.add(new Parameter(key, value));
  }

  List<Parameter> get parameters {
    List<Parameter> parameters = new List<Parameter>();
    _parameters.forEach((p) => parameters.add(p));
    return parameters;
  }

  void add(String key, String value) {
    _parameters.add(new Parameter(key, value));
  }

  Parameters clone() {
    return new Parameters(parameters);
  }

  @override
  String toString() => "Parameters: parameters:${_parameters}";

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + _parameters.hashCode;
    return result;
  }

  @override
  bool operator ==(other) {
    if (other is! Parameters) return false;
    Parameters that = other;
    return (that.hashCode == this.hashCode);
  }
}

typedef void LaunchAction(Parameters params);

class ActionDescriptor {
  String _name;
  String _description;
  LaunchAction _launchAction;

  ActionDescriptor({String name, String description, LaunchAction launchAction}) {
    _name = name;
    _description = description;
    _launchAction = launchAction;
  }

  String get name => _name;
  String get description => _description == null ? _name : _description;
  LaunchAction get launchAction => _launchAction;

  ActionDescriptor clone() {
    return new ActionDescriptor(name: _name, description: _description, launchAction: launchAction);
  }
}

class PageKey {
  String _name;
  Parameters _params;
  Parameters _resources;

  PageKey({String name, Parameters resources, Parameters params}) {
    assert(name != null);
    _name = name;
    if (params != null) {
      _params = params;
    } else {
      _params = new Parameters(null);
    }
    if (resources != null) {
      _resources = resources;
    } else {
      _resources = new Parameters(null);
    }
  }

  PageKey clone() {
    return new PageKey(name: _name, params: _params, resources: _resources);
  }

  bool get isEmpty => _name == null || _name.length == 0;

  String get name => _name;
  Parameters get params => _params.clone();
  Parameters get resources => _resources.clone();

  @override
  String toString() => "PageKey: name:${_name}, resources:${_resources}, params:${_params}";

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + _name.hashCode;
    result = 37 * result + _resources.hashCode;
    result = 37 * result + _params.hashCode;
    return result;
  }

  @override
  bool operator ==(other) {
    if (other is! PageKey) return false;
    PageKey pageKey = other;
    return (pageKey.hashCode == this.hashCode);
  }
}

class Margin {
  num _leftInPx;
  num _rightInPx;
  num _topInPx;
  num _bottomInPx;

  Margin({num leftInPx, num rightInPx, num topInPx, num bottomInPx}) {
    _leftInPx = _value(leftInPx);
    _rightInPx = _value(rightInPx);
    _topInPx = _value(topInPx);
    _bottomInPx = _value(bottomInPx);
  }

  num _value(num value) => value == null ? 0 : value;

  String get leftInPxAsString => "${_leftInPx}px";
  String get rightInPxAsString => "${_rightInPx}px";
  String get topInPxAsString => "${_topInPx}px";
  String get bottomInPxAsString => "${_bottomInPx}px";

  num get leftInPx => _leftInPx;
  num get rightInPx => _rightInPx;
  num get topInPx => _topInPx;
  num get bottomInPx => _bottomInPx;

  Margin merge({num leftInPx, num rightInPx, num topInPx, num bottomInPx}) {
    return new Margin(
        leftInPx: leftInPx == null ? _leftInPx : leftInPx,
        rightInPx: rightInPx == null ? _rightInPx : rightInPx,
        topInPx: topInPx == null ? _topInPx : topInPx,
        bottomInPx: bottomInPx == null ? _bottomInPx : bottomInPx);
  }

  Margin clone() {
    return new Margin(leftInPx: _leftInPx, rightInPx: _rightInPx, topInPx: _topInPx, bottomInPx: _bottomInPx);
  }
}

class Image {
  List<String> _mainImageUrls;
  List<String> _alternativeImageUrls;

  Image({String mainImageUrl, String mainImageUrl2, String alternativeImageUrl, String alternativeImageUrl2}) {
    _mainImageUrls = new List<String>();
    _alternativeImageUrls = new List<String>();

    _mainImageUrls.add(mainImageUrl);
    if (mainImageUrl2 != null) {
      _mainImageUrls.add(mainImageUrl2);
    }
    if (alternativeImageUrl != null) {
      _alternativeImageUrls.add(alternativeImageUrl);
    }
    if (alternativeImageUrl2 != null) {
      _alternativeImageUrls.add(alternativeImageUrl2);
    }
  }

  String get mainImageUrl => mainImageUrls[0];
  List<String> get mainImageUrls => new List<String>()..addAll(_mainImageUrls);

  String get alternativeImageUrl => _alternativeImageUrls.length > 0 ? _alternativeImageUrls[0] : mainImageUrl;
  List<String> get alternativeImageUrls => new List<String>()..addAll(_alternativeImageUrls);

  Image clone() {
    Image clone = new Image();
    clone._mainImageUrls = this.mainImageUrls;
    clone._alternativeImageUrls = this.alternativeImageUrls;
    return clone;
  }
}
