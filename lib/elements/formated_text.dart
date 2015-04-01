// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.formated_text;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:polymer/polymer.dart';
import 'package:markdown/markdown.dart';

@CustomTag('gex-formated-text')
class FormatedText extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('FormatedText');

  NodeValidator nodeValidator ;
  
  FormatedText.created() : super.created();

  @override
  void ready(){
    nodeValidator=  new NodeValidatorBuilder()
                         ..allowCustomElement("p" )
                         ..allowCustomElement("a", attributes :["href"])
                         ..allowCustomElement("ol" )
                         ..allowCustomElement("ul" )
                         ..allowCustomElement("li" )
                         ..allowCustomElement("strong" )
                         ..allowCustomElement("em" )                         
                         ;
  }
  
  set text(String text){
    main.children.clear();
    main.setInnerHtml(   markdownToHtml( text ) ,validator:nodeValidator ) ;
    
  }

  DivElement get main => $["main"] as DivElement;
}
