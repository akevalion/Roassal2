"
I am interaction which allows view to be zoomed with a mouce wheel.
"
Class {
	#name : #RTZoomableView,
	#superclass : #RTInteraction,
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTZoomableView >> initializeElement: aView [
	aView canvas when: TRMouseWheelEvent do: [ :e |
		| scale dist |
		dist := e position - aView canvas camera position.
		scale := aView canvas camera scale.
		e direction = #up ifTrue: [ scale := scale * 1.25. dist := dist * 0.2 ].
		e direction = #down ifTrue: [ scale := scale * 0.8. dist := dist * 0.25 negated ].
		aView canvas camera scale: scale.
		aView canvas camera translateBy: dist.
		
		
		aView signalUpdate ]
]