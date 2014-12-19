// Copyright (c) 2014, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/extensible_button.dart' ;

/// A Polymer `<main-app>` element.
@CustomTag('main-app')
class MainApp extends PolymerElement {
  
  final Logger log = new Logger('MainApp');

  ExtensibleButton menuButton ;
  ExtensibleButton searchButton ;
  ExtensibleButton registerAsDartisanButton ;
  ExtensibleButton registerAsCompagnyButton;
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
    registerAsCompagnyButton = $["registerAsCompagnyButton"] as ExtensibleButton ; 
    loginButton = $["loginButton"] as ExtensibleButton ; 
    
    menuButton.moveTo( new Position(0, 0, 150, 120, 101));
    searchButton.moveTo( new Position(150, 0, 150, 120, 101));
    registerAsDartisanButton.moveTo( new Position(300, 0, 150, 120, 101));
    registerAsCompagnyButton.moveTo( new Position(450, 0, 150, 120, 101));
    loginButton.moveTo( new Position(600, 0, 150, 120, 101));
  }
  
  void setUpEventsOnElements(){
 /*   SpanElement changeExtensibleButton = ( $["changeExtensibleButton"] as SpanElement );
    changeExtensibleButton.onClick.listen((_){
        ExtensibleButton searchButton = ( $["searchButton"] as ExtensibleButton );
        
        //searchButton.moveTo( new SquarePosition(1,2,3,4,5)  );
    }); */
  }
  
  void inputChanged(String oldValue, String newValue) {
    
    log.fine("MainApp inputChanged : ${oldValue} => ${newValue}");
  }

  // Optional lifecycle methods - uncomment if needed.

//  /// Called when an instance of main-app is inserted into the DOM.
//  attached() {
//    super.attached();
//  }

//  /// Called when an instance of main-app is removed from the DOM.
//  detached() {
//    super.detached();
//  }

//  /// Called when an attribute (such as a class) of an instance of
//  /// main-app is added, changed, or removed.
//  attributeChanged(String name, String oldValue, String newValue) {
//    super.attributeChanges(name, oldValue, newValue);
//  }

//  /// Called when main-app has been fully prepared (Shadow DOM created,
//  /// property observers set up, event listeners attached).
//  ready() {
//    super.ready();
//  }
}
