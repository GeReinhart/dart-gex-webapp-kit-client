library gex_common_ui_elements.extensible_button;

import "dart:html";
import 'package:polymer/polymer.dart';
import 'package:logging/logging.dart';
import 'package:paper_elements/paper_shadow.dart';
import 'package:paper_elements/paper_button.dart';
import "position.dart";
/**
 * An gex-extensible-button, change it's display according to the space it can to take.
 * It launch an event on the click on the button.
 */
@CustomTag('gex-extensible-button')
class ExtensibleButton  extends Positionable {

  final Logger log = new Logger('ExtensibleButton');
  @published String label = "";
  @published String image = "";
  @published String backgroundColor;
  
  ExtensibleButton.created() : super.created() {
    log.info("ExtensibleButton created with label: ${label}");
  }

  void ready() {
    super.ready();
    this.style.backgroundColor = backgroundColor;
    if( image.isNotEmpty ){
      _imageElement.style.display = "inline" ;
      _imageElement.src = image ;
    }else{
      _imageElement.style.display = "none" ;
    }
    this.onClick.listen((_)=>_clickOnButton());
    _shadow.animated= true;
    this.onMouseDown.listen((_)=>_onMouseDown());
    this.onMouseUp.listen((_)=>_onMouseUp() );
  }
  
  void _clickOnButton() {
    log.fine("Click on ${id}");
    _button.click();
  }
  void _onMouseDown() {
    log.fine("onMouseDown on ${id}");
    _shadow.z= 1;
    
  }
  void _onMouseUp() {
    log.fine("onMouseUp on ${id}");
    _shadow.z= 2;

  }
  
  void moveTo(Position position) {
    super.moveTo(position);
    if (position.width < 100 ){
      _labelSpan.style.display = "none" ;
    }
    String squareSize = "${position.smallerSection * .50}px";
    String smallMargin = "${position.smallerSection * (1-.50)/2 }px";
    String largeMargin = "${position.smallerSection * (1-.50)/2  + ( position.largerSection - position.smallerSection)/2 }px";
    _imageElement.style
        ..width  = squareSize   
        ..height = squareSize
        ..top = position.top < position.width ? smallMargin : largeMargin
        ..left = position.top > position.width ? smallMargin : largeMargin;
        
    _button.style
       ..zIndex = "103" 
       ..width= "${position.width}px"
       ..height= "${position.height}px";
       Element div =  $["button"].shadowRoot.querySelector('div') ;
       div.style
          ..width= "${position.width}px"
          ..height= "${position.height}px";
       
  }
  
  bool get isButtonLabelVisible => _labelSpan.style.display != "none" ;
  bool get isImageVisible => _imageElement.style.display != "none" && _imageElement.src.isNotEmpty ;
  
  SpanElement get _labelSpan => $["label"] as SpanElement;
  ImageElement get _imageElement => $["image"] as ImageElement;
  ImageElement get imageElement => _imageElement.clone(true);
  PaperShadow get _shadow => $["shadow"] as PaperShadow;
  PaperButton get _button => $["button"] as PaperButton;    
  
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


