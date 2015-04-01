// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_server;


String UserService_googleOAuthClientId;

@app.Group("/services")
@Encode()
class UserService extends MongoDbService<User> {
  UserService() : super("users");
  UserService.withTargetCollection(String collectionName) : super(collectionName);

  @app.Route("/login/:openId", methods: const [app.POST])
  Future<User> login(@Decode() User user) {
    return findOne({"openId": user.openId}).then((existingUser) {
      if (existingUser == null) {
        throw new app.ErrorResponse(404, {"error": "no user with openId ${user.openId}"});
      } else {
        String authHash = app.request.headers["authHash"];
        
        HttpClient client = new HttpClient();
        return client.openUrl("GET",  Uri.parse("https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=${authHash}"))
                  .then((c)=>c.close())
                  .then((response){
             
          return readResponse( response).then((content){
            Map json = JSON.decode(content);
            
            String audience = json["audience"];
            String user_id = json["user_id"];
            num expires_in = json["expires_in"];
            String email = json["email"];

            if ( expires_in == 0) {
              throw new app.ErrorResponse(410, {"error": "Credentials expired"});
            }
            
            if ( email != existingUser.email ||
                user_id != existingUser.openId ||
                audience !=  UserService_googleOAuthClientId
                 ){
              throw new app.ErrorResponse(403, {"error": "Credentials corrupted"});
            }
            
            
            var session = app.request.session;
            session["openid"] = existingUser.openId;
            return existingUser;
            
          });
        });
      }
    });
  }

  Future<String> readResponse(HttpClientResponse response) {
    var completer = new Completer();
    var contents = new StringBuffer();
    response.transform(UTF8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }
  
  
  bool isUserOfSession(String openId)=> app.request.session["openid"]!= null && app.request.session["openid"] == openId;
  
  
  @app.Route("/logout", methods: const [app.GET])
  Map logout() {
    app.request.session.destroy();
    return {"success": true};
  }  
  
  
  @app.Route("/register/:openId", methods: const [app.POST])
  Future<User> register(@Decode() User user) {
    return insert(user).then((_) => user);
  }

  @app.Route("/user/:openId", methods: const [app.GET])
  Future<User> get(String openId) {
    return findOne({"openId": openId}).then((user) {
      if (user == null) {
          throw new app.ErrorResponse(404, {"error": "no user with openId ${openId}"});
      } else {
        return user;
      }
    });
  }

  
  @app.Route("/users", methods: const [app.GET])
  Future<List<User>> load() { 
    return find().then((users){
      users.forEach((u){
        if (!u.isEmailVisible){
          u.email = null;
        }
      });
      return users;
    });
  }

  @app.Route("/user/:openId", methods: const [app.POST])
  Future<User> addOrUpdate(@Decode() User inputUser) {
    if(!isUserOfSession(inputUser.openId)){
      throw new app.ErrorResponse(403, {"error": "you try to update another user than yourself"});
    }
    return findOne({"openId": inputUser.openId}).then((existingUser) {
      if (existingUser == null) {
        inputUser.creation();
        return insert(inputUser).then((_) => inputUser);
      } else {
        inputUser.update();
        return update({"openId": existingUser.openId}, inputUser).then((_) => inputUser);
      }
    });
  }
}
