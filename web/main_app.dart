// Copyright (c) 2014, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/absolute_space.dart' ;
import 'package:gex_common_ui_elements/elements/extensible_button.dart' ;

/// A Polymer `<main-app>` element.
@CustomTag('main-app')
class MainApp extends PolymerElement {
  
  final Logger log = new Logger('MainApp');

  AbsoluteSpace space ;
  ExtensibleButton menuButton ;
  ExtensibleButton searchButton ;
  ExtensibleButton registerAsDartisanButton ;
  ExtensibleButton loginButton;
  
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
    menuButton = $["menuButton"] as ExtensibleButton ;
    searchButton = $["searchButton"] as ExtensibleButton ;
    registerAsDartisanButton = $["registerAsDartisanButton"] as ExtensibleButton ;
    loginButton = $["loginButton"] as ExtensibleButton ; 
    space = $["space"] as AbsoluteSpace ;
    
    menuButton.moveTo( new Position(0, 0, 150, 120, 101));
    searchButton.moveTo( new Position(150, 0, 150, 120, 101));
    registerAsDartisanButton.moveTo( new Position(300, 0, 150, 120, 101));
    loginButton.moveTo( new Position(600, 0, 150, 120, 101));
    
    setUpEventsOnElements();
  }
  
  void setUpEventsOnElements(){
    menuButton.targetAction( new ActionDescriptor()..launchAction =  menu );
    searchButton.targetAction( new ActionDescriptor()..launchAction =  search );
    registerAsDartisanButton.targetAction( new ActionDescriptor()..launchAction =  register );
    loginButton.targetAction( new ActionDescriptor()..launchAction =  login );
  }

  menu(Parameters params){
    space.style.backgroundColor ="white" ;
  }
  search(Parameters params){
    space.style.backgroundColor ="red" ;
  }
  register(Parameters params){
    space.style.backgroundColor ="blue" ;
  }
  login(Parameters params){
    space.style.backgroundColor ="yellow" ;
  }
  
}
