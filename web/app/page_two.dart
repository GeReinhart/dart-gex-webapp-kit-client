library gex_common_ui_elements.show_room_app.page_two;

import "dart:html";
import 'package:logging/logging.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:polymer/polymer.dart';

@CustomTag('gex-page-two')
class PageTwo extends Positionable with Showable  {
  
  final Logger log = new Logger('PageTwo');
  
  PageTwo.created() : super.created() ;
  
  
}