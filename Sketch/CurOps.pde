  /* File for extra methods that are useful elsewhere;
     If this were java, these would all be in a static class, 
     but Processing doesn't like static classes b/c it's stupid like that.
  */
  
  
  
  /* Conversion between point types:
      convX(float x) - converts regular abscissa to processing abscissa
      convY(float y) - converts regular ordinate to processing ordinate
  */
  
  float convX(float x) {
    return (width/2 - x);
  }
  
  float convY(float y) {
    return (height/2 - y);
  }
  
  boolean onScreen(float x, float y) {
    return ((x >= 0) && (x <= width) && (y >= 0) && ( y <= height));
  }
  
  
  
  
  /* Distance Functions
    distance(EPoint a, EPoint b) - returns distance between a,b
    distance(float x, float y, ECircle circ) - returns the distance between (x,y) and circle circ
    distance(float x, float y, EPint b) - returns the distance between (x,y) and b
    distance(float x, y, ELine l) - returns the distance between (x,y) and line l
    area(Epoint a, EPoint b EPoint c) - returns area of the triangle w/ vertices a,b,c
  */
  
  float distance(EPoint a, EPoint b) {
    return sqrt(pow(a.xpos - b.xpos,2) + pow(a.ypos - b.ypos,2));
  }
  
  float distance(float xpos, float ypos, ECircle circ) {
    return abs(distance(new EPoint(xpos,ypos,""), circ.center)-circ.radius);
  }
  
  float distance(float xpos, float ypos, EPoint b) {
    return distance(new EPoint(xpos,ypos,""), b);
  }
  
  float distance(float xpos, float ypos, ELine l) {
    return area(new EPoint(xpos, ypos, ""),l.LPoint, l.RPoint)/distance(l.LPoint, l.RPoint);
  }
  
  float area(EPoint a, EPoint b, EPoint c) {
    return .5 * abs((a.xpos*b.ypos + b.xpos*c.ypos + c.xpos*a.ypos) - (b.xpos*a.ypos + c.xpos*b.ypos + a.xpos*c.ypos));                 //Surveyor's Rule
  }
  
  
  /* Constructions:
      midpoint(EPoint a, EPoint b) - constructs the midpoint of a,b
      perpBisector(EPoint a, EPoint b) - constructs the perpendicular bisector of the segment connecting a,b
      circumCenter(EPoint a, EPoint b, EPoint c) - constructs the circumcenter of a,b,c
  */
  
  EPoint midpoint(EPoint a, EPoint b) {
    return new EPoint((a.xpos+b.xpos)/2.0,(a.ypos+b.ypos)/2.0, "");
  }
  
  ELine perpBisector(EPoint a, EPoint b) {
    EPoint mid = midpoint(a,b);
    EPoint sec = new EPoint(mid.xpos + a.ypos - b.ypos, mid.ypos + b.xpos - a.xpos);
    return new ELine(mid,sec,"",true);
  }
  
  EPoint circumCenter(EPoint a, EPoint b, EPoint c) {
    ELine l1 = perpBisector(a,b);
    ELine l2 = perpBisector(b,c);
    return intersection(l1,l2);
  }
  
  
  
  /* Intersections:
  
  */
  
  EPoint intersection(ELine a, ELine b) {
    float x1 = a.LPoint.xpos;
    float x2 = a.RPoint.xpos;
    float x3 = b.LPoint.xpos;
    float x4 = b.RPoint.xpos;
    float y1 = a.LPoint.ypos;
    float y2 = a.RPoint.ypos;
    float y3 = b.LPoint.ypos;
    float y4 = b.RPoint.ypos;
    if (((x1-x2)*(y3-y4) - (y1-y2)*(x3-x4)) == 0) {
      return new EPoint();
    }
    float nXcor = ((x1*y2 - y1*x2)*(x3-x4) - (x3*y4 - y3*x4)*(x1-x2))/((x1-x2)*(y3-y4) - (y1-y2)*(x3-x4));
    float nYcor = ((x1*y2 - y1*x2)*(y3-y4) - (x3*y4 - y3*x4)*(y1-y2))/((x1-x2)*(y3-y4) - (y1-y2)*(x3-x4));
    return new EPoint(nXcor, nYcor,"");
  }
  
  EPoint intersectionP(ECircle a, ELine b) {
    if (distance(a.center.xpos, a.center.ypos, b) > a.radius) {
      return null;
    }
    if (b.LPoint.xpos == b.RPoint.xpos) {
      return new EPoint(b.LPoint.xpos, quadFormulaP(1, -2*a.center.ypos, pow(a.center.ypos,2)-pow(a.radius,2)));
    } else {
      float m = (b.LPoint.ypos - b.RPoint.ypos)/ (b.LPoint.xpos - b.RPoint.xpos);
      float h = b.LPoint.ypos - m * b.LPoint.xpos;
      float xc = a.center.xpos;
      float yc = a.center.ypos;
      float xpos = quadFormulaP(pow(m,2)+1, -2*xc + 2*m*(h-yc),pow(h-yc,2)+pow(xc,2)-pow(a.radius,2));
      float ypos = m*xpos + h;
      return new EPoint(xpos,ypos,"");
    }
  }
  
  EPoint intersectionN(ECircle a, ELine b) {
    if (distance(a.center.xpos, a.center.ypos, b) > a.radius) {
      return null;
    }
    if (b.LPoint.xpos == b.RPoint.xpos) {
      return new EPoint(b.LPoint.xpos, quadFormulaN(1, -2*a.center.ypos, pow(a.center.ypos,2)-pow(a.radius,2)));
    } else {
      float m = (b.LPoint.ypos - b.RPoint.ypos)/ (b.LPoint.xpos - b.RPoint.xpos);
      float h = b.LPoint.ypos - m * b.LPoint.xpos;
      float xc = a.center.xpos;
      float yc = a.center.ypos;
      float xpos = quadFormulaN(pow(m,2)+1, -2*xc + 2*m*(h-yc),pow(h-yc,2)+pow(xc,2)-pow(a.radius,2));
      float ypos = m*xpos + h;
      return new EPoint(xpos,ypos,"");
    }
  }
  
  ELine intersectionLine(ECircle a, ECircle b) {
    if ((a.center.xpos == b.center.xpos) && (a.center.ypos == b.center.ypos) && (a.radius == b.radius)) {
      return null;
    }
    if ((abs(a.radius - b.radius) > distance(a.center, b.center)) || (distance(a.center,b.center) > a.radius + b.radius)) {
      return null;
    }
    float x1 = a.center.xpos;
    float x2 = b.center.xpos;
    float y1 = a.center.ypos;
    float y2 = b.center.ypos;
    float rhs = (pow(a.radius,2) - pow(b.radius,2)) - (pow(x1,2) - pow(x2,2)) - (pow(y1,2) - pow(y2,2));
    if (y1 == y2) {
      return new ELine(new EPoint(0,y1), new EPoint(1,y1),"");
    } 
    else if (x1 == x2) {
      return new ELine(new EPoint(0,y1), new EPoint(1,y1),"");
    }
    else {
      return new ELine(new EPoint(0,rhs/(-2*(y1-y2))), new EPoint(rhs/(-2*(x1-x2)),0),"");
    }
  }
  
  EPoint intersectionP(ECircle a, ECircle b) {
    ELine intLine = intersectionLine(a,b);
    if (intLine == null) {
      return null;
    }
    else {
      return intersectionP(a,intLine);
    }
  }
  
  EPoint intersectionN(ECircle a, ECircle b) {
    ELine intLine = intersectionLine(a,b);
    if (intLine == null) {
      return null;
    }
    else {
      return intersectionN(a,intLine);
    }
  }
  
  EPoint intersection(ELine b, ECircle a) {
    if (distance(a.center.xpos, a.center.ypos, b) > a.radius) {
      return null;
    }
    if (b.LPoint.xpos == b.RPoint.xpos) {
      return new EPoint(b.LPoint.xpos, quadFormulaN(1, -2*a.center.ypos, pow(a.center.ypos,2)-pow(a.radius,2)));
    } else {
      float m = (b.LPoint.ypos - b.RPoint.ypos)/ (b.LPoint.xpos - b.RPoint.xpos);
      float h = b.LPoint.ypos - m * b.LPoint.xpos;
      float xc = a.center.xpos;
      float yc = a.center.ypos;
      float xpos = quadFormulaN(pow(m,2)+1, -2*xc + 2*m*(h-yc),pow(h-yc,2)+pow(xc,2)-pow(a.radius,2));
      float ypos = m*xpos + h;
      return new EPoint(xpos,ypos,"");
    }
  }
  
  EPoint intersection(ECircle a, ELine b) {
    return intersection(b,a);
  }
  
  EPoint intersection(ECurve a, ECurve b) {
    if ((a instanceof ELine) && (b instanceof ELine)) {
       return intersection((ELine) a, (ELine) b);
    }
    if ((a instanceof ECircle) && (b instanceof ELine)) {
       return intersection((ECircle) a, (ELine) b);
    }
    if ((a instanceof ELine) && (b instanceof ECircle)) {
       return intersection((ELine) a, (ECircle) b);
    }
    if ((a instanceof ECircle) && (b instanceof ECircle)) {
       return intersectionP((ECircle) a, (ECircle) b);
    }
    return null;
  }
  
  /*
  */
  
  EPoint closestPoint(ELine a, float x, float y) {
    float slope = 0;
    if (a.RPoint.ypos == a.LPoint.ypos) {
      return new EPoint(x, a.RPoint.ypos);
    }
    else {
      slope = -1.0*(a.RPoint.xpos - a.LPoint.xpos)/(a.RPoint.ypos - a.LPoint.ypos);
      ELine newLine = new ELine(new EPoint(x,y,""), new EPoint(x + 1, y + slope,""),"");
      return intersection(a, newLine);
    }
  }
  
  EPoint closestPoint(ECircle a, float x, float y) {
    if ((a.center.xpos == x) && (a.center.ypos == y)) {
      return null;
    }
    EPoint p = new EPoint(x,y);
    ELine b = new ELine(p , a.center, "");
    EPoint intA = intersectionP(a,b);
    EPoint intB = intersectionN(a,b);
    if (distance(p,intA) < distance(p,intB)) {
      return intA;
    } else {
      return intB;
    }
  }
  
  EPoint closestPoint(ECurve a, float x, float y) {
    if (a instanceof ECircle) {
      return closestPoint((ECircle) a, x ,y);
    }
    if (a instanceof ELine) {
      return closestPoint((ELine) a, x ,y);
    }
    return null;
  }
  
  
  /* Methods for Solving Equations:
      discrim(float a, float b, float c) - returns the discriminant of ax^2 + bx + c
      quadFormulaP(float a, float b, float c) - returns the larger root of ax^2 + bx + c when a > 0
      quadFormulaN(float a, float b, float c) - returns the smaller root of ax^2 + bx + c when a > 0
      sameSign(float a, float b) - returns whether or not a,b have the same sign
  */
  
  float quadFormulaP(float a, float b, float c) {
    return (-1*b + sqrt(b*b - 4*a*c))/(2.0*a);
  }
  
  float quadFormulaN(float a, float b, float c) {
    return (-1*b - sqrt(b*b - 4*a*c))/(2.0*a);
  }
  
  boolean sameSign(float a, float b) {
    if ((a == 0) || (b == 0)) {
      return true;
    } else {
      return (a/abs(a) == b/abs(b));
    }
  }
