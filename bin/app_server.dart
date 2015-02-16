import 'dart:io' show Platform;
import 'package:path/path.dart' show join, dirname;
import 'package:redstone/server.dart' as app;
import 'package:shelf_static/shelf_static.dart';

main() {
  app.setShelfHandler(
      createStaticHandler(staticPathToServe(), defaultDocument: "index.html", serveFilesOutsidePath: true));
  app.setupConsoleLog();
  app.start(port: serverPort());
}

num serverPort() {
  var portEnv = Platform.environment['PORT'];
  var port = portEnv == null ? 9090 : int.parse(portEnv);
  return port;
}

String staticPathToServe() {
  var dartMode = Platform.environment['DART_MODE'];
  var pathToServe = join(dirname(Platform.script.toFilePath()), '..', 'build/web');
  if (dartMode == "DEV") {
    pathToServe = join(dirname(Platform.script.toFilePath()), '..', 'web');
  }

  return pathToServe;
}
