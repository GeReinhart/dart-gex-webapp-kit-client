library gex_common_ui_elements.toolbar;

import "dart:html";
import 'package:logging/logging.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:gex_common_ui_elements/elements/button.dart';
import 'package:polymer/polymer.dart';

@CustomTag('gex-toolbar')
class Toolbar extends Positionable {
  
  final Logger log = new Logger('Toolbar');
  
  @published String backgroundColor = "black";
  
  Position postion ;
  Orientation orientation ;
  List<ActionDescriptor> actions ;
  List<Button> _buttons ;
  
  Toolbar.created() : super.created() ;
  
  void ready() {
    super.ready();
    this.style.backgroundColor = backgroundColor; 
  }
  
  
  void init(Position position, Orientation orientation, List<ActionDescriptor> actions) {
    this.postion = position;
    this.orientation = orientation;
    this.actions = actions ;
    _buttons = new List<Button>();
    for (var i = 0; i < actions.length; i++) {
      Button button = new Element.tag('gex-button') as Button;
      button.moveTo(position.clone()..left = position.left + i * position.width  ) ;
      button.targetAction(actions[i]);
      this.append(button);
      _buttons.add(button);
    }
  }
  
  List<Button> get buttons{
    List<Button> buttons = new List<Button>();
    _buttons.forEach((b)=> buttons.add(b.clone(true)));
    return buttons ;
  }
  
}
