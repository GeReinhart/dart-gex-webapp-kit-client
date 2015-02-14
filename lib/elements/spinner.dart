// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.spinner;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:polymer/polymer.dart';

@CustomTag('gex-spinner')
class Spinner extends Positionable with Showable {
  final Logger log = new Logger('ViewPort');

  
  @observable
  num mainSize ;
  
  @observable
  num wBallSize ;
  
  @observable
  num wInnerBallSize ;

  Spinner.created() : super.created(){
    size = 100;
  }
  
  
  set size(num value){
    mainSize=value;
    wBallSize=value * 86/90;
    wInnerBallSize=value * 11/90;
  }     

}
