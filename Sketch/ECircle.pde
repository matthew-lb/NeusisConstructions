class ECircle extends ECurve {
  
  /* Instance Variables
      hide - determines whether or not the EObject should be displayed
      dependents - list of EObjects that will be changed when EObject is changed
      name - String; the objects name
      center - point representing center of the circle
      radius - float represented length of radius of the center
  */
  
  EPoint center;
  float radius;
  
  /* Constructors:
      ECircle(cen, r, n) - creates a circle of radius r centered at cen w/ name n
  */
  
  ECircle() {
    center = new EPoint(0,0);
    radius = 0;
  }
  
  ECircle(EPoint cen, float r, String n) {
    hide = false;
    dependents = new ArrayList<EObject>();
    name = n;
    center = cen;
    radius = r;
    selected = false;
    center.addDependent(this);
  }
  
  /* Methods: 
      display() - displays the object
      addDependent() - adds a new EObject that is dependent on this
      hide() - hides object
      show() - shows object
      changeName(n) - changes name to n
      setCenter(p) - 
  */
  
  void display() {
    if (!hide && exists) {
      noFill();
      if (selected) {
        stroke(0,255,0);
      } else {
        stroke(0);
      }
      ellipse(convX(center.xpos), convY(center.ypos), 2*radius, 2*radius);
    }
  }
  
  void setCenter(EPoint p) {
    center = p;
  }
  
  void setRadius(float r) {
    radius = r;
  }
}

