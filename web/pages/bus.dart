library gex_common_ui_elements.show_room.bus;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/layout.dart' ;
import 'package:gex_common_ui_elements/elements/page.dart' ;


@CustomTag('page-bus')
class PageBus extends Page with Showable {
  
  static final String NAME = "bus" ;
  final Logger log = new Logger(NAME);
  
  Color mainColor = Color.BLUE_0082C8 ;
  
  Layout layout ;
  
  PageBus.created() : super.created() ;
  
  
  ready() {
    super.ready();
    _setAttributes();
  }
  
  void _setAttributes(){
     layout = $["layout"] as Layout ;
     LayoutModel layoutModel = new LayoutModel(color: mainColor);
     PageModel model = new PageModel(name:NAME, layoutModel:layoutModel);
     this.init(model) ;
  }
  

}