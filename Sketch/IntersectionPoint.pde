class IntersectionPoint extends EPoint{
  /* Instance Variables:
      hide - determines whether or not the EPoint should be displayed
      dependents - EObjects that should be changed when EPoint is changed
      name - the object's name
      xpos - x coordinate of the point
      ypos - y coordinate of the point
      moveable - boolean; whether or not user can move the point throughout the plane
      curveMoveable - boolean; whether or not the point can be moved on a specific curve
  */

  ECurve leftCurve;
  ECurve rightCurve;
  
  /* Constructors:
      IntersectionPoint(CurveL, CurveR, name) - creates static point at intersection of two curves w/ left curve CurveL
  */
  
  IntersectionPoint(EPoint p) {
    super(p);
    leftCurve = null;
    rightCurve = null;
  }
  
  IntersectionPoint(ECurve CurveL, ECurve CurveR, String n) {
    super();
    setXY(CurveL, CurveR);
    leftCurve = CurveL;
    rightCurve = CurveR;
    name = n;
    leftCurve.addDependent(this);
    rightCurve.addDependent(this);
  }
  
  IntersectionPoint(ECurve CurveL, ECurve CurveR, float xpos, float ypos, String n) {
    super();
    leftCurve = null;
    rightCurve = null;
    setOrder(CurveL, CurveR, xpos, ypos);
    setXY(leftCurve, rightCurve);
    name = n;
    leftCurve.addDependent(this);
    rightCurve.addDependent(this);
  }
  
  void setOrder(ECurve CurveL, ECurve CurveR, float xpos, float ypos) {
    EPoint temp = new EPoint();
    if ((CurveL instanceof ELine) && (CurveR instanceof ELine)) {
      leftCurve = CurveL;
      rightCurve = CurveR;
    }
    else if ((CurveL instanceof ELine) && (CurveR instanceof ECircle)) {
      reexist();
      ELine a = (ELine) CurveL;
      ECircle b = (ECircle) CurveR;
      EPoint intA = new EPoint(xpos,ypos);
      EPoint intB = new EPoint();
      EPoint int1 = intersectionP(b, a);
      EPoint int2 = intersectionN(b, a);
      if (distance(intA,int1) < distance(intA,int2)) {
        intB = int2;
      } else {
        intB = int1;
      }
      if (sameSign(intA.xpos - intB.xpos, a.RPoint.xpos - a.LPoint.xpos) && sameSign(intA.ypos - intB.ypos, a.RPoint.ypos - a.LPoint.ypos)) {
        leftCurve = CurveR;
        rightCurve = CurveL;
      } else {
        leftCurve = CurveL;
        rightCurve = CurveR;
      }
    }
    else if ((CurveL instanceof ECircle) && (CurveR instanceof ELine)) {
      reexist();
      ELine a = (ELine) CurveR;
      ECircle b = (ECircle) CurveL;
      EPoint intA = new EPoint(xpos,ypos);
      EPoint intB = new EPoint();
      EPoint int1 = intersectionP(b, a);
      EPoint int2 = intersectionN(b, a);
      if (distance(intA,int1) < distance(intA,int2)) {
        intB = int2;
      } else {
        intB = int1;
      }
      if (sameSign(intA.xpos - intB.xpos, a.RPoint.xpos - a.LPoint.xpos) && sameSign(intA.ypos - intB.ypos, a.RPoint.ypos - a.LPoint.ypos)) {
        leftCurve = CurveR;
        rightCurve = CurveL;
      } else {
        leftCurve = CurveL;
        rightCurve = CurveR;
      }
    }
    else if ((CurveL instanceof ECircle) && (CurveR instanceof ECircle)) {
      reexist();
      ECircle cL = (ECircle) CurveL;
      ECircle cR = (ECircle) CurveR;
      EPoint intA = new EPoint(xpos,ypos);
      float a = intA.xpos - cL.center.xpos;
      float b = intA.ypos - cL.center.ypos;
      float c = cR.center.xpos - cL.center.xpos;
      float d = cR.center.ypos - cL.center.ypos;
      if (a*d >= b*c) {
        leftCurve = CurveL;
        rightCurve = CurveR;
      }
      else {
        leftCurve = CurveR;
        rightCurve = CurveL;
      }
    }
  }
  
  /* setXY(ECurve CurveL, ECurve CurveR)
      1. If both curves are lines it sets the point to their intersection
      2. If CurveL is a line and CurveR is a circle
          If A,B are the two intersection points, and A -> B is the same direction as LPoint -> RPoint
            it returns B
      3. If CurveL is a circle and CurveR is a line
          If A,B are the two intersection points, and A -> B is the same direction as RPoint -> LPoint
            it returns B
      4. If both CurveL is a circle and CurveR is a circle
          Then if E is the desired intersection point and L,R the respective centers,
          LR X LE has positive z component
            
  */
  
  void setXY(ECurve CurveL, ECurve CurveR) {
    EPoint temp = new EPoint();
    if ((CurveL instanceof ELine) && (CurveR instanceof ELine)) {
      temp = intersection((ELine) CurveL, (ELine) CurveR);
      xpos = temp.xpos;
      ypos = temp.ypos;
      ELine a = (ELine) CurveL;
      ELine b = (ELine) CurveR;
      reexist();
      if (!a.infinite) {
        if (!(((xpos >= a.RPoint.xpos) && (xpos <= a.LPoint.xpos)) || ((xpos >= a.LPoint.xpos) && (xpos <= a.RPoint.xpos)))) {
          unexist();
        }
      }
      if (!b.infinite) {
        if (!(((xpos >= b.RPoint.xpos) && (xpos <= b.LPoint.xpos)) || ((xpos >= b.LPoint.xpos) && (xpos <= b.RPoint.xpos)))) {
          unexist();
        }
      }
    }
    else if ((CurveL instanceof ELine) && (CurveR instanceof ECircle)) {
      reexist();
      ELine a = (ELine) CurveL;
      ECircle b = (ECircle) CurveR;
      EPoint intA = intersectionP(b, a);
      EPoint intB = intersectionN(b, a);
      if (intA == null) {
        unexist();
      } else  {
        if (sameSign(intB.xpos - intA.xpos, a.RPoint.xpos - a.LPoint.xpos) && sameSign(intB.ypos - intA.ypos, a.RPoint.ypos - a.LPoint.ypos)) {
          xpos = intB.xpos;
          ypos = intB.ypos;
        } else {
          xpos = intA.xpos;
          ypos = intA.ypos;
        }
      }   
    }
    else if ((CurveR instanceof ELine) && (CurveL instanceof ECircle)) {
      reexist();
      ELine a = (ELine) CurveR;
      ECircle b = (ECircle) CurveL;
      EPoint intA = intersectionP(b, a);
      EPoint intB = intersectionN(b, a);
      if (intA == null) {
        unexist();
      } else  {
        if (sameSign(intB.xpos - intA.xpos, a.LPoint.xpos - a.RPoint.xpos) && sameSign(intB.ypos - intA.ypos, a.LPoint.ypos - a.RPoint.ypos)) {
          xpos = intB.xpos;
          ypos = intB.ypos;
        } else {
          xpos = intA.xpos;
          ypos = intA.ypos;
        }
      }
    }
    else if ((CurveL instanceof ECircle) && (CurveR instanceof ECircle)) {
      reexist();
      ECircle cL = (ECircle) CurveL;
      ECircle cR = (ECircle) CurveR;
      EPoint intA = intersectionP(cL, cR);
      EPoint intB = intersectionN(cL, cR);
      if (intA == null) {
        unexist();
      }
      else {
        float a = intA.xpos - cL.center.xpos;
        float b = intA.ypos - cL.center.ypos;
        float c = cR.center.xpos - cL.center.xpos;
        float d = cR.center.ypos - cL.center.ypos;
        if (a*d >= b*c) {
          xpos = intA.xpos;
          ypos = intA.ypos;
        }
        else {
          xpos = intB.xpos;
          ypos = intB.ypos;
        }
      }
    }
  }
  
  void setHiddens() {
    show();
    ELine a;
    if (leftCurve instanceof ELine) {
      a = (ELine) leftCurve;
      if (between(a)) {
        hide();
      }
    }
    if (rightCurve instanceof ELine) {
      a = (ELine) rightCurve;
      if (between(a)) {
        hide();
      }
    }
  }
  
  boolean between(ELine l) {
    return (!l.infinite && (((l.RPoint.xpos >= xpos) && (l.LPoint.xpos <= xpos)) || ((l.RPoint.xpos <= xpos) && (l.LPoint.xpos >= xpos))));
  }
  
  /* Inherited Methods:
      addDependent() - adds a new EObject that is dependent on this
      delete() - removes the object from the image
      hide() - hides object
      show() - shows object
      changeName(n) - changes name to n
      setX(c) - sets x coordinate to c
      setY(c) - sets y coordinate to c
  */
  
  
  
  /* Overridden Methods:
      update() - updates the coordinates of P based upon changes in its 2 curves
  */
  
  void removePointers() {
    leftCurve.removeDependent(this);
    rightCurve.removeDependent(this);
  }
  
  void addPointers() {
    leftCurve.addDependent(this);
    rightCurve.addDependent(this);
  }
  
  void update() {
    setXY(leftCurve, rightCurve);
    for (int i = 0; i < dependents.size(); i++) {
      dependents.get(i).update();
    }
  }
  
  void display() {
    if (!hide && exists) {
      if (!selected) {
        fill(255,0,0);
      } else {
        fill(127,0,0);
      }
      ellipse(convX(xpos), convY(ypos),10,10);
    }
  }
  
}
