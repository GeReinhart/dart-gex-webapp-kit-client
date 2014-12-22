// Copyright (c) 2014, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/space.dart' ;
import 'package:gex_common_ui_elements/elements/button.dart' ;
import 'package:gex_common_ui_elements/elements/toolbar.dart' ;

/// A Polymer `<main-app>` element.
@CustomTag('main-app')
class MainApp extends PolymerElement {
  
  final Logger log = new Logger('MainApp');

  Space space ;
  Space toolbarSpace ;
  Space buttonSpace ;
  
  Button buttonSpaceButton ;
  Button buttonSpaceToolbar ;
  
  Button button1 ;
  Button button2 ;
  Button button3 ;
  Button button4;
  
  Toolbar estToolbar;
  Toolbar southToolbar;
  
  MainApp.created() : super.created(){
   setUpLogger();
   setUpEventsOnElements();
  }

  void setUpLogger(){
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec){
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });
  }
  
  ready() {
    super.ready();
    space = $["space"] as Space ;
    toolbarSpace = $["toolbarSpace"] as Space ;
    buttonSpace = $["buttonSpace"] as Space ;
    
    buttonSpaceButton = $["buttonSpaceButton"] as Button ;
    buttonSpaceToolbar = $["buttonSpaceToolbar"] as Button ;
    
    button1 = $["button1"] as Button ;
    button2 = $["button2"] as Button ;
    button3 = $["button3"] as Button ;
    button4 = $["button4"] as Button ; 

    estToolbar = $["estToolbar"] as Toolbar ;
    southToolbar = $["southToolbar"] as Toolbar ;
    
    space.moveTo( new Position(0, 0, window.innerWidth, window.innerHeight, 100));
    toolbarSpace.moveTo( new Position(70, 70, window.innerWidth-70, window.innerHeight-70, 101));
    buttonSpace.moveTo( new Position(70, 70, window.innerWidth-70, window.innerHeight-70, 101));
    
    buttonSpaceButton.moveTo( new Position(0, 0, 100, 30, 101));
    buttonSpaceToolbar.moveTo( new Position(100, 0, 100, 30, 101));
    
    button1.moveTo( new Position(0, 100, 150, 120, 101));
    button2.moveTo( new Position(150, 100, 150, 120, 101));
    button3.moveTo( new Position(300, 100, 150, 120, 101));
    button4.moveTo( new Position(600, 100, 150, 120, 101));
    
    
    List<ActionDescriptor> actions = new List<ActionDescriptor>();
    actions.add(new ActionDescriptor("Action 1","",action1));
    actions.add(new ActionDescriptor("Action 2","",action2));
    actions.add(new ActionDescriptor("Action 3","",action3));
    actions.add(new ActionDescriptor("Action 4","",action4));
    estToolbar.init(new Position(0, 0, 100, 100, 102), Orientation.est,actions ) ;
    
    setUpEventsOnElements();
    cloneAndMoveButtons();
    showButtonSpace(null);
  }
  
  void cloneAndMoveButtons() {
    cloneAndMove(button1,new Position(0, 300, 150, 120, 102),action1);
    cloneAndMove(button2,new Position(150, 300, 150, 120, 102),action2);
    cloneAndMove(button3,new Position(300, 300, 150, 120, 102),action3);
    cloneAndMove(button4,new Position(600, 300, 150, 120, 102),action4);
    
    cloneAndMove(button1,new Position(0, 500, 50, 50, 102),action1);
    cloneAndMove(button2,new Position(150, 500, 50, 50, 102),action2);
    cloneAndMove(button3,new Position(500, 300, 50, 50, 102),action3);
    cloneAndMove(button4,new Position(600, 500, 50, 50, 102),action4);
  }
  
  void cloneAndMove(Button button,Position position, LaunchAction action){
    buttonSpace.append(button.cloneAndMove(position));
  }
  
  void setUpEventsOnElements(){
    buttonSpaceButton.targetAction( new ActionDescriptor("","",showButtonSpace) );
    buttonSpaceToolbar.targetAction( new ActionDescriptor("","",showToolbarSpace ) );
    
    button1.targetAction( new ActionDescriptor("","",action1) );
    button2.targetAction( new ActionDescriptor("","",action2 ) );
    button3.targetAction( new ActionDescriptor("","",action3 ) );
    button4.targetAction( new ActionDescriptor("","",action4 ) );
  }

  action1(Parameters params){
    buttonSpace.style.backgroundColor ="white" ;
    toolbarSpace.style.backgroundColor ="#00D2B8" ;
  }
  action2(Parameters params){
    buttonSpace.style.backgroundColor ="#00D2B8" ;
    toolbarSpace.style.backgroundColor ="#778899" ;
  }
  action3(Parameters params){
    buttonSpace.style.backgroundColor ="#778899" ;
    toolbarSpace.style.backgroundColor ="#FFFFE0" ;
  }
  action4(Parameters params){
    buttonSpace.style.backgroundColor ="#FFFFE0" ;
    toolbarSpace.style.backgroundColor ="white" ;
  }
  showToolbarSpace(Parameters params){
    toolbarSpace.show() ;
    buttonSpace.hide() ;
  }
  showButtonSpace(Parameters params){
    buttonSpace.show() ;
    toolbarSpace.hide() ;
  }
}
