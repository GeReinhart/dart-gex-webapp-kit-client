// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_client;

typedef void SuccessRequestCallback(Map json);
typedef void FailureRequestCallback(num status);

class PostJsonRequest {
  String _path;
  SuccessRequestCallback _success;
  FailureRequestCallback _failure;
  Map<String,String> _headers;

  PostJsonRequest(this._path, this._success, this._failure, {Map<String,String> headers}){
    _headers = headers;
  }

  void send(Bean input) {
    HttpRequest request = new HttpRequest();
    
    
    request.onReadyStateChange.listen((_) {
      if (request.readyState == HttpRequest.DONE) {
        if (request.status == 200) {
          Map json = JSON.decode(request.responseText);
          if (json.isEmpty) {
            _failure(404);
          } else {
            _success(json);
          }
        } else {
          _failure(request.status);
        }
      }
    });
    request.open("POST", _path, async: true);
    request.setRequestHeader("content-type", "application/json");
    if (_headers != null){
      _headers.forEach((k,v)=> request.setRequestHeader(k, v));
    }
    request.send(JSON.encode(input.toJson()));
  }
}

class GetJsonRequest {
  String _path;
  SuccessRequestCallback _success;
  FailureRequestCallback _failure;

  GetJsonRequest(this._path, this._success, this._failure);

  void send() {
    HttpRequest request = new HttpRequest();
    request.onReadyStateChange.listen((_) {
      if (request.readyState == HttpRequest.DONE) {
        if (request.status == 200) {
          Map json = JSON.decode(request.responseText);
          if (json.isEmpty) {
            _failure(404);
          } else {
            _success(json);
          }
        } else {
          _failure(request.status);
        }
      }
    });
    request.open("GET", _path, async: true);
    request.send();
  }
}
