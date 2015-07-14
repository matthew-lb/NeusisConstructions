class EPoint extends EObject{
  /* Instance Variables:
      hide - determines whether or not the EPoint should be displayed
      dependents - EObjects that should be changed when EPoint is changed
      name - the object's name
      xpos - x coordinate of the point
      ypos - y coordinate of the point
  */
 
  String name;
  float xpos;
  float ypos;
  
  /* Constructors:
      EPoint(xpos, ypos, name) - creates moveable EPoint w/ coordinates xpos, ypos
  */
  
  EPoint() {
    xpos = 0;
    ypos = 0;
    hide = false;
    name = "";
    dependents = new ArrayList<EObject>();
    selected = false;
    exists = true;
  }
  
  EPoint (float x, float y) { //creates a hidden point
    xpos = x;
    ypos = y;
    hide = true;
    name = "";
    dependents = new ArrayList<EObject>();
    selected = false;
    exists = false;
  }
  
  EPoint(float x, float y, String n) {
    xpos = x;
    ypos = y;
    hide = false;
    name = n;
    dependents = new ArrayList<EObject>();
    selected = false;
    exists = true;
  }
  
  EPoint(EPoint p) {
    hide = p.hide;
    dependents = p.dependents;
    name = p.name;
    xpos = p.xpos;
    ypos = p.ypos;
    selected = p.selected;
    exists = p.exists;
  }
  
  //==================================================================================================
  
  /* ======= void display() =======
     Input: None
     Function: Displays the Point if it is not hidden and exists. 
               Also sets the color to blue if it is selected.
  */
  
  void display() {
    stroke(0);
    if (!hide && exists) {
      if (!selected) {
        fill(0);
      } else {
        fill(0,0,255);
      }
      ellipse(convX(xpos), convY(ypos),10,10);
    }
  }
  
  /* ======= void setX() =======
     Input: float c
     Function: Sets xpos to c and adjusts figures that are affected by the change.
  */
  
  void setX(float c) {
    xpos = c;
    update();
  }
  
  /* ======= void setY() =======
     Input: float c
     Function: Sets ypos to c and adjusts figures that are affected by the change.
  */
  
  void setY(float c) {
    ypos = c;
    update();
  }
  
  /* ======= void setXY() =======
     Input: float x, float y
     Function: Sets xpos to x and ypos to y and adjusts figures that are affected by the change.
  */
  
  void setXY(float x, float y) {
    xpos = x;
    ypos = y;
    update();
  }
  
  
}
