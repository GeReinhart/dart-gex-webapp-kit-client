library gex_common_ui_elements.extensible_button;

import "dart:html";
import 'package:logging/logging.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart';

import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_shadow.dart';
import 'package:paper_elements/paper_button.dart';

/**
 * Change it's display according to the space it can take.
 * Execute the action on the click on the button.
 */
@CustomTag('gex-button')
class Button  extends Positionable with Actionable, Showable {

  final Logger log = new Logger('Button');
  final num MIN_SIZE_WITH_TEXT = 150 ;  
  final num HEIGHT_TEXT = 35 ;
  final num PART_USED_BY_IMAGE = .85 ;

  @published String label = "";
  @published String image = "";
  @published String backgroundColor;
  
  Button.created() : super.created() {
    log.fine("Button ${id} created with label: ${label}");
  }

  void attached() {
    super.attached();
    this.style.backgroundColor = backgroundColor;
    if( image.isNotEmpty ){
      _imageElement.style.display = "inline" ;
      _imageElement.src = image ;
    }else{
      _imageElement.style.display = "none" ;
    }
    this.onClick.listen((_)=>_click());
    this.onMouseDown.listen((_)=>_shadow.z= 1);
    this.onMouseUp.listen(  (_)=>_shadow.z= 2);
  }
  
  void _click(){
    launchAction(null);
  }

  @override
  Button clone(bool deep ){
    Button clone = (new Element.tag('gex-button')
           ..attributes['label'] = label
           ..attributes['image'] = image
           ..attributes['backgroundColor'] = backgroundColor )   as Button;
    return clone..targetAction(this.action);
  }
  
  Button cloneAndMove( Position position ){
    Button clone = this.clone(true);
    return clone..moveTo(position);
  }
  
  
  void moveTo(Position position) {
    if (isCurrentPostion(position)){
      return ;
    }
    super.moveTo(position);
    
    num heightForImage  ;
    num heightForText = 0 ;
    if ( image.isNotEmpty &&  ( position.width < MIN_SIZE_WITH_TEXT || label.isEmpty  ) ){
      _labelSpan.style.display = "none" ;
      heightForImage = position.smallerSection ;
    }else{
      heightForImage = position.smallerSection - HEIGHT_TEXT ;
      heightForText = HEIGHT_TEXT;
    }
    String squareSize  = "${heightForImage * PART_USED_BY_IMAGE}px";
    String smallMargin = "${heightForImage * (1-PART_USED_BY_IMAGE)/2 }px";
    String largeMargin = "${heightForImage * (1-PART_USED_BY_IMAGE)/2  + ( position.largerSection - position.smallerSection+heightForText)/2 }px";
    
    _imageElement.style
        ..width  = squareSize   
        ..height = squareSize
        ..top  = position.height < position.width ? smallMargin : largeMargin
        ..left = position.height > position.width ? smallMargin : largeMargin;
        
    try {
       Element internalButton = _button.shadowRoot.querySelector('div') ;
       internalButton.style
              ..width = "${position.width}px"
              ..height= "${position.height}px";
    } catch(exception) {
        log.fine("Unable to change size of the internal button of ExtensibleButton ${id}");
    }
  }
  
  bool get isButtonLabelVisible => _labelSpan.style.display != "none" ;
  bool get isImageVisible => _imageElement.style.display != "none" && _imageElement.src.isNotEmpty ;
  
  SpanElement get _labelSpan => $["label"] as SpanElement;
  ImageElement get _imageElement => $["image"] as ImageElement;
  ImageElement get imageElement => _imageElement.clone(true);
  PaperShadow get _shadow => $["shadow"] as PaperShadow;
  PaperButton get _button => $["button"] as PaperButton;    
  
}


