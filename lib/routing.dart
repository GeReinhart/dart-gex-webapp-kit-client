part of gex_common_ui_elements;


class PageKeyUrlConverter{
  
  RegExp urlPattern         = new RegExp(r"^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\#\/\w \.-]*)*\/?$");
  RegExp urlPatternWithPath = new RegExp(r"^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})/\#(.+)(£)$");

  RegExp relativeUrlPattern = new RegExp(r"^/\#(.+)$");
  RegExp relativeUrlPatternWithPath = new RegExp(r"^/\#(.+)(£)$");  
  
  PageKey convertToPageKey(String url){
    
    if ( urlPattern.hasMatch(url) ){
      if ( !urlPatternWithPath.hasMatch(url + "£") ){
        return new PageKey(name: "");
      }
      Match pathMatch = urlPatternWithPath.firstMatch(url + "£");
      String path = pathMatch.group( pathMatch.groupCount - 1 );
      return _convertToPageKey( path) ;
    }
    
    if ( relativeUrlPattern.hasMatch(url) ){
      if ( !relativeUrlPatternWithPath.hasMatch(url + "£") ){
        return new PageKey(name: "");
      }
      Match pathMatch = relativeUrlPatternWithPath.firstMatch(url + "£");
      String path = pathMatch.group( pathMatch.groupCount - 1 );
      return _convertToPageKey( path) ;
    }
    
    return null ;
  }
  
  
  PageKey _convertToPageKey(String path){
    String pageName = path ;
    return new PageKey( name: pageName);
  }
  
}

class Router extends Object with ApplicationEventPassenger{
  
  PageKeyUrlConverter _pageKeyUrlConverter ;
  
  Router(this._pageKeyUrlConverter);
  
  void init(){
    
    PageKey pageKey = _pageKeyUrlConverter.convertToPageKey(window.location.href) ;
    if (pageKey != null){
      fireApplicationEvent(new PageCallEvent.fromPageKey(this,pageKey )  );
    }
    
  }
  
}