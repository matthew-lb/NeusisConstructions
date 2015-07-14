class MovePoint extends EPoint{
  /* Instance Variables:
      hide - determines whether or not the EPoint should be displayed
      dependents - EObjects that should be changed when EPoint is changed
      name - the object's name
      xpos - x coordinate of the point
      ypos - y coordinate of the point
      moveable - true; the point can move
  */
  
  /* Constructors:
      EPoint(xpos, ypos, name) - creates moveable EPoint w/ coordinates xpos, ypos
  */
  
  MovePoint(float x, float y, String n) {
    super(x,y,n);
  }
  
  /* Inherited Methods:
      display() - displays the object
      addDependent() - adds a new EObject that is dependent on this
      hide() - hides object
      show() - shows object
      changeName(n) - changes name to n
      setX(c) - sets x coordinate to c
      setY(c) - sets y coordinate to c
  */
 
}
