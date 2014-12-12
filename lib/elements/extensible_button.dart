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
  @published String name;
  @published String backgroundColor;
  
  ExtensibleButton.created() : super.created() {
    log.info("ExtensibleButton created with name: ${name}");
  }

  void ready() {
    super.ready();
    this.style.backgroundColor = backgroundColor; 
  }
  
  
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
