part of gex_common_ui_elements;

typedef void ApplicationEventCallBack(ApplicationEvent event);

class ApplicationEvent {
  Object _sender;
  String _type = "ApplicationEvent";
  String _name;
  Parameters _params;
  Parameters _resources;

  ApplicationEvent({Object sender, String name, Parameters resources, Parameters params}) {
    assert(sender != null);
    assert(name != null);

    _sender = sender;
    _name = name;
    if (params == null) {
      _params = new Parameters(null);
    } else {
      _params = params;
    }
    if (resources == null) {
      _resources = new Parameters(null);
    } else {
      _resources = resources;
    }
  }

  Object get sender => _sender;
  String get name => _name;
  String get type => _type;
  Parameters get params => _params.clone();
  Parameters get resources => _resources.clone();

  bool iAmTheSender(Object other) {
    return identical(this, other);
  }

  @override
  String toString() {
    return "ApplicationEvent: sender=${sender}, name=${name}, resources=${_resources}, params=${_params}";
  }
}

class PageCallEvent extends ApplicationEvent {
  PageCallEvent({Object sender, String pageName, Parameters resources, Parameters params})
      : super(sender: sender, name: pageName, resources: resources, params: params) {
    _type = "PageCallEvent";
  }

  PageCallEvent.fromPageKey(Object sender, PageKey pageKey)
      : super(sender: sender, name: pageKey.name, resources: pageKey.resources, params: pageKey.params) {
    _type = "PageCallEvent";
  }

  @override
  String toString() {
    return "PageCallEvent: sender=${sender}, name=${name}, resources=${_resources}, params=${_params}";
  }
}

class PageDisplayedEvent extends ApplicationEvent {
  PageDisplayedEvent({Object sender, String pageName, Parameters resources, Parameters params})
      : super(sender: sender, name: pageName, resources: resources, params: params) {
    _type = "PageDisplayedEvent";
  }

  PageDisplayedEvent.fromPageKey(Object sender, PageKey pageKey)
      : super(sender: sender, name: pageKey.name, resources: pageKey.resources, params: pageKey.params) {
    _type = "PageDisplayedEvent";
  }

  @override
  String toString() {
    return "PageDisplayedEvent: sender=${sender}, name=${name}, resources=${_resources}, params=${_params}";
  }
}

class PageBackEvent extends ApplicationEvent {
  PageBackEvent({Object sender}) : super(sender: sender, name: "PageBackEvent") {
    _type = "PageBackEvent";
  }

  @override
  String toString() {
    return "PageBackEvent: sender=${sender}, name=${name}, resources=${_resources}, params=${_params}";
  }
}

class PageIndexCallEvent extends ApplicationEvent {
  PageIndexCallEvent({Object sender}) : super(sender: sender, name: "PageIndexCallEvent") {
    _type = "PageIndexCallEvent";
  }

  @override
  String toString() {
    return "PageIndexCallEvent: sender=${sender}, name=${name}, resources=${_resources}, params=${_params}";
  }
}

class ViewPortChangeEvent extends ApplicationEvent {
  ViewPortModel _viewPortModel;

  ViewPortChangeEvent(Object sender, this._viewPortModel) : super(sender: sender, name: "ViewPortChangeEvent") {
    _type = "ViewPortChangeEvent";
  }

  ViewPortModel get viewPortModel => _viewPortModel.clone();

  ViewPortChangeEvent clone() {
    return new ViewPortChangeEvent(this.sender, this._viewPortModel.clone());
  }

  @override
  String toString() {
    return "ViewPortChangeEvent: ${_viewPortModel}";
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
