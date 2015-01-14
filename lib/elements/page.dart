library gex_common_ui_elements.layout;

import "dart:html";
import 'package:logging/logging.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:gex_common_ui_elements/elements/layout.dart';
import 'package:polymer/polymer.dart';

@CustomTag('gex-page')
class Page extends Positionable with Showable {
  
  final Logger log = new Logger('Page');
  
  Layout _layout ;
  
  Page.created() : super.created() ;
  
  @override
  void ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes(){
    _layout = $["layout"] as Layout ;
  }
  
  void init(HtmlElement content, LayoutModel model)  {
    _layout.init(model);
    _layout.children.clear() ;
    _layout.children.add(content);
  }
  
  @override
  void moveTo(Position position) {
      super.moveTo(position);
      _layout.moveTo(position);
  }
  
}
