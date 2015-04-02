// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.formated_textarea;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/elements/button.dart';
import 'package:gex_webapp_kit_client/elements/formated_text.dart';
import 'package:paper_elements/paper_action_dialog.dart';

@CustomTag('gex-formated-textarea')
class FormatedTextArea extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('FormatedTextArea');

  
  @published String label ;
  @published String text ;
  @published num rows;
  
  FormatedTextArea.created() : super.created();
  
  @override
  void ready() {
    buttonPreview.init(new ButtonModel(
        color: Color.WHITE,
        image: new Image(mainImageUrl: "images/button/eye110.png"),
        label: "Preview",
        action: preview));
    buttonPreview.moveTo(new Position(20,0,25,25, 101));    
    buttonDoc.init(new ButtonModel(
        color: Color.WHITE,
        image: new Image(mainImageUrl: "images/button/info24.png"),
        label: "Documentation",
        action: doc));    
    buttonDoc.moveTo(new Position(60,0,25,25, 101));      
  }

  void _updateFormatedText(){
    ($["formatedText"]as FormatedText).text = textArea.value ;
    ($["docFormatedText"]as FormatedText).text = docTextArea.value ;
  }
  
  void preview(Parameters params) {
    if (!dialogPreview.opened) {
      _updateFormatedText();
      dialogPreview.toggle();
    }
  }
  void doc(Parameters params) {
    if (!dialogDoc.opened) {
      _updateFormatedText();
      dialogDoc.toggle();
    }    
  }  
  
  
  PaperActionDialog get dialogPreview => $["dialogPreview"] as PaperActionDialog;
  PaperActionDialog get dialogDoc => $["dialogDoc"] as PaperActionDialog;
  
  DivElement get main => $["main"] as DivElement;
  TextAreaElement get textArea => $["textArea"] as TextAreaElement;
  TextAreaElement get docTextArea => $["docTextArea"] as TextAreaElement;  
  Button get buttonPreview => $["buttonPreview"] as Button;
  Button get buttonDoc => $["buttonDoc"] as Button;
    
  
}
