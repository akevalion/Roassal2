Class {
	#name : #RTCompositeShape,
	#superclass : #RTShape,
	#instVars : [
		'shapes',
		'layout',
		'automaticallyUpdateLayout'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'instance creation' }
RTCompositeShape class >> with: shape1 with: shape2 [
	^ self new 
		add: shape1;
		add: shape2;
		yourself
]

{ #category : #adding }
RTCompositeShape >> add: aRTShape [
	self add: aRTShape translateBy: 0 @ 0
]

{ #category : #adding }
RTCompositeShape >> add: aRTShape translateBy: aPoint [
	shapes add: (Array with: aRTShape with: aPoint)
]

{ #category : #'public - layout' }
RTCompositeShape >> alignRight [
	layout := #alignRight
]

{ #category : #accessing }
RTCompositeShape >> allShapes [
	"Return all the shapes contained in me."
	^ shapes collect: #first as: Array
]

{ #category : #accessing }
RTCompositeShape >> colorElement: aOneArgBlock [
	shapes ifEmpty: [ self error: 'You first need to add shape before setting the color' ].
	shapes do: [ :s | s first colorElement: aOneArgBlock ]
]

{ #category : #public }
RTCompositeShape >> edgeFrom: el1 to: el2 [
	^ (RTEdge from: el1 to: el2) addShape: self
]

{ #category : #'public - layout' }
RTCompositeShape >> horizontal [
	layout := #horizontal
]

{ #category : #initialization }
RTCompositeShape >> initialize [
	super initialize.
	shapes := OrderedCollection new.
	layout := #noLayout.
	
	"If one of the shape changes its size, should we relayout. By default no"
	automaticallyUpdateLayout := false
]

{ #category : #public }
RTCompositeShape >> setAutomaticRelayout [
	automaticallyUpdateLayout := true
]

{ #category : #hooks }
RTCompositeShape >> setAutomaticUpdateLayoutIfNecessaryFor: ss and: trachelShape [
	automaticallyUpdateLayout
		ifTrue: [ 
			| b |
			b := TRExtentCallback new
				block: [ :aShape :ratio | 
					trachelShape resetInnerShapes.
					trachelShape perform: layout.
					trachelShape relayout ].
			ss do: [ :tupple | tupple first addCallback: b ] ]
]

{ #category : #public }
RTCompositeShape >> trachelShapeFor: anElement [
"	^ self updateFor: anElement trachelShape: TRMultiCompositeShape new"
	
	| ss trachelShape |
	trachelShape := TRMultiCompositeShape new.
	ss := shapes
		collectWithIndex: [ :tupple :shapeIndex | 
			| s |
			s := tupple first trachelShapeFor: anElement.
			Array with: s with: tupple second ].
	trachelShape setShapes: ss.
	trachelShape perform: layout.
	self setAutomaticUpdateLayoutIfNecessaryFor: ss and: trachelShape.
	^ trachelShape
	

]

{ #category : #hooks }
RTCompositeShape >> updateFor: anElement trachelShape: trachelShape [
	| ss |
	ss := shapes
		collectWithIndex: [ :tupple :shapeIndex | 
			| s |
			tupple first updateFor: anElement trachelShape: (anElement trachelShape shapes at: shapeIndex).
			s := anElement trachelShape shapes at: shapeIndex.
			Array with: s with: tupple second ].
	trachelShape setShapes: ss.
	trachelShape perform: layout.
	self setAutomaticUpdateLayoutIfNecessaryFor: ss and: trachelShape.
	^ trachelShape
	

]

{ #category : #'public - layout' }
RTCompositeShape >> vertical [
	layout := #vertical
]