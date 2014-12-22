part of gex_common_ui_elements;




class Identifiable{
  String id;
}

enum Orientation { north, est, south, west }

/**
 * Be able to move the element in an absolute space.
 * Should have a main element as root div. 
 */
abstract class Positionable extends PolymerElement with Identifiable{
  
  final Logger log = new Logger('Positionable');
  
  @published String id;
  
  Position position = new Position.empty();
  
  Positionable.created() : super.created() {
    log.fine("Positionable object created with name: ${id}");
  }
  
  void moveTo(Position position) {
    log.fine("Moving ${id} to ${position}");
    this.position = position;
    _moveToTargetPosition();
  }
  
  void _moveToTargetPosition(){
    this.style.position = "absolute" ;
    this.style
        ..left = "${position.left}px" 
        ..top = "${position.top}px" 
        ..width = "${position.width}px" 
        ..height = "${position.height}px" 
        ..zIndex = position.zIndex.toString() ;
  }
  
}


class Position {
  num left ;
  num top ;
  num width ;
  num height ;
  num zIndex;
  
  Position.empty();
  Position(this.left,this.top,this.width,this.height,this.zIndex);
  
  Position clone(){
    return new Position(this.left,this.top,this.width,this.height,this.zIndex); 
  }
  
  num get smallerSection => width>height?height:width;
  num get largerSection => width<height?height:width;
  
  @override
  String toString() => "SquarePosition: left:${left}, top:${top}, width:${width}, height:${height}, zIndex:${zIndex}";
  
}