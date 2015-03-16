// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_client;

class PageKeyUrlConverter {
  RegExp urlPattern = new RegExp(r"^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\#\/\w \.-]*)*\/?$");
  RegExp urlPatternWithPath = new RegExp(r"^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})/\#(.+)(£)$");

  RegExp relativeUrlPattern = new RegExp(r"^/\#(.+)$");
  RegExp relativeUrlPatternWithPath = new RegExp(r"^/\#(.+)(£)$");

  PageKey convertToPageKey(String url) {
    if (urlPattern.hasMatch(url)) {
      if (!urlPatternWithPath.hasMatch(url + "£")) {
        return new PageKey(name: "");
      }
      Match pathMatch = urlPatternWithPath.firstMatch(url + "£");
      String path = pathMatch.group(pathMatch.groupCount - 1);
      return _convertToPageKey(path);
    }

    if (relativeUrlPattern.hasMatch(url)) {
      if (!relativeUrlPatternWithPath.hasMatch(url + "£")) {
        return new PageKey(name: "");
      }
      Match pathMatch = relativeUrlPatternWithPath.firstMatch(url + "£");
      String path = pathMatch.group(pathMatch.groupCount - 1);
      return _convertToPageKey(path);
    }

    return null;
  }

  PageKey _convertToPageKey(String path) {
    String pageName = path;
    return new PageKey(name: pageName);
  }
}

class Router extends Object with ApplicationEventPassenger {
  PageKeyUrlConverter _pageKeyUrlConverter;

  Router(this._pageKeyUrlConverter);

  void init() {
    PageKey pageKey = _pageKeyUrlConverter.convertToPageKey(window.location.href);
    if (pageKey == null) {
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
      if (event.pageKey.resources != null){
        event.pageKey.resources.parameters.forEach( (p)=> url+= "/${p.key}/${p.value}" ) ;
      }
      if (event.pageKey.params != null && event.pageKey.params.parameters.isNotEmpty){
        url+= "?" ;
        event.pageKey.params.parameters.forEach( (p)=> url+= "${p.key}=${p.value}&" ) ;
        url= url.substring(0, url.length -2) ;
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
