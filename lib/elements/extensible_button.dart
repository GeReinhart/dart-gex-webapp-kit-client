library gex_common_ui_elements.extensible_button;

import "dart:html";
import 'package:polymer/polymer.dart';
import 'package:logging/logging.dart';
import "position.dart";
/**
 * An gex-extensible-button, change it's display according to the space it can to take.
 * It launch an event on the click on the button.
 */
@CustomTag('gex-extensible-button')
class ExtensibleButton  extends Positionable {

  final Logger log = new Logger('ExtensibleButton');
  @published String label;
  @published String backgroundColor;
  
  ExtensibleButton.created() : super.created() {
    log.info("ExtensibleButton created with label: ${label}");
  }

  void ready() {
    super.ready();
    this.style.backgroundColor = backgroundColor; 
  }
  
  void moveTo(SquarePosition position) {
    super.moveTo(position);
    if (position.width < 100 ){
      _labelSpan.style.display = "none" ;
    }
  }
  
  bool get isButtonLabelVisible => _labelSpan.style.display != "none" ;
  bool get isImageVisible => _imageElement.style.display != "none" ;
  
  SpanElement get _labelSpan => $["label"] as SpanElement;
  ImageElement get _imageElement => $["image"] as ImageElement;
    
  
  /*
   * Optional lifecycle methods - uncomment if needed.
   *

  /// Called when an instance of gex-button is inserted into the DOM.
  attached() {
    super.attached();
  }

  /// Called when an instance of gex-button is removed from the DOM.
  detached() {
    super.detached();
  }

  /// Called when an attribute (such as  a class) of an instance of
  /// gex-button is added, changed, or removed.
  attributeChanged(String name, String oldValue, String newValue) {
  }

  /// Called when gex-button has been fully prepared (Shadow DOM created,
  /// property observers set up, event listeners attached).
  ready() {
  }
   
  */
  
  

}
