Class {
	#name : #RTComposer,
	#superclass : #Object,
	#instVars : [
		'stack',
		'view',
		'gap',
		'mapping'
	],
	#category : #'Roassal2-Builder-Composer'
}

{ #category : #accessing }
RTComposer >> allGroupedElements [
	^ mapping values flatCollect: #yourself
]

{ #category : #accessing }
RTComposer >> currentElements [
	^ view elements 
]

{ #category : #accessing }
RTComposer >> currentElementsAsGroup [
	^ RTGroup withAll: self currentElements
]

{ #category : #accessing }
RTComposer >> gap [
	"Return the space between visualizations"
	^ gap
]

{ #category : #accessing }
RTComposer >> gap: anInteger [
	gap := anInteger
]

{ #category : #'public-layout' }
RTComposer >> group: aName [
	"Compute the group of added objects"
	mapping at: aName put: self newElementsAsGroup 
]

{ #category : #initialization }
RTComposer >> initialize [
	super initialize.
	view := RTView new.
	mapping := Dictionary new.
	gap := 20
]

{ #category : #'public-layout' }
RTComposer >> move: name1 above: name2 [
	
	| g1 g2 |
	g1 := mapping at: name1. 
	g2 := mapping at: name2.
	TRConstraint move: g1 above: g2.
	g1 translateBy: 0 @ gap negated
]

{ #category : #'public-layout' }
RTComposer >> move: name1 below: name2 [
	
	| g1 g2 |
	g1 := mapping at: name1. 
	g2 := mapping at: name2.
	TRConstraint move: g1 below: g2.
	g1 translateBy: 0 @ gap
]

{ #category : #'public-layout' }
RTComposer >> move: name1 onTheLeftOf: name2 [
	
	| g1 g2 |
	g1 := mapping at: name1. 
	g2 := mapping at: name2.
	TRConstraint move: g1 onTheLeftOf: g2.
	g1 translateBy: gap negated @ 0
]

{ #category : #'public-layout' }
RTComposer >> move: name1 onTheRightOf: name2 [
	
	| g1 g2 |
	g1 := mapping at: name1. 
	g2 := mapping at: name2.
	TRConstraint move: g1 onTheRightOf: g2.
	g1 translateBy: gap @ 0
]

{ #category : #'public-naming' }
RTComposer >> nameGroup: aName as: title [
	| lbl |
	lbl := (RTLabel new text: title) element.
	TRConstraint move: lbl above: (mapping at: aName).
	view add: lbl.
	^ lbl
]

{ #category : #accessing }
RTComposer >> newElementsAsGroup [
	^ RTGroup withAll: (view elements copyWithoutAll: self allGroupedElements)
]

{ #category : #'public-layout' }
RTComposer >> open [
	^ view open
]

{ #category : #'public-interaction' }
RTComposer >> propagateHighlight [

	self newElementsAsGroup @ RTHighlightable allSibblings.
]

{ #category : #accessing }
RTComposer >> view [
	^ view
]