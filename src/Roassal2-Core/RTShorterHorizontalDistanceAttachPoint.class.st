"
-=-=-=

v := RTView new.

e1 := (RTBox new size: 50) elementOn: 1.
e2 := (RTEllipse new size: 50) elementOn: 2.
v add: e1; add: e2.
e2 translateBy: 30 @ 60.

e1 @ RTDraggable.
e2 @ RTDraggable.

s := RTArrowedLine new color: Color black.
s attachPoint:  RTShorterHorizontalDistanceAttachPoint new.
l := s edgeFrom: e1 to: e2.
v add: l.

v

-=-=-=-
"
Class {
	#name : #RTShorterHorizontalDistanceAttachPoint,
	#superclass : #RTAbstractShorterDistanceAttachPoint,
	#category : #'Roassal2-Core-AttachPoint'
}

{ #category : #'public - hooks' }
RTShorterHorizontalDistanceAttachPoint >> attachPointsFor: anEdge on: anElement [
	"Return the four possible attach points for each of the four sides for given edge on given element."
	| rec center |
	rec := anElement encompassingRectangle.
	center := rec center.
	^ Array 		
		 "right side"
		with: (rec right @ (center y))
		"left side"
		with: (rec left @ (center y))
	
]
