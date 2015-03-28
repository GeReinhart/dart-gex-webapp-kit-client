// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.message;

import "dart:html";
import 'package:polymer/polymer.dart';

import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:gex_webapp_kit_client/elements/spinner.dart';
import 'package:paper_elements/paper_action_dialog.dart';

@CustomTag('gex-dialog-message')
class DialogMessage extends PolymerElement  {

  @observable  String message = "";

  DialogMessage.created() : super.created();

  void show( {String message}  ){
    this.message = message;
    if (!dialog.opened) {
      dialog.toggle();
    }
  }
  
  PaperActionDialog get dialog => $["dialog"] as PaperActionDialog;
}
