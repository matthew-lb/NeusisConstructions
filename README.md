# Neusis Constructions

## What it does

My project is a program which allows the user to construct geometric diagrams using the typical compass-protractor construction tools.


## Objects the user can interact with / Make:

There are essentially 7 different kinds of objects the user can interact with. Users can only control the position of MovePoints and CurvePoints everything else is defined relative to those types of points.

MovePoints (black points) - points which the user can control entirely and move anywhere on the screen.

CurvePoints (yellow points) - points which liee on a specific curve. The user can control where on the curve it is.

IntersectionPoints (red points) - points which are defined as the intersection of 2 curves.

RadialCircles - circles that are defined by a point chosen to be itâ€™s center and another selected to be on the curve. 

ThreePointCircle - circles defined by 3 points selected on it.

Eline (infinite == true) - lines which appear to be infinite and are defined by 2 points on it.

Eline (infinite == false) - line segments which are defined by their endpoints.


## How to use the program:

To run the code just open Sketch.pde in the folder Sketch and press the run button.

When the user places the mouse over different objects they will change color and/or become lighter to indicate that they have currently been selected. When the mouse is pressed/dragged over selected objects they will do different things based on what mode the code is in. The user can switch between modes using different keys. A description of each mode (and the key that needs to be pressed to switch into that mode) are below:

1. select (key == '€™s'€™): In this mode the user can drag black points (MovePoints) around the screen and yellow points (CurvePoints) around the curve they belong to and see how it changes other objects on the screen

2. placePoint (key == 'p'™): In this mode the user can place new points on the screen. If an existing point is selected nothing will happen. If no objects are selected a new black point (MovePoint) will be created. If one object is selected a yellow point (CurvePoint) will be created on that curve. If 2 objects are selected a red point (IntersectionPoint) will be created at the intersection of those 2 curves.

3. placeLine (key == 'l'€™): In this mode the user selects 2 points and segment is drawn between them.

4. infLine (key == 'i'): In this mode the user selects points and an infinite line is drawn between them.

5. radialCircle (key == â€˜râ€™): In this mode the user first selects a point to be the center of the circle and then selects a second point on the circle. A circle is then drawn accordingly.

6. circumCircle (key == '€˜c'€™): In this mode the user selects 3 points and the circle which passes through those 3 points is drawn.

7. remove (key == 'd'€™): In this mode any selected object which the user clicks is deleted. (Note: Any objects which are defined based upon the deleted object in some way are also deleted).

8. hide (key == '€˜h'€™): In this mode any object which the user selects is hidden from view (Note: This is useful for when you donâ€™t want to see an object, but want to see somethings that are defined based upon it).


In addition to having several modes the user can undo an operation by pressing the key 'u' and redo an operation by pressing the key '€˜e'€™.

## To Do
- [] Improve Comments
- [] Write class for constructing and drawing neusis 
- [] Code intersections between neusis and other curves
- [] Write guides to constructions
- [] Do Something with the names feature
 
## Bugs / Possible Issues / Comments:

1. Not really an error but something that may appear to be one: If you have 2 circle and they intersect at 2 points one of which is a black point (MovePoint) and another is a red point (IntersectionPoint), for certain arrangements the 2 points may coincide. This has to do w/ the fact that red points are not defined as the second intersection of the 2 circles (as it could be the only one defined) and the IntersectionPoint class is defined in such a way that the motion seems to be continuous. In other words, if the black point were undefined, the point would suddenly look like it switches direction.

2. EObject has a more or less obsolete instance variable known as name. I initially intended to do more with this, but I ended up not. (I am keeping it in the code in case I ever want to revisit the code and implement what I initially intended to do).

3. In diagrams where a lot of objects are dependent on only 1 or 2, the motion can seem slightly discontinuous at parts. This just has to do w/ the fact that not all the new positions are tabulated before the next frame. All the positions even out very quickly.


