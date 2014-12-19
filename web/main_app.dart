// Copyright (c) 2014, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/space.dart' ;
import 'package:gex_common_ui_elements/elements/button.dart' ;

/// A Polymer `<main-app>` element.
@CustomTag('main-app')
class MainApp extends PolymerElement {
  
  final Logger log = new Logger('MainApp');

  Space space ;
  Button menuButton ;
  Button searchButton ;
  Button registerAsDartisanButton ;
  Button loginButton;
  
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
    menuButton = $["menuButton"] as Button ;
    searchButton = $["searchButton"] as Button ;
    registerAsDartisanButton = $["registerAsDartisanButton"] as Button ;
    loginButton = $["loginButton"] as Button ; 
    space = $["space"] as Space ;
    
    menuButton.moveTo( new Position(0, 0, 150, 120, 101));
    searchButton.moveTo( new Position(150, 0, 150, 120, 101));
    registerAsDartisanButton.moveTo( new Position(300, 0, 150, 120, 101));
    loginButton.moveTo( new Position(600, 0, 150, 120, 101));
    
    setUpEventsOnElements();
    cloneAndMoveButtons();
  }
  
  void cloneAndMoveButtons() {
    cloneAndMove(menuButton,new Position(0, 300, 150, 120, 101),menu);
    cloneAndMove(searchButton,new Position(150, 300, 150, 120, 101),search);
    cloneAndMove(registerAsDartisanButton,new Position(300, 300, 150, 120, 101),register);
    cloneAndMove(loginButton,new Position(600, 300, 150, 120, 101),login);
    
    cloneAndMove(menuButton,new Position(0, 500, 50, 50, 101),menu);
    cloneAndMove(searchButton,new Position(150, 500, 50, 50, 101),search);
    cloneAndMove(registerAsDartisanButton,new Position(500, 300, 50, 50, 101),register);
    cloneAndMove(loginButton,new Position(600, 500, 50, 50, 101),login);
    
  }
  
  void cloneAndMove(Button button,Position position, LaunchAction action){
    space.append(button.cloneAndMove(position));
  }
  
  void setUpEventsOnElements(){
    menuButton.targetAction( new ActionDescriptor("","",menu) );
    searchButton.targetAction( new ActionDescriptor("","",search ) );
    registerAsDartisanButton.targetAction( new ActionDescriptor("","",register ) );
    loginButton.targetAction( new ActionDescriptor("","",login ) );
  }

  menu(Parameters params){
    space.style.backgroundColor ="white" ;
  }
  search(Parameters params){
    space.style.backgroundColor ="#00D2B8" ;
  }
  register(Parameters params){
    space.style.backgroundColor ="#778899" ;
  }
  login(Parameters params){
    space.style.backgroundColor ="#FFFFE0" ;
  }
  
}
