// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_client;

typedef void ApplicationEventCallBack(ApplicationEvent event);


enum EventStatus{
  CALL,CHANGE,SUCCESS,FAILURE,DISPLAYED,CUSTOM
}

enum EventType{
  VIEW_PORT,PAGE,AUTH,LOGIN,LOGOUT,USER_DETAILS,REGISTER,CUSTOM
}

enum EventError{
  UNKNOWN, NOT_FOUND
}

enum EventPageType{
  INDEX,BACK,REGISTER,PROFILE,CUSTOM 
}

class ApplicationEvent {
  Object _sender;
  EventStatus _status;
  EventType _type;
  EventError _error;
  String _errorDetails;
  User _user;
  PageKey _pageKey ;
  ViewPortModel _viewPortModel;
  EventPageType _pageType;

  ApplicationEvent(Object sender, {EventStatus status, EventType type, EventError error, User user, String errorDetails,EventPageType pageType, PageKey pageKey,ViewPortModel viewPortModel}) {
    assert(sender != null);
    _sender = sender;
    if (status == null){
      _status = EventStatus.CUSTOM;
    }else{
      _status = status;
    }
    if (type == null){
      _type = EventType.CUSTOM;
    }else{
      _type = type;
    } 
    _error = error;
    _user = user;
    _errorDetails = errorDetails;
    _pageKey=pageKey;
    _pageType=pageType;
    _viewPortModel = viewPortModel;
  }

  bool _statusIs(EventStatus param) => (status!=null && status==param ) ;
  bool _eventTypeIs(EventType param) => (type!=null && type==param) ;
  bool _pageTypeIs(EventPageType param) => (pageType!=null && pageType==param) ;
  bool get _hasPageKey =>_pageKey !=null ;
  bool get _hasUser =>_user !=null ;
  
  factory ApplicationEvent.callIndexPage(Object sender){
    return new ApplicationEvent(sender,status: EventStatus.CALL, type: EventType.PAGE, pageType:  EventPageType.INDEX  ) ;
  }
  bool get isCallIndexPage => _statusIs(EventStatus.CALL)  && _eventTypeIs(EventType.PAGE) && _pageTypeIs(EventPageType.INDEX);

  factory ApplicationEvent.callPage(Object sender,String name, {Parameters resources, Parameters params}){
    PageKey pageKey = new PageKey(name:name,resources: resources,params: params) ;
    return new ApplicationEvent.callPageWithKey( sender, pageKey) ;
  }  

  factory ApplicationEvent.callPageWithKey(Object sender,PageKey pageKey){
    return new ApplicationEvent(sender,status: EventStatus.CALL, type: EventType.PAGE, pageType:  EventPageType.CUSTOM , pageKey: pageKey  ) ;
  }
  bool get isCallPage => _statusIs(EventStatus.CALL)  && _eventTypeIs(EventType.PAGE) && _pageTypeIs(EventPageType.CUSTOM) && _hasPageKey;
  
  factory ApplicationEvent.callRegisterPage(Object sender, User user){
      return new ApplicationEvent(sender,status: EventStatus.CALL, type: EventType.PAGE, pageType:  EventPageType.REGISTER, user:user   ) ;
  }
  bool get isCallRegisterPage => _statusIs(EventStatus.CALL)  && _eventTypeIs(EventType.PAGE) && _pageTypeIs(EventPageType.REGISTER) && _hasUser;

  factory ApplicationEvent.pageDisplayed(Object sender,String name, {Parameters resources, Parameters params}){
    PageKey pageKey = new PageKey(name:name,resources: resources,params: params) ;
    return new ApplicationEvent.pageDisplayedWithKey( sender, pageKey) ;
  }  

  factory ApplicationEvent.pageDisplayedWithKey(Object sender,PageKey pageKey){
    return new ApplicationEvent(sender,status: EventStatus.DISPLAYED, type: EventType.PAGE, pageType:  EventPageType.CUSTOM , pageKey: pageKey  ) ;
  }
  bool get isPageDisplayed => _statusIs(EventStatus.DISPLAYED)  && _eventTypeIs(EventType.PAGE) && _pageTypeIs(EventPageType.CUSTOM) && _hasPageKey;
  
  factory ApplicationEvent.callUserAuth(Object sender){
      return new ApplicationEvent(sender,status: EventStatus.CALL, type: EventType.AUTH  ) ;
  }  
  bool get isCallUserAuth => _statusIs(EventStatus.CALL)  &&  _eventTypeIs(EventType.AUTH) ;  

  factory ApplicationEvent.userAuthFail(Object sender, String errorDetails){
      return new ApplicationEvent(sender,status: EventStatus.FAILURE, type: EventType.AUTH,  errorDetails: errorDetails   ) ;
  }
  bool get isUserAuthFail => _statusIs(EventStatus.FAILURE)  &&  _eventTypeIs(EventType.AUTH) ;   

  factory ApplicationEvent.userAuthSuccess(Object sender, User user){
      return new ApplicationEvent(sender,status: EventStatus.SUCCESS, type: EventType.AUTH,  user:user  ) ;
  }
  bool get isUserAuthSuccess => _statusIs(EventStatus.SUCCESS)  &&  _eventTypeIs(EventType.AUTH) && _hasUser;     

  factory ApplicationEvent.callRegister(Object sender, User user){
      return new ApplicationEvent(sender,status: EventStatus.CALL, type: EventType.REGISTER,  user:user  ) ;
  }
  bool get isCallRegister => _statusIs(EventStatus.CALL)  &&  _eventTypeIs(EventType.REGISTER) && _hasUser;     

  factory ApplicationEvent.loginSuccess(Object sender, User user){
      return new ApplicationEvent(sender,status: EventStatus.SUCCESS, type: EventType.LOGIN,  user:user   ) ;
  }  
  bool get isLoginSuccess => _statusIs(EventStatus.SUCCESS)  &&  _eventTypeIs(EventType.LOGIN) && _hasUser;       
  
  factory ApplicationEvent.registerSuccess(Object sender, User user){
      return new ApplicationEvent(sender,status: EventStatus.SUCCESS, type: EventType.REGISTER,  user:user   ) ;
  }  
  bool get isRegisterSuccess => _statusIs(EventStatus.SUCCESS)  &&  _eventTypeIs(EventType.REGISTER) && _hasUser;         
    
  factory ApplicationEvent.logoutSuccess(Object sender, User user){
      return new ApplicationEvent(sender,status: EventStatus.SUCCESS, type: EventType.LOGOUT,  user:user   ) ;
  }  
  bool get isLogoutSuccess => _statusIs(EventStatus.SUCCESS)  &&  _eventTypeIs(EventType.LOGOUT) && _hasUser; 
  
  factory ApplicationEvent.viewPortChange(Object sender, ViewPortModel viewPortModel){
      return new ApplicationEvent(sender,status: EventStatus.CHANGE, type: EventType.VIEW_PORT,  viewPortModel:viewPortModel   ) ;
  }  
  bool get isViewPortChange => _statusIs(EventStatus.CHANGE)  &&  _eventTypeIs(EventType.VIEW_PORT) && _viewPortModel!=null;   
  
  Object get sender => _sender;
  EventStatus get status => _status;
  EventType get type => _type;
  EventError get error => _error;
  String get errorDetails => _errorDetails;
  User get user => _user;
  PageKey get pageKey => _pageKey;
  EventPageType get pageType => _pageType;
  ViewPortModel get viewPort => _viewPortModel;
  
  
  @override
  String toString() {
    String errorToString = _error == null ? "" :  ", error=${_error}, errorDetails=${_errorDetails}" ;
    String userToString = _user == null ? "" :  ", user=${_user}" ;
    String pageToString = _pageKey == null ? "" :  ", pageKey=${_pageKey}" ;
    String pageTypeToString = _pageType == null ? "" :  ", pageType=${_pageType}" ;
    String viewPortToString = _viewPortModel == null ? "" :  ", viewPort=${_viewPortModel}" ;
    return "ApplicationEvent: sender=${sender}, status=${_status}, type=${_type}${errorToString}${userToString}${pageToString}${pageTypeToString}${viewPortToString}";
  }
}

class ApplicationEventBus {
  StreamController<ApplicationEvent> _applicationEventStream =
      new StreamController<ApplicationEvent>.broadcast(sync: false);

  void subscribeApplicationChanges(ApplicationEventCallBack callBack) {
    _applicationEventStream.stream.listen((ApplicationEvent event) => callBack(event));
  }

  void fireApplicationEvent(ApplicationEvent event) {
    _applicationEventStream.add(event);
  }
}

class ApplicationEventPassenger {
  ApplicationEventBus _applicationEventBus;

  void setApplicationEventBus(ApplicationEventBus value) {
    _applicationEventBus = value;
    _applicationEventBus.subscribeApplicationChanges(recieveApplicationEvent);
  }

  void fireApplicationEvent(ApplicationEvent event) {
    _applicationEventBus.fireApplicationEvent(event);
  }

  void recieveApplicationEvent(ApplicationEvent event) {}
}

class ApplicationEventCallBackHolder {
  ApplicationEventCallBack _applicationEventCallBack;

  ApplicationEventCallBack get applicationEventCallBack => _applicationEventCallBack;
  set applicationEventCallBack(ApplicationEventCallBack value) {
    _applicationEventCallBack = value;
  }
  void recieveApplicationEvent(ApplicationEvent event) {
    if (_applicationEventCallBack != null) {
      _applicationEventCallBack(event);
    }
  }
}

class ApplicationEventLogger extends Object with ApplicationEventPassenger {
  final Logger log = new Logger('ApplicationEventLogger');

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    log.info(event.toString());
  }
}
