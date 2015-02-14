// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of gex_webapp_kit_client;

typedef void ApplicationEventCallBack(ApplicationEvent event);

class ApplicationEvent {
  Object _sender;
  String _type = "ApplicationEvent";

  ApplicationEvent(Object sender) {
    assert(sender != null);
    _sender = sender;
  }

  Object get sender => _sender;
  String get type => _type;

  bool iAmTheSender(Object other) {
    return identical(this, other);
  }

  @override
  String toString() {
    return "ApplicationEvent: sender=${sender}";
  }
}

class PageCallEvent extends ApplicationEvent {
  String _pageName;
  Parameters _params;
  Parameters _resources;

  PageCallEvent({Object sender, String pageName, Parameters resources, Parameters params}) : super(sender) {
    _pageName = pageName;
    _resources = resources == null ? new Parameters(null) : resources;
    _params = params == null ? new Parameters(null) : params;
    _type = "PageCallEvent";
  }

  PageCallEvent.fromPageKey(Object sender, PageKey pageKey) : super(sender) {
    _pageName = pageKey.name;
    _resources = pageKey.resources;
    _params = pageKey.params;
    _type = "PageCallEvent";
  }

  String get pageName => _pageName;
  Parameters get params => _params.clone();
  Parameters get resources => _resources.clone();

  @override
  String toString() {
    return "PageCallEvent: sender=${sender}, pageName=${_pageName}, resources=${_resources}, params=${_params}";
  }
}

class PageDisplayedEvent extends ApplicationEvent {
  String _pageName;
  Parameters _params;
  Parameters _resources;

  PageDisplayedEvent({Object sender, String pageName, Parameters resources, Parameters params}) : super(sender) {
    _pageName = pageName;
    _resources = resources == null ? new Parameters(null) : resources;
    _params = params == null ? new Parameters(null) : params;
    _type = "PageCallEvent";
  }

  PageDisplayedEvent.fromPageKey(Object sender, PageKey pageKey) : super(sender) {
    _pageName = pageKey.name;
    _resources = pageKey.resources;
    _params = pageKey.params;
    _type = "PageCallEvent";
  }

  String get pageName => _pageName;
  Parameters get params => _params.clone();
  Parameters get resources => _resources.clone();

  @override
  String toString() {
    return "PageCallEvent: sender=${sender}, pageName=${_pageName}, resources=${_resources}, params=${_params}";
  }
}

class PageBackEvent extends ApplicationEvent {
  PageBackEvent(Object sender) : super(sender) {
    _type = "PageBackEvent";
  }

  @override
  String toString() {
    return "PageBackEvent: sender=${sender}";
  }
}

class PageIndexCallEvent extends ApplicationEvent {
  PageIndexCallEvent(Object sender) : super(sender) {
    _type = "PageIndexCallEvent";
  }

  @override
  String toString() {
    return "PageIndexCallEvent: sender=${sender}";
  }
}

class ViewPortChangeEvent extends ApplicationEvent {
  ViewPortModel _viewPortModel;

  ViewPortChangeEvent(Object sender, this._viewPortModel) : super(sender) {
    _type = "ViewPortChangeEvent";
  }

  ViewPortModel get viewPortModel => _viewPortModel.clone();

  ViewPortChangeEvent clone() {
    return new ViewPortChangeEvent(this.sender, this.viewPortModel);
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
