class RadialCircle extends ECircle {
  
  /* Instance Variables
      hide - determines whether or not the EObject should be displayed
      dependents - list of EObjects that will be changed when EObject is changed
      name - String; the objects name
      center - point representing center of the circle
      radius - float represented length of radius of the center
      onCirc - the point on the circle
  */
 
  EPoint onCirc;
  
  RadialCircle(EPoint cen, EPoint curPoint, String n) {
    super(cen, distance(cen, curPoint), n);
    onCirc = curPoint;
    onCirc.addDependent(this);
  }
  
  void removePointers() {
    onCirc.removeDependent(this);
  }
  
  void addPointers() {
    onCirc.addDependent(this);
  }
  
  void update() {
    radius = distance(center, onCirc);
    for (int i = 0; i < dependents.size(); i++) {
      dependents.get(i).update();
    }
  }
}
