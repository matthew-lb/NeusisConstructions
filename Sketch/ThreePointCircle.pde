class ThreePointCircle extends ECircle {
  
  /* Instance Variables
      hide - determines whether or not the EObject should be displayed
      dependents - list of EObjects that will be changed when EObject is changed
      name - String; the objects name
      center - point representing center of the circle
      radius - float represented length of radius of the center
      pointA - 1st point on the circle
      pointB - 2nd point on the circle
      pointC - 3rd point on the circle
  */
  
  EPoint pointA;
  EPoint pointB;
  EPoint pointC;
  
  ThreePointCircle(EPoint a, EPoint b, EPoint c, String n) {
    dependents = new ArrayList<EObject>();
    selected = false;
    hide = false;
    name = n;
    center = circumCenter(a,b,c);
    center.hide = true;
    radius = distance(center, a);
    pointA = a;
    pointB = b;
    pointC = c;
    pointA.addDependent(this);
    pointB.addDependent(this);
    pointC.addDependent(this);
  }
  
  void removePointers() {
    pointA.removeDependent(this);
    pointB.removeDependent(this);
    pointC.removeDependent(this);
  }
  
  void addPointers() {
    pointA.addDependent(this);
    pointB.addDependent(this);
    pointC.addDependent(this);
  }
  
  void update() {
    center = circumCenter(pointA, pointB, pointC);
    radius = distance(center, pointA);
    for (int i = 0; i < dependents.size(); i++) {
      dependents.get(i).update();
    }
  }

}
