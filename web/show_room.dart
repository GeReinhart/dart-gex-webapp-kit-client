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

@CustomTag('gex-show-room')
class ShowRoom extends PolymerElement {
  
  final Logger log = new Logger('ShowRoom');


  Space space ;
  ShowRoomButton showRoomButton ;
  ShowRoomToolbar showRoomToolbar ;
  ShowRoomViewPort showRoomViewPort ;
  
  Button buttonSpaceButton ;
  Button buttonSpaceToolbar ;
  Button buttonViewPort ;
  
 
  
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
    _setUpEventsOnElements();
  }
  
  void _setAttributes(){
    space = $["space"] as Space ;
    showRoomButton = $["showRoomButton"] as ShowRoomButton ;
    showRoomToolbar = $["showRoomToolbar"] as ShowRoomToolbar ; 
    showRoomViewPort = $["showRoomViewPort"] as ShowRoomViewPort ; 
    
    buttonSpaceButton = $["buttonSpaceButton"] as Button ;
    buttonSpaceToolbar = $["buttonSpaceToolbar"] as Button ;
    buttonViewPort = $["buttonViewPort"] as Button ;
    
  }
  
  void _initialPositionsForElements(){
    space.moveTo( new Position(0, 0, window.innerWidth, window.innerHeight, 100));
    showRoomButton.moveTo( new Position(70, 70, window.innerWidth-140, window.innerHeight-140, 101));
    showRoomToolbar.moveTo( new Position(70, 70, window.innerWidth-140, window.innerHeight-140, 101));
    showRoomViewPort.moveTo( new Position(70, 70, window.innerWidth-140, window.innerHeight-140, 101));
    buttonSpaceButton.moveTo( new Position(0, 0, 100, 30, 101));
    buttonSpaceToolbar.moveTo( new Position(100, 0, 100, 30, 101));
    buttonViewPort.moveTo( new Position(200, 0, 100, 30, 101));
    showRoomButton.hide();
    showRoomToolbar.show() ;
    showRoomViewPort.hide();
  }

  
  void _setUpEventsOnElements(){
    buttonSpaceButton.targetAction( new ActionDescriptor("","",(Parameters params){
      showRoomButton.show();
      showRoomToolbar.hide() ;
      showRoomViewPort.hide();
    }) );
    buttonSpaceToolbar.targetAction( new ActionDescriptor("","",(Parameters params){
      showRoomToolbar.show() ;
      showRoomButton.hide();
      showRoomViewPort.hide();
    }) );
    buttonViewPort.targetAction( new ActionDescriptor("","",(Parameters params){
      showRoomToolbar.hide() ;
      showRoomButton.hide();
      showRoomViewPort.show();      
    }) );
    
    showRoomViewPort.viewPort.subscribeViewPortChange(_viewPortChangeCallBack) ;
    
  }

  void _viewPortChangeCallBack(ViewPortChangeEvent event){
    ViewPortDescriptor viewPort = event.viewPortDescriptor ;
    
    space.moveTo( new Position(0, 0, viewPort.windowWidth, viewPort.windowHeigth, 100));
    showRoomButton.moveTo( new Position(70, 70, viewPort.windowWidth -140,viewPort.windowHeigth-140, 101));
    showRoomToolbar.moveTo( new Position(70, 70, viewPort.windowWidth -140, viewPort.windowHeigth-140, 101));
    showRoomViewPort.moveTo( new Position(70, 70, viewPort.windowWidth -140, viewPort.windowHeigth-140, 101));
    
  }

}
