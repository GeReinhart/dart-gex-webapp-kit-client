// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_client;

typedef void SuccessRequestCallback(Map json);
typedef void FailureRequestCallback(num status);

class PostJsonRequest {
  String _path;
  SuccessRequestCallback _success;
  FailureRequestCallback _failure;

  PostJsonRequest(this._path, this._success, this._failure);

  void send(Bean input) {
    HttpRequest request = new HttpRequest();
    request.onReadyStateChange.listen((_) {
      if (request.readyState == HttpRequest.DONE) {
        if (request.status == 200) {
           Map json = JSON.decode(request.responseText);
           if ( json.isEmpty ){
             _failure(404);
           }else{
            _success(json);
           }
        } else {
          _failure(request.status);
        }
      }
    });
    request.open("POST", _path, async: true);
    request.setRequestHeader("content-type", "application/json");
    request.send(JSON.encode(input.toJSON()));
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
          if ( json.isEmpty ){
            _failure(404);
          }else{
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
