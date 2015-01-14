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

import 'show_room_button.dart' ;
import 'show_room_toolbar.dart' ;
import 'show_room_view_port.dart' ;
import 'show_room_layout.dart' ;
import 'app/show_room_application.dart' ;

@CustomTag('gex-show-room')
class ShowRoom extends PolymerElement {
  
  final Logger log = new Logger('ShowRoom');


  Space space ;
  ShowRoomButton showRoomButton ;
  ShowRoomToolbar showRoomToolbar ;
  ShowRoomViewPort showRoomViewPort ;
  ShowRoomLayout showRoomLayout ;
  ShowRoomApplication showRoomApplication;
  
  ViewPort showRoomLayoutViewPort ;
  Toolbar  showRoomLayoutToolbar ;
  
  Button buttonSpaceButton ;
  Button buttonSpaceToolbar ;
  Button buttonViewPort ;
  Button buttonLayout ;
  Button buttonApplication;
  
 
  
  ShowRoom.created() : super.created(){
   setUpLogger();
  }

  void setUpLogger(){
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec){
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });
  }
  
  ready() {
    super.ready();
    _setAttributes();
    _initialPositionsForElements();
  }
  
  void _setAttributes(){
    space = $["space"] as Space ;
    showRoomButton = $["showRoomButton"] as ShowRoomButton ;
    showRoomToolbar = $["showRoomToolbar"] as ShowRoomToolbar ; 
    showRoomViewPort = $["showRoomViewPort"] as ShowRoomViewPort ; 
    
    showRoomLayoutViewPort = $["showRoomLayoutViewPort"] as ViewPort ; 
    showRoomLayoutToolbar  = $["showRoomLayoutToolbar"] as Toolbar ; 
    
    List<ButtonModel> showRoomLayoutToolbarButtons = new List<ButtonModel>();
    showRoomLayoutToolbarButtons.add( new ButtonModel(label: "Reset",action:(p)=>addNewShowRoomLayout() )  );
    showRoomLayoutToolbarButtons.add( new ButtonModel(label: "Add buttons",action:(p)=>showRoomLayout.addButtons() )  );
    showRoomLayoutToolbarButtons.add( new ButtonModel(label: "Add content",action:(p)=>showRoomLayout.addContent() )  );
    ToolbarModel showRoomLayoutToolbarModel = new ToolbarModel(buttons:showRoomLayoutToolbarButtons,orientation: Orientation.est  );
    showRoomLayoutToolbar.init( showRoomLayoutToolbarModel) ;        
    
    showRoomApplication = $["showRoomApplication"] as ShowRoomApplication ; 
    
    buttonSpaceButton = $["buttonSpaceButton"] as Button ;
    buttonSpaceButton.init(new ButtonModel(color:Color.BLUE_0082C8, label: "Buttons", action: (p)=>_showPage(showRoomButton) ));
    buttonSpaceToolbar = $["buttonSpaceToolbar"] as Button ;
    buttonSpaceToolbar.init(new ButtonModel(color:Color.GREEN_07CC00, label: "Toolbars", action: (p)=>_showPage(showRoomToolbar) ));
    buttonViewPort = $["buttonViewPort"] as Button ;
    buttonViewPort.init(new ButtonModel(color:Color.BLUE_0082C8, label: "ViewPort", action: (p)=>_showPage(showRoomViewPort) ));    
    buttonLayout = $["buttonLayout"] as Button ;
    buttonLayout.init(new ButtonModel(color:Color.GREEN_07CC00, label: "Layout", action: (p){
      _showPage(showRoomLayoutViewPort);
      showRoomLayoutToolbar.show();
    } ));   
    buttonApplication = $["buttonApplication"] as Button ;
    buttonApplication.init(new ButtonModel(color:Color.BLUE_0082C8, label: "Application", action: (p)=>_showPage(showRoomApplication) ));
    
    showRoomViewPort.viewPort.subscribeViewPortChange(_viewPortChangeCallBack) ;
    
  }
  
  void _initialPositionsForElements(){
    space.moveTo( new Position(0, 0, window.innerWidth, window.innerHeight, 100));
    Position centerPosition = new Position(70, 70, window.innerWidth-140, window.innerHeight-140, 101);
    showRoomButton.moveTo(centerPosition);
    showRoomToolbar.moveTo(centerPosition);
    showRoomViewPort.moveTo(centerPosition);
    showRoomLayoutViewPort.moveTo(centerPosition);
    showRoomApplication.moveTo(centerPosition);
    
    buttonSpaceButton.moveTo( new Position(0, 0, 100, 30, 101));
    buttonSpaceToolbar.moveTo( new Position(100, 0, 100, 30, 101));
    buttonViewPort.moveTo( new Position(200, 0, 100, 30, 101));
    buttonLayout.moveTo( new Position(300, 0, 100, 30, 101));
    buttonApplication.moveTo( new Position(400, 0, 100, 30, 101));

    showRoomLayoutToolbar.moveTo( new Position(300, 30, 100, 30, 101));
    
    showRoomButton.show();
    showRoomToolbar.hide() ;
    showRoomViewPort.hide();
    showRoomLayoutViewPort.hide();
    showRoomLayoutToolbar.hide();
    showRoomApplication.hide();
    
    addNewShowRoomLayout();
  }

  
  void _showPage(Showable page){
    showRoomButton.hide();
    showRoomToolbar.hide() ;
    showRoomViewPort.hide();
    showRoomLayoutViewPort.hide();
    showRoomLayoutToolbar.hide();
    showRoomApplication.hide();
    page.show();
  }
  
  void addNewShowRoomLayout(){
    showRoomLayoutViewPort.children.clear();
    showRoomLayout = new Element.tag('gex-show-room-layout') as ShowRoomLayout;
    showRoomLayout.moveTo( new Position(0, 0, window.innerWidth -140,window.innerHeight-140, 100));
     
    showRoomLayoutViewPort.append(showRoomLayout);
  }
  
  void _viewPortChangeCallBack(ViewPortChangeEvent event){
    ViewPortModel viewPort = event.viewPortModel ;
    Position fullPosition = new Position(0, 0, viewPort.windowWidth, viewPort.windowHeight, 100);
    Position centerPosition = new Position(70, 70, viewPort.windowWidth -140,viewPort.windowHeight-140, 100);
    
    space.moveTo( fullPosition);
    showRoomButton.moveTo( centerPosition);
    showRoomToolbar.moveTo( centerPosition);
    showRoomViewPort.moveTo( centerPosition);
    showRoomLayoutViewPort.moveTo( centerPosition);
    showRoomLayout.moveTo( new Position(0, 0, viewPort.windowWidth -140,viewPort.windowHeight-140, 100));
    showRoomApplication.moveTo( centerPosition);
  }

}
