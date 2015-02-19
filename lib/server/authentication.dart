// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_server;

@app.Interceptor(r'/services/private/.+')
authenticationFilter() {
  if (app.request.session["username"] == null) {
    app.chain.interrupt(statusCode: HttpStatus.UNAUTHORIZED, responseValue: {"error": "NOT_AUTHENTICATED"});
  } else {
    app.chain.next();
  }
}

@app.Route("/services/login", methods: const [app.POST])
login(@app.Attr() Db conn, @app.Body(app.JSON) Map body) {
  var userCollection = conn.collection("user");
  if (body["openid"] == null || body["email"] == null) {
    return {"success": false, "error": "NO_OPENID_OR_EMAIL"};
  }
  return userCollection.findOne({"openid": body["openid"], "email": body["email"]}).then((user) {
    if (user == null) {
      return {"success": false, "error": "WRONG_OPENID_OR_EMAIL"};
    }

    var session = app.request.session;
    session["openid"] = user["openid"];

    Set roles = new Set();
    bool admin = user["admin"];
    if (admin != null && admin) {
      roles.add(ADMIN);
    }
    session["roles"] = roles;

    return {"success": true};
  });
}

@app.Route("/services/logout")
logout() {
  app.request.session.destroy();
  return {"success": true};
}
