// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_server;

const String ADMIN = "ADMIN";

class Secure {
  final String role;

  const Secure(this.role);
}

void AuthorizationPlugin(app.Manager manager) {
  manager.addRouteWrapper(Secure, (metadata, pathSegments, injector, request, route) {
    String role = (metadata as Secure).role;
    Set userRoles = app.request.session["roles"];
    if (!userRoles.contains(role)) {
      throw new app.ErrorResponse(403, {"error": "NOT_AUTHORIZED"});
    }

    return route(pathSegments, injector, request);
  }, includeGroups: true);
}
