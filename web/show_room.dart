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
import 'show_room_button.dart' ;
import 'show_room_toolbar.dart' ;

@CustomTag('gex-show-room')
class ShowRoom extends PolymerElement {
  
  final Logger log = new Logger('ShowRoom');


  Space space ;
  ShowRoomButton showRoomButton ;
  ShowRoomToolbar showRoomToolbar ;
  
  Button buttonSpaceButton ;
  Button buttonSpaceToolbar ;
  
 
  
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
    
    buttonSpaceButton = $["buttonSpaceButton"] as Button ;
    buttonSpaceToolbar = $["buttonSpaceToolbar"] as Button ;
    
  }
  
  void _initialPositionsForElements(){
    space.moveTo( new Position(0, 0, window.innerWidth, window.innerHeight, 100));
    showRoomButton.moveTo( new Position(70, 70, window.innerWidth-70, window.innerHeight-70, 101));
    showRoomToolbar.moveTo( new Position(70, 70, window.innerWidth-70, window.innerHeight-70, 101));
    buttonSpaceButton.moveTo( new Position(0, 0, 100, 30, 101));
    buttonSpaceToolbar.moveTo( new Position(100, 0, 100, 30, 101));
    showRoomButton.show();
    showRoomToolbar.hide() ;
  }

  
  void _setUpEventsOnElements(){
    buttonSpaceButton.targetAction( new ActionDescriptor("","",(Parameters params){
      showRoomButton.show();
      showRoomToolbar.hide() ;
    }) );
    buttonSpaceToolbar.targetAction( new ActionDescriptor("","",(Parameters params){
      showRoomToolbar.show() ;
      showRoomButton.hide();
    }) );
  }



}
