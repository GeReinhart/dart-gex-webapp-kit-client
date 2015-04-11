// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.application;

import "dart:html" hide ScreenOrientation;
import 'package:polymer/polymer.dart';
import 'package:logging/logging.dart';
import 'package:gex_webapp_kit/webapp_kit_client.dart';
import 'package:gex_webapp_kit/webapp_kit_common.dart';

import 'package:gex_webapp_kit/client/elements/toolbar.dart';
import 'package:gex_webapp_kit/client/elements/view_port.dart';
import 'package:gex_webapp_kit/client/elements/page.dart';
import 'package:gex_webapp_kit/client/elements/loading_space.dart';
import 'package:gex_webapp_kit/client/elements/dialog_message.dart';

/**
 * Listen to the screen/window changes and broadcast ViewPort change events.
 */
@CustomTag('gex-application')
class Application extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('Application');

  ViewPort _viewPort;
  Element _toolbarsContainer;
  List<Toolbar> _toolbars = new List<Toolbar>();
  Element _pagesContainer;
  List<Page> _pages = new List<Page>();
  Margin _margin = new Margin();
  Page _currentPage;
  DialogMessage _warningAuthentication ;
  DialogMessage _dialogMessage ;
  
  LoadingSpace _loadingSpace;

  bool _fitWithWindow = true;

  Application.created() : super.created();

  List<Page> get pages => _pages;

  @override
  void ready() {
    super.ready();
    this.style.overflow = "hidden";
    _setAttributes();
  }

  void init() {
    _viewPort.init();
  }

  void _setAttributes() {
    _loadingSpace = $["loadingSpace"] as LoadingSpace;
    _viewPort = $["viewPort"] as ViewPort;
    _toolbarsContainer = $["toolBars"];
    _pagesContainer = $["pages"];
    _warningAuthentication =  $["warningAuthentication"];
    _dialogMessage =  $["message"];
  }

  ViewPortModel get viewPortModel => _viewPort.model;
  List<ToolbarModel> get toolbarModels {
    List<ToolbarModel> toolbars = new List<ToolbarModel>();
    _toolbars.forEach((t) => toolbars.add(t.model));
    return toolbars;
  }

  PageModel get currentPageModel => _currentPage == null ? null : _currentPage.model;

  set fitWithWindow(bool value) {
    _fitWithWindow = value;
  }

  void showLoadingMessage(String message) {
    _loadingSpace.showLoadingSpace(message);
  }

  void hideLoadingMessage() {
    _loadingSpace.hide();
  }

  @override
  void setApplicationEventBus(ApplicationEventBus value) {
    super.setApplicationEventBus(value);
    _viewPort.setApplicationEventBus(value);
    _toolbars.forEach((t) => t.setApplicationEventBus(value));
    _pages.forEach((p) => p.setApplicationEventBus(value));

    if (_fitWithWindow) {
      moveTo(new Position(0, 0, _viewPort.model.windowWidth, _viewPort.model.windowHeight, 100));
    }
  }

  @override
  void moveTo(Position position) {
    super.moveTo(position);
    Position subElementPosition = position.clone();
    subElementPosition.left = 0;
    subElementPosition.top = 0;

    _moveToolBars(subElementPosition, position.orientation);
    _movePages(subElementPosition);
    _loadingSpace
        .moveTo(new Position(position.left, position.top, position.width, position.height, position.zIndex + 10));
  }

  @override
  void show() {
    super.show();
    _pages.forEach((p) => p.hideOrShowPutToInitialState());
  }

  @override
  void hide() {
    super.hide();
    _pages.forEach((p) => p.hideBeforePutBackInitialState());
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    if (event.isCallIndexPage) {
      // TODO Find another way to define the index page
      String pageIndexName = _pages.first.name;
      showPage(pageName: pageIndexName);
      fireApplicationEvent(new ApplicationEvent.callPage(this, pageIndexName));
      return;
    }
    if (event.isCallPage) {
      showPage(pageName: event.pageKey.name, resources: event.pageKey.resources, params: event.pageKey.params);
      fireApplicationEvent(new ApplicationEvent.pageDisplayed(this, event.pageKey.name, params: event.pageKey.params));
      return;
    }
    if (event.isViewPortChange && _fitWithWindow) {
      moveTo(new Position(0, 0, event.viewPort.windowWidth, event.viewPort.windowHeight, 100));
    }
    if (event.isCallDialog) {
      _dialogMessage.show(message:event.message);
    }
    if (event.isCallUserAuth) {
      showLoadingMessage("Login process on going...");
    }
    if (event.isUserAuthFail || event.isloginFailure|| event.isLoginSuccess || event.isCallRegisterPage) {
      hideLoadingMessage();
    }
    if(event.isUserAuthFail){
      _warningAuthentication.show();
    }    
    if(event.isloginFailure){
      toastMessage(event.errorDetails);
    }
    if (event.isCallRegisterPage) {
      // TODO Find a way to define the register page
      showPage(pageName: "register");
      fireApplicationEvent(new ApplicationEvent.callPage(this, "register"));
    }
    if (event.isLoginSuccess || event.isLogoutSuccess || event.isRegisterSuccess) {
      fireApplicationEvent(new ApplicationEvent.callIndexPage(this));
    }
  }

  void showPage({String pageName, Parameters resources, Parameters params}) {
    _pages.forEach((p) => p.hide());
    if (pageName != null) {
      _pages.forEach((p) {
        if (p.name == pageName) {
          p.showPage(resources:resources, params:params);
          _currentPage = p;
        }
      });
    }
  }

  void addToolbar(ToolbarModel model) {
    assert(_toolbars.length < 4);
    Toolbar toolbar = new Element.tag('gex-toolbar') as Toolbar;
    toolbar.init(model);
    _toolbars.add(toolbar);
    _toolbarsContainer.append(toolbar);
    _moveToolBars(position, position.orientation);
  }

  void _moveToolBars(Position position, ScreenOrientation screenOrientation) {
    num pagePercentage = viewPortModel.isTouchDevice ? 0.20 : 0.12;
    num size = position.width > position.height ? position.height * pagePercentage : position.width * pagePercentage;
    num zIndex = position.zIndex + 1;

    for (int i = 0; i < _toolbars.length; i++) {
      Toolbar toolbar = _toolbars[i];

      switch (i) {
        case 0:
          toolbar.orientation = screenOrientation == ScreenOrientation.LANDSCAPE ? Orientation.south : Orientation.est;
          toolbar.moveTo(new Position(0, 0, size, size, zIndex));
          break;
        case 1:
          toolbar.orientation = screenOrientation == ScreenOrientation.LANDSCAPE ? Orientation.north : Orientation.west;
          toolbar.moveTo(new Position(position.width - size, position.height - size, size, size, zIndex));
          break;
        case 2:
          toolbar.orientation = screenOrientation == ScreenOrientation.LANDSCAPE ? Orientation.west : Orientation.south;
          toolbar.moveTo(new Position(position.width - size, 0, size, size, zIndex));
          break;
        case 3:
          toolbar.orientation = screenOrientation == ScreenOrientation.LANDSCAPE ? Orientation.est : Orientation.north;
          toolbar.moveTo(new Position(0, position.height - size, size, size, zIndex));
          break;
      }
    }

    _margin = new Margin();
    num marginSize = size * 1.2;
    switch (_toolbars.length - 1) {
      case 0:
        if (screenOrientation == ScreenOrientation.LANDSCAPE) {
          _margin = _margin.merge(leftInPx: marginSize);
        } else {
          _margin = _margin.merge(topInPx: marginSize);
        }
        break;
      case 1:
        if (screenOrientation == ScreenOrientation.LANDSCAPE) {
          _margin = _margin.merge(leftInPx: marginSize, rightInPx: marginSize);
        } else {
          _margin = _margin.merge(topInPx: marginSize, bottomInPx: marginSize);
        }
        break;
      case 2:
        if (screenOrientation == ScreenOrientation.LANDSCAPE) {
          _margin = _margin.merge(leftInPx: marginSize, rightInPx: marginSize, topInPx: marginSize);
        } else {
          _margin = _margin.merge(topInPx: marginSize, bottomInPx: marginSize, rightInPx: marginSize);
        }
        break;
      case 3:
        if (screenOrientation == ScreenOrientation.LANDSCAPE) {
          _margin =
              _margin.merge(leftInPx: marginSize, rightInPx: marginSize, topInPx: marginSize, bottomInPx: marginSize);
        } else {
          _margin =
              _margin.merge(topInPx: marginSize, bottomInPx: marginSize, rightInPx: marginSize, leftInPx: marginSize);
        }
        break;
    }
  }

  void addPage(Page page) {
    _pagesContainer.append(page);
    _pages.add(page);
    page.application = this;
    page.hide();
    page.moveTo(position);
  }

  void _movePages(Position position) {
    for (Page page in _pages) {
      page.margin = _margin;
      page.moveTo(position);
    }
  }
  
  void toastMessage(String message, {Color color}) {
    _currentPage.toastMessage(message, color: color) ;
  }
}
