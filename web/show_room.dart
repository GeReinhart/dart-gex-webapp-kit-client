// Copyright (c) 2014, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_common_ui_elements.show_room;


import 'dart:html';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/space.dart' ;
import 'package:gex_common_ui_elements/elements/button.dart' ;
import 'package:gex_common_ui_elements/elements/toolbar.dart' ;
import 'package:gex_common_ui_elements/elements/view_port.dart' ;
import 'package:gex_common_ui_elements/elements/application.dart' ;

import 'pages/home.dart';
import 'pages/bus.dart';
import 'pages/view_port.dart';
import 'pages/buttons.dart';

void main() {
  initPolymer().run(() {
    
    Polymer.onReady.then((_) {     
      ShowRoomApplication application = querySelector("#application")  as ShowRoomApplication;
      ApplicationEventBus applicationEventBus  = new ApplicationEventBus() ;
      PageKeyUrlConverter pageKeyUrlConverter = new PageKeyUrlConverter();
      ApplicationEventLogger applicationEventLogger = new ApplicationEventLogger();
      
      Router router = new Router(pageKeyUrlConverter);
      
      router.setApplicationEventBus(applicationEventBus) ;
      application.setApplicationEventBus(applicationEventBus);
      applicationEventLogger.setApplicationEventBus(applicationEventBus);
      
      router.init();
    });
    
    
  });
}

@CustomTag('show-room-app')
class ShowRoomApplication  extends Application{
  
  final Logger log = new Logger('ShowRoomApplication');
  
  Color mainColor = Color.GREEN_07CC00 ;
  
  ShowRoomApplication.created() : super.created(){
  } 
  
  @override
  void ready() {
    super.ready();
    _setAttributes();
  }
  
  void _setAttributes() {
    addPage( new Element.tag('page-home') ) ;
    addPage( new Element.tag('page-buttons') ) ;
    addPage( new Element.tag('page-bus') ) ;
    addPage( new Element.tag('page-view-port') ) ;
    
    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels.add( new ButtonModel(label: "Home", image:new Image(mainImageUrl:"images/button/back57.png"),type: ButtonType.PAGE_LAUNCHER , targetPageKey: new PageKey(name: PageHome.NAME)  )  );
    buttonModels.add( new ButtonModel(label: "Buttons", image:new Image(mainImageUrl:"images/button/click5.png"),type: ButtonType.PAGE_LAUNCHER , targetPageKey: new PageKey(name: PageButtons.NAME)  )  );
    ToolbarModel toolbarModel = new ToolbarModel(buttons:buttonModels, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT );
    addToolbar(toolbarModel);
    
    
    List<ButtonModel> bottomToolbar = new List<ButtonModel>();
    bottomToolbar.add( new ButtonModel(label: "Events", image:new Image(mainImageUrl:"images/button/tv21.png"),type: ButtonType.PAGE_LAUNCHER , targetPageKey: new PageKey(name: PageBus.NAME))  );
    bottomToolbar.add( new ButtonModel(label: "ViewPort", image:new Image(mainImageUrl:"images/button/vehicle12.png"),type: ButtonType.PAGE_LAUNCHER , targetPageKey: new PageKey(name: PageViewPort.NAME))  );
    ToolbarModel bottomToolbarModel = new ToolbarModel(buttons:bottomToolbar, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT );
    addToolbar(bottomToolbarModel);    
  }
  
}

