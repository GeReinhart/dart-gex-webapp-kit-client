// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_server;

class MongoDbPool extends ConnectionPool<Db> {
  String uri;

  MongoDbPool(String this.uri, int poolSize) : super(poolSize);

  @override
  void closeConnection(Db conn) {
    conn.close();
  }

  @override
  Future<Db> openNewConnection() {
    var conn = new Db(uri);
    return conn.open().then((_) => conn);
  }
}

@app.Interceptor(r'/services/.+')
dbManager(MongoDbPool pool) {
  pool.getConnection().then((managedConnection) {
    app.request.attributes["conn"] = managedConnection.conn;
    app.chain.next(() {
      if (app.chain.error is ConnectionException) {
        pool.releaseConnection(managedConnection, markAsInvalid: true);
      } else {
        pool.releaseConnection(managedConnection);
      }
    });
  });
}
