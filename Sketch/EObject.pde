/* Class Info: 

Super class of most Objects that are displayed on the screen

Subclasses: EPoint, ECurve 
    
*/
class EObject {
  
  /* Instance Variables:
      hide - determines whether or not the EObject should be displayed
      dependents - list of EObjects that will be changed when EObject is changed
      name - String; the objects name
      selected - whether or not the object has been selected (if the mouse is over it; the user has selected it to perform some function)
      exists - whether or not an object "exists" (e.g. a point which is defined as the intersection of 2 curves won't exist if the 2 curves don't intersect)
  */
  
  boolean hide = false;
  ArrayList<EObject> dependents = new ArrayList<EObject>();
  String name = "";
  boolean selected;
  boolean exists = true;  
   
  //================================================================================================== 
  
  
  /* Constructor:
      EObject() - default constructor
  */
  
  EObject() {
    hide = false;
    dependents = new ArrayList<EObject>();
    name = "";
    selected = false;
    exists = true;
  }
  
  
  //==========================================================================================
  
  
  /* ======= void display() ========
    Inputs: None
    Funtion: Displays the Object
  */
  
  void display() {}
  
  /* ======= void removePointers() =======
    Inputs: None    
    Function: If an EObject p1 has another EObject p2 as an instance variable (separate from p1), 
                   then p1 will be in the p2.dependents.
              This method removes p1 from p2.dependents.
  */
  
  void removePointers() {}
  
  /* ======= void addPointers() =======
    Inputs: None
    Function: In the same scenario as above, this method adds p1 from p2.dependents.
  */
  
  void addPointers() {}
  
  /* ======= void addDependent() =======
     Inputs: EObject e
     Function: Adds e to ArrayList dependents 
  */
  
  void addDependent(EObject e) {
    dependents.add(e);
  }
  
  /* ======= void removeDependent() =======
     Inputs: EObject e
     Function: Removes e from ArrayList dependents 
  */
  
  void removeDependent(EObject e) {
    dependents.remove(e);
  }
  
  /* ======= void hide() =======
     Inputs: None
     Function: Sets hide to true; Makes it so the object is hidden from view
  */
  
  void hide() {
    hide = true;
  }
  
  /* ======= void show() =======
     Inputs: None
     Function: Sets hide to false; Makes it so the object is unhidden from view
  */
  
  void show() {
    hide = false;
  }
  
  /* ======= void changeName() =======
     Inputs: String n
     Function: Sets name to n
  */
    
  void changeName(String n) {
    name = n;
  }
  
  /* ======= void select() =======
     Inputs: None
     Function: Sets select to true
  */
  
  void select() {
    selected = true;
  }
  
  /* ======= void unselect() =======
     Inputs: None
     Function: Sets select to false
  */
  
  void unselect() {
    selected = false;
  }
  
  /* ======= void update() =======
     Inputs: None
     Function: Resets the position of the object and its dependents based on any changes made to other objects
     Helper Functions: unupdate(), updateHelper()
  */
  
  void update() {
    for (int i = 0; i < dependents.size(); i++) {
      dependents.get(i).update();
    }
  }
  
  
  /* ======= void unexist() =======
     Inputs: None
     Function: Sets exist for the EObject and all EObjects dependent upon it to false
  */
  
  void unexist() {
    exists = false;
    for (EObject e : dependents) {
      e.unexist();
    }
  }
  
  /* ======= void reexist() =======
     Inputs: None
     Function: Sets exist for the EObject and all EObjects dependent upon it to true
  */
  
  void reexist() {
    exists = true;
    for (EObject e : dependents) {
      e.reexist();
    }
  }
}
