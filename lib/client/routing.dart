// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_client;

class PageKeyUrlConverter {

  PageKey convertToPageKey(String url) {
    if (url.indexOf("#") > 0 && url.indexOf("#") != url.length - 1) {
      String path = url.substring(url.indexOf("#") + 1, url.length);
      return _convertToPageKey(path);
    }
    return null;
  }

  PageKey _convertToPageKey(String path) {
    String pageName = "" ;
    Parameters resources = new Parameters.empty();
    Parameters params = new Parameters.empty();

    if (!path.contains("/") && !path.contains("?")) {
      return new PageKey(name: path);
    }

    if (path.contains("?")){
      params = _params(  path.substring(path.indexOf("?")+1,path.length ) ) ;
      path = path.substring(0, path.indexOf("?") ) ;
    }
    
    if (! path.contains("/")){
      return new PageKey(name: path, params: params);
    }
    
    resources = _resources( path.substring(path.indexOf("/")+1,path.length )  ) ;
    pageName = path.substring(0, path.indexOf("/")) ;
    return new PageKey(name: pageName, params: params, resources: resources);
  }
  
  Parameters _params (String paramsInPath){
    Parameters params = new Parameters.empty();
    var paramsPart = paramsInPath.split("&");
    paramsPart.forEach((currentParams){
      List<String> keyValue = currentParams.split("=") ;
      if (keyValue.length == 2){
        params.add( keyValue[0],keyValue[1] ) ;
      }
    }) ;
    return params;
  }
  
  Parameters _resources (String resourcesInPath){
    Parameters resources = new Parameters.empty();    
    var resourcesParts = resourcesInPath.split("/");
    int i = 0;
    while (i + 1 < resourcesParts.length) {
      String key = resourcesParts[i];
      String value = resourcesParts[i + 1];
      resources.add(key, value);
      i += 2;
    }
    return resources;
  }
  
}

class Router extends Object with ApplicationEventPassenger {
  PageKeyUrlConverter _pageKeyUrlConverter;

  Router(this._pageKeyUrlConverter);

  void init() {
    PageKey pageKey = _pageKeyUrlConverter.convertToPageKey(window.location.href);
    if (pageKey == null || pageKey.isEmpty) {
      fireApplicationEvent(new ApplicationEvent.callIndexPage(this));
    } else {
      fireApplicationEvent(new ApplicationEvent.callPageWithKey(this, pageKey));
    }
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    if (event.isPageDisplayed) {
      String baseUrl = _baseUrl(window.location.href);
      String url = "${baseUrl}#${event.pageKey.name}";
      if (event.pageKey.resources != null) {
        event.pageKey.resources.parameters.forEach((p) => url += "/${p.key}/${p.value}");
      }
      if (event.pageKey.params != null && event.pageKey.params.parameters.isNotEmpty) {
        url += "?";
        event.pageKey.params.parameters.forEach((p) => url += "${p.key}=${p.value}&");
        url = url.substring(0, url.length - 2);
      }
      window.location.href = url;
      return;
    }
  }

  String _baseUrl(String currentUrl) {
    String baseUrl = currentUrl;
    if (currentUrl.contains("#")) {
      baseUrl = currentUrl.substring(0, currentUrl.indexOf("#"));
    }
    return baseUrl;
  }

  @override
  String toString() {
    return "Router";
  }
}
