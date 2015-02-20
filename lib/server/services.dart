// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_server;

@app.Route("/services/shouldregister", methods: const [app.POST])
shouldRegister(@app.Attr() Db conn, @app.Body(app.JSON) Map json) {
  String openId = json["openId"].trim();
  var userCollection = conn.collection("user");
  return userCollection.findOne({"openId": openId}).then((value) {
    return {"shouldregister": (value == null)};
  });
}

@app.Route("/services/user", methods: const [app.GET])
getUser(@app.Attr() Db conn, @app.QueryParam("openId") String openId) {
  var userCollection = conn.collection("user");
  return userCollection.findOne({"openId": openId}).then((user) {
    if (user == null) {
      throw new app.ErrorResponse(404,"WRONG_OPENID" ) ;
    }

 //   var session = app.request.session;
 //   session["openid"] = user["openid"];

    return user;
  });
}

//A public service. Anyone can create a new user
@app.Route("/services/register", methods: const [app.POST])
addUser(@app.Attr() Db conn, @app.Body(app.JSON) Map json) {
  User user = new User.loadJSON(json);
  var userCollection = conn.collection("user");
  return userCollection.findOne({"openId": user.openId}).then((value) {
    if (value != null) {
      throw new app.ErrorResponse(403,"USER_EXISTS" ) ;
    }

    return userCollection.insert(user.toJSON()).then((resp) => user.toJSON());
  });
}


//A public service. Anyone can create a new user
@app.Route("/services/user", methods: const [app.POST])
saveUser(@app.Attr() Db conn, @app.Body(app.JSON) Map json) {
User user = new User.loadJSON(json);
var userCollection = conn.collection("user");
return userCollection.findOne({"openId": user.openId}).then((value) {
  if (value != null) {
    return userCollection.insert(user.toJSON()).then((resp) => user.toJSON());
  }else{
    throw new app.ErrorResponse(403,"USER_DOES_NOT_EXIST" ) ;
  }
  
});
}


//A private service. Any authenticated user can execute 'echo'
@app.Route("/services/private/echo/:arg")
echo(String arg) => arg;

//A private service. Only authenticated users with the 'ADMIN' role
//can view the list of registered users
@app.Route("/services/private/listusers")
@Secure(ADMIN)
listUsers(@app.Attr() Db conn) {
  var userCollection = conn.collection("user");
  return userCollection.find(where.excludeFields(const ["_id"])).toList();
}
