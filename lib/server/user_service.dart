// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_server;


class CrudUserService  {

  MongoDbService _mongoDbService ;
  
  CrudUserService(this._mongoDbService) ;

  Future<User> login(@Decode() User user) {
    return _mongoDbService.findOne({"openId": user.openId}).then((user) {
        if (user == null){
          return new User();
        }else{
          return user ;
        }
    });
  } 
  
  Future<User> register(@Decode() User user) {
    return _mongoDbService.insert(user).then((_) => user);
  }
  
  
  Future<User> get(String openId) {
    return _mongoDbService.findOne({"openId": openId}).then((user) {
      if (user == null){
        return new User();
      }else{
        return user ;
      }
    });
  }
  
  Future<List<User>> load() => _mongoDbService.find();

  Future<User> addOrUpdate(@Decode() User inputUser) {
    return _mongoDbService.findOne({"openId": inputUser.openId}).then((existingUser) {
      if (existingUser == null) {
        return _mongoDbService.insert(inputUser).then((_) => inputUser);
      }else{
        return _mongoDbService.update({"openId": existingUser.openId},inputUser).then((_) => inputUser);
      }
    });
  }

  Future<bool> delete(String openId) =>
      _mongoDbService.remove(where.id(ObjectId.parse(openId))).then((_) => true);

}

@app.Group("/services")
@Encode()
class UserService {
  
  CrudUserService _service ;
  
  UserService(){
    _service = new CrudUserService( new MongoDbService("users") ); 
  }
  
  @app.Route("/login/:openId", methods: const [app.POST])
    Future<User> login(@Decode() User user) {
      return _service.login(user) ;
    } 
    
    @app.Route("/register/:openId", methods: const [app.POST])
    Future<User> register(@Decode() User user) {
      return _service.register(user);
    }
    
    
    @app.Route("/user/:openId", methods: const [app.GET])
    Future<User> get(String openId) {
      return _service.get(openId);
    }
    
    @app.Route("/users", methods: const [app.GET])
    Future<List<User>> load() => _service.load();

    @app.Route("/user/:openId", methods: const [app.POST])
    Future<User> addOrUpdate(@Decode() User inputUser) {
      return _service.addOrUpdate(inputUser);
    }

    @app.Route("/user/:openId", methods: const [app.DELETE])
    Future<bool> delete(String openId) =>
        _service.delete(openId);

}