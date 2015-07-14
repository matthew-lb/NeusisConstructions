/* Instance Variables:
    points - ArrayList of all EPoints
    lines - ArrayList of all ELines
    circles - ArrayList of all ECircles
    selectedPoint - the EPoint which is currently selected
    mode - String representing what mode the code is in:
       select - point(s)/line(s)/circle(s) can be selected and moved
       placePoint - allows points to be placed
       placeLine - allows user to place lines
       infLine - allows the user to place infinite lines
       radialCircle - allows user to create 
       circumCircle - allows user to create circumcircle
       hide - allows user to hide objects
       remove - allows user to delete objects
       
*/

Stack<Act> undo = new Stack<Act>();
Stack<Act> redo = new Stack<Act>();
ArrayList<EPoint> points = new ArrayList<EPoint>();
ArrayList<ELine> lines = new ArrayList<ELine>();
ArrayList<ECircle> circles = new ArrayList<ECircle>();
EPoint selectedPoint = new EPoint();
float selectedPointx = 0;
float selectedPointy = 0;
ArrayList<ECurve> selectedObjects = new ArrayList<ECurve>();
ArrayList<EPoint> cPoints = new ArrayList<EPoint>();
String mode;

void setup(){
    size(800,800);
    background(255);
    points.add(new EPoint(0,0,""));
    points.get(0).hide();
    mode = "select";
}

void draw() {
  background(255);
  frameRate(150);
  for (int i = 0; i < circles.size(); i++) {
    circles.get(i).display();
  }
  for (int i = 0; i < points.size(); i++) {
    points.get(i).display();
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).display();
  }
}

void mouseMoved() {
  if (!mousePressed) {
    setSelected();
  }
}

void mouseDragged() {
  if (!mousePressed) {
    setSelected();
  }
  else if (mode == "select") {
    if (selectedPoint instanceof MovePoint) {
      if ((mouseX >= 0) && (mouseX <= width))
        selectedPoint.setX(convX(mouseX));
      if ((mouseY >= 0) && (mouseX <= height))
        selectedPoint.setY(convY(mouseY));
    }
    else if (selectedPoint instanceof CurvePoint) {
      selectedPoint.setXY(convX(mouseX), convY(mouseY));
    }
  }
}

void mouseReleased() {
  if (mode == "select") {
    if (selectedPoint != null) {
      if ((selectedPointx != selectedPoint.xpos) || (selectedPointy != selectedPoint.ypos)) {
        undo.push(new Move(selectedPoint, selectedPointx, selectedPointy));
      }
    }
  }
}

void mousePressed() {
  if (mode == "select") {
    if (selectedPoint != null) {
      selectedPointx = selectedPoint.xpos;
      selectedPointy = selectedPoint.ypos;
    }
  }
  if (mode == "placePoint") {
    placePoint();
  }
  if (mode == "placeLine") {
    if (selectedPoint == null) {
      placePoint();
      selectedPoint = points.get(points.size() - 1);
    }
    if (cPoints.size() == 0) {
      cPoints.add(selectedPoint);
    } else {
      lines.add(new ELine(cPoints.get(0),selectedPoint,""));
      undo.push(new Add(lines.get(lines.size() - 1)));
      cPoints = new ArrayList<EPoint>();
    }
  }
  if (mode == "infLine") {
    if (selectedPoint == null) {
      placePoint();
      selectedPoint = points.get(points.size() - 1);
    }
    if (cPoints.size() == 0) {
      cPoints.add(selectedPoint);
    } else {
      lines.add(new ELine(cPoints.get(0),selectedPoint,"",true));
      undo.push(new Add(lines.get(lines.size() - 1)));
      cPoints = new ArrayList<EPoint>();
    }
  }
  if (mode == "radialCircle") {
    if (selectedPoint == null) {
      placePoint();
      selectedPoint = points.get(points.size() - 1);
    }
    if (cPoints.size() == 0) {
      cPoints.add(selectedPoint);
    } else {
      circles.add(new RadialCircle(cPoints.get(0),selectedPoint,""));
      undo.push(new Add(circles.get(circles.size() - 1)));
      cPoints = new ArrayList<EPoint>();
    }
  }
  if (mode == "circumCircle") {
    if (selectedPoint == null) {
      placePoint();
      selectedPoint = points.get(points.size() - 1);
    }
    if (cPoints.size() < 2) {
      cPoints.add(selectedPoint);
    } else {
      circles.add(new ThreePointCircle(cPoints.get(0),cPoints.get(1),selectedPoint,""));
      undo.push(new Add(circles.get(circles.size() - 1)));
      cPoints = new ArrayList<EPoint>();
    }
  }
  if (mode == "hide") {
    if (selectedPoint != null) {
      selectedPoint.hide();
      undo.push(new Hide(selectedPoint));
    }
    for (int i = 0; i < selectedObjects.size(); i++) {
      selectedObjects.get(i).hide();
      undo.push(new Hide(selectedObjects.get(i)));
    }
  }
  Remove r;
  if (mode == "remove") {
    if (selectedPoint != null) {
      r = new Remove(selectedPoint);
      redo.push(r);
      redo.pop().redo();
    }
    if (selectedObjects.size() > 0) {
      r = new Remove(selectedObjects.get(0));
      redo.push(r);
      System.out.println("a");
      redo.pop().redo();
    }
  }
}

void keyPressed() {
  if (!mousePressed) {
    if (key == 's') {
      mode = "select";
      cPoints = new ArrayList<EPoint>();
    }
    if (key == 'p') {
      mode = "placePoint";
      cPoints = new ArrayList<EPoint>();
    }
    if (key == 'l') {
      mode = "placeLine";
      cPoints = new ArrayList<EPoint>();
    }
    if (key == 'c') {
      mode = "circumCircle";
      cPoints = new ArrayList<EPoint>();
    }
    if (key == 'r') {
      mode = "radialCircle";
      cPoints = new ArrayList<EPoint>();
    }
    if (key == 'i') {
      mode = "infLine";
      cPoints = new ArrayList<EPoint>();
    }
    if (key == 'h') {
      mode = "hide";
      cPoints = new ArrayList<EPoint>();
    }
    if (key == 'd') {
      mode = "remove";
      cPoints = new ArrayList<EPoint>();
    }
    if (key == 'u') {
      if (!undo.isEmpty()) {
        undo.pop().undo();
        cPoints = new ArrayList<EPoint>();
      }
    }
    if (key == 'e') {
      if (!redo.isEmpty()) {
        redo.pop().redo();
        cPoints = new ArrayList<EPoint>();
      }
    }
  }
}

void setSelected() {
  selectedObjects = new ArrayList<ECurve>();
  float minDist = 100.0;
  int index = -1;
  for (int i = 0; i < points.size(); i++) {
    points.get(i).unselect();
    if (!points.get(i).hide && points.get(i).exists) {
      if (distance(convX(mouseX),convY(mouseY),points.get(i)) < 12 && distance(convX(mouseX),convY(mouseY),points.get(i)) < minDist) {
        index = i;
        minDist = distance(mouseX,mouseY,points.get(i));
      } 
    }
  }
  if (index != -1) {
    points.get(index).select();
    selectedPoint = points.get(index);
  } else {
    selectedPoint = null;
  }
  for (int i = 0; i < circles.size(); i++) {
    circles.get(i).unselect();
    if (!circles.get(i).hide && circles.get(i).exists && index == -1) {
      if (distance(convX(mouseX),convY(mouseY),circles.get(i)) < 2) {
        selectedObjects.add(circles.get(i));
        circles.get(i).select();
      } 
    }
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).unselect();
    if (!lines.get(i).hide && lines.get(i).exists && index == -1) {
      if (distance(convX(mouseX),convY(mouseY),lines.get(i)) < 2) {
        selectedObjects.add(lines.get(i));
        lines.get(i).select();
      } 
    }
  }
}

void placePoint() {
   if (selectedObjects.size() == 0) {
     points.add(new MovePoint(convX(mouseX),convY(mouseY),""));
     undo.push(new Add(points.get(points.size() - 1)));
   }
   if (selectedObjects.size() == 1) {
     points.add(new CurvePoint(convX(mouseX),convY(mouseY),selectedObjects.get(0),""));
     undo.push(new Add(points.get(points.size() - 1)));
   }
   if (selectedObjects.size() >= 2) {
     if (intersection(selectedObjects.get(0),selectedObjects.get(1)) != null) {
       points.add(new IntersectionPoint(selectedObjects.get(0),selectedObjects.get(1),convX(mouseX),convY(mouseY),""));
       undo.push(new Add(points.get(points.size() - 1)));
     }
   }
}
