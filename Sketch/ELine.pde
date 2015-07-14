class ELine extends ECurve {
  
  /* Instance Variables:
      hide - determines whether or not the EObject should be displayed
      dependents - list of EObjects that will be changed when EObject is changed
      name - String; the objects name
      LPoint - first point line passes through
      RPoint - second point line passes through
      infinite - whether or not the line is infinite;
  */
  
  EPoint LPoint;
  EPoint RPoint;
  boolean infinite;
  
  ELine(EPoint l, EPoint r, String s) {
    hide = false;
    dependents = new ArrayList<EObject>();
    name = s;
    LPoint = l;
    RPoint = r;
    selected = false;
    infinite = false;
    LPoint.addDependent(this);
    RPoint.addDependent(this);
  }
  
  ELine(EPoint l, EPoint r, String s, boolean inf) {
    hide = false;
    dependents = new ArrayList<EObject>();
    name = s;
    LPoint = l;
    RPoint = r;
    selected = false;
    LPoint.addDependent(this);
    RPoint.addDependent(this);
    infinite = inf;
  }
  
  /* Methods:
      display() - displays the object
      addDependent() - adds a new EObject that is dependent on this
      hide() - hides object
      show() - shows object
      changeName(n) - changes name to n
      setX(c) - sets x coordinate to c
      setY(c) - sets y coordinate to c
  */
  
  void removePointers() {
    LPoint.removeDependent(this);
    RPoint.removeDependent(this);
  }
  
  void addPointers() {
    LPoint.addDependent(this);
    RPoint.addDependent(this);
  }
  
  void display() {
    if (!hide && exists) {
      if (infinite) { 
        if (distance(LPoint, RPoint) != 0) { // if the points are non-identical
          float cenx = (LPoint.xpos + RPoint.xpos)/2.0;
          float ceny = (LPoint.ypos + RPoint.ypos)/2.0;
          float scale = 2*(width + height)/distance(LPoint, RPoint);
          float xshift = scale * (LPoint.xpos - RPoint.xpos);
          float yshift = scale * (LPoint.ypos - RPoint.ypos);
          if (selected) {
            stroke(0,255,0);
          }
          line(convX(cenx + xshift), convY(ceny + yshift), convX(cenx - xshift), convY(ceny - yshift)); // displays the line as "infinte"
        }
        
      }
      else {
        stroke(0);
        if (selected) {
            stroke(0,255,0);
        }
        line(convX(LPoint.xpos), convY(LPoint.ypos), convX(RPoint.xpos), convY(RPoint.ypos));
      }
    }
  }

}
