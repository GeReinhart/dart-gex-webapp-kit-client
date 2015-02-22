// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_server;

@app.Group("/services")
@Encode()
class UserService extends MongoDbService<User> {

  UserService() : super("users");
  UserService.withTargetCollection(String collectionName) : super(collectionName);

  @app.Route("/login/:openId", methods: const [app.POST])
  Future<User> login(@Decode() User user) {
    return findOne({"openId": user.openId}).then((user) {
        if (user == null){
          return new User();
        }else{
          return user ;
        }
    });
  } 
  
  @app.Route("/register/:openId", methods: const [app.POST])
  Future<User> register(@Decode() User user) {
    return insert(user).then((_) => user);
  }
  
  
  @app.Route("/user/:openId", methods: const [app.GET])
  Future<User> get(String openId) {
    return findOne({"openId": openId}).then((user) {
      if (user == null){
        return new User();
      }else{
        return user ;
      }
    });
  }
  
  @app.Route("/users", methods: const [app.GET])
  Future<List<User>> load() => find();

  @app.Route("/user/:openId", methods: const [app.POST])
  Future<User> addOrUpdate(@Decode() User inputUser) {
    return findOne({"openId": inputUser.openId}).then((existingUser) {
      if (existingUser == null) {
        return insert(inputUser).then((_) => inputUser);
      }else{
        return update({"openId": existingUser.openId},inputUser).then((_) => inputUser);
      }
    });
  }

  @app.Route("/user/:openId", methods: const [app.DELETE])
  Future<bool> delete(String openId) =>
    remove(where.id(ObjectId.parse(openId))).then((_) => true);

}


