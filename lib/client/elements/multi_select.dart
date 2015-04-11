// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.multi_select;

import "dart:html";
import 'package:gex_webapp_kit/webapp_kit_client.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit/webapp_kit_common.dart';
import 'package:gex_webapp_kit/client/elements/button.dart';


class MultiSelectModel{
  Set<num> selectedElements = new Set<num>();
  List<String> labels ;
  Color color = Color.BLUE_0082C8;
  num buttonSize = 25 ;
  
  MultiSelectModel(this.selectedElements, this.labels);
  
}


@CustomTag('gex-multi-select')
class MultiSelect extends Positionable with Showable {
  
  MultiSelectModel model;
  @observable String desc;
  List<Button>  _buttons = new List<Button>(); 
  bool _horizontal = true;
  
  MultiSelect.created() : super.created();

  void init(MultiSelectModel model) {
    this.model = model;
    if (model.selectedElements == null){
      model.selectedElements = new Set<num>();
    }


    buttonsContainer.style
      ..height = "${model.buttonSize}px"
      ..width = "${model.buttonSize*3}px";
    descElement.style
      ..left = "${model.buttonSize*3 + 10}px"
      ..top = "${model.buttonSize +10}px"
      ..width = "${model.buttonSize*20}px";

    buttonsContainer.children.clear();
    _buttons.clear();
      

    Iterator<String> i = model.labels.iterator ;  
    num index = 0;
    while(i.moveNext()){
      Button currentButton = new Element.tag('gex-button');
      buttonsContainer.append(currentButton);
      _buttons.add(currentButton);
      final String indexAsString = index.toString();
      currentButton.init(new ButtonModel( label: _labelForElement(index),  color: model.color,  action: (p) => _buttonSelectEvent(new Parameters.withOneParam("id", indexAsString))));
      currentButton.moveTo(new Position(index * model.buttonSize * 5 , 0, model.buttonSize * 5, model.buttonSize, 100));
      index++;
    }
    _buttons[0].status = ButtonStatus.HIGHLIGHTED;
  }
  
  bool get isHorizontal => _horizontal;
  
  void horizontal(){
    _horizontal= true;
    Iterator<Button> i = _buttons.iterator ;  
    num index = 0;
    while(i.moveNext()){
      Button currentButton = i.current;
      currentButton.moveTo(new Position(index * model.buttonSize * 5 , 0, model.buttonSize * 5, model.buttonSize, 100));
      index++;
    }

    buttonsContainer.style
      ..height = "${model.buttonSize}px"
      ..width = "${model.buttonSize*3}px";
    
    descElement.style
          ..left = "${model.buttonSize*3 + 10}px"
          ..top = "${model.buttonSize +10}px"
          ..width = "${model.buttonSize*20}px";
  }
  
  void vertical(){
    _horizontal = false;
    Iterator<Button> i = _buttons.iterator ;  
    num index = 0;
    while(i.moveNext()){
      Button currentButton = i.current;
      currentButton.moveTo(new Position(0, index * model.buttonSize  ,  model.buttonSize * 5, model.buttonSize, 100));
      index++;
    }
    buttonsContainerRelative.style
      ..height = "${model.buttonSize*index +30}px"
      ..width = "${model.buttonSize*6}px";

    buttonsContainer.style
      ..height = "${model.buttonSize}px"
      ..width = "${model.buttonSize*6}px";
    
    descElement.style
          ..left = "${ 0}px"
          ..top = "${0}px"
          ..height = "${0}px"
          ..width = "${0}px";
  }  
  
  void _buttonSelectEvent(Parameters params){
    num buttonIndex = num.parse( params.valueFor("id")) ;
    
    if (buttonIndex == 0){
      
      if (! model.selectedElements.isEmpty){
        _buttons.forEach((b)=> b.status = ButtonStatus.NORMAL) ;
        model.selectedElements.clear();
      }
      _buttons[0].status = ButtonStatus.HIGHLIGHTED;
      
      
    }else{
        if ( model.selectedElements.contains(buttonIndex)  ){
          _buttons[buttonIndex].status = ButtonStatus.NORMAL;
          model.selectedElements.remove(buttonIndex);
          if (model.selectedElements.isEmpty){
            _buttons[0].status = ButtonStatus.HIGHLIGHTED;
          }
          
        }else{
          _buttons[buttonIndex].status = ButtonStatus.HIGHLIGHTED;
          model.selectedElements.add(buttonIndex);
          if (!model.selectedElements.isEmpty){
            _buttons[0].status = ButtonStatus.NORMAL;
          }          
        }
    }
    
    _updateDesc();
    
  }
  
  void _updateDesc(){
    
    String descTemp ; 
    if (model.selectedElements.isEmpty || model.selectedElements.length == 5){
      descTemp = "Whatever";
    }else{
      Iterator<num> i = model.selectedElements.toList(growable: true).iterator;
      i.moveNext();
      descTemp = _labelForElement(i.current) ;
      while(i.moveNext()){
        descTemp += ", ${_labelForElement(i.current)}" ;
      }
    }
    desc = descTemp;
  }
  
  
  Set<num> get selectedElements => model.selectedElements ;
  
  String _labelForElement(num i){
    if (i >=0 && i< model.labels.length){
      return model.labels[i];
    }
    return  "";
  }
  

  HtmlElement get descElement => $["desc"];
  HtmlElement get buttonsContainer => $["buttonsContainer"];
  HtmlElement get buttonsContainerRelative => $["buttonsContainerRelative"];
}
