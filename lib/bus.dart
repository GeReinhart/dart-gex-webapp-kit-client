part of gex_common_ui_elements;

typedef void ApplicationEventCallBack(ApplicationEvent event);

class ApplicationEvent {
  Object _sender;
  String _name ;
  Parameters _params;
  
  ApplicationEvent({Object sender, String name, Parameters params} ){
    assert( sender != null );
    assert( name != null );
    
    _sender = sender ;
    _name = name ;
    if (params == null){
      _params = new Parameters(null);
    }else{
      _params = params;
    }
  }
  
  Object get sender => _sender ;
  String get name => _name ;
  Parameters get params => _params;
  
  bool iAmTheSender(Object other){
    return identical(this, other);
  }
  
}

class CallingAnotherPage extends ApplicationEvent {
  CallingAnotherPage({Object sender, String pageName, Parameters params} ):
      super(sender:sender, name: "CallingAnotherPage"  , params: params..add("pageName", pageName));
}


class ApplicationEventBus {
  StreamController<ApplicationEvent> _applicationEventStream = new StreamController<ApplicationEvent>.broadcast(sync: true);

  void subscribeApplicationChanges( ApplicationEventCallBack callBack  ){
    _applicationEventStream.stream.listen((ApplicationEvent event) => callBack(event));
  }

  void fireApplicationEvent(ApplicationEvent event){
    _applicationEventStream.add( event ) ;
  }
}


class ApplicationEventPassenger {
  
  ApplicationEventBus _applicationEventBus ;
  
  void setApplicationEventBus (ApplicationEventBus value){
    _applicationEventBus = value;
    _applicationEventBus.subscribeApplicationChanges(recieveApplicationEvent);
  }
  
  void fireApplicationEvent(ApplicationEvent event) {
    _applicationEventBus.fireApplicationEvent(event) ;
  }
  
  void recieveApplicationEvent(ApplicationEvent event) {
  }
  
}

class ApplicationEventCallBackHolder{
  
  ApplicationEventCallBack _applicationEventCallBack;
  
  ApplicationEventCallBack get applicationEventCallBack =>  _applicationEventCallBack ;
  set applicationEventCallBack( ApplicationEventCallBack value ){
    _applicationEventCallBack = value; 
  }
  void recieveApplicationEvent(ApplicationEvent event){
    if (_applicationEventCallBack != null ){
      _applicationEventCallBack(event);
    }
  }
  
}
