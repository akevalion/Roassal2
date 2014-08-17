Class {
	#name : #RTAxisConfiguration,
	#superclass : #RTObject,
	#instVars : [
		'numberOfTicks',
		'numberOfLabels',
		'labelConvertion',
		'positionLabel',
		'minValue',
		'maxValue',
		'thousandsSeparator',
		'title'
	],
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #configuration }
RTAxisConfiguration >> decimal: anInteger [
	"Set the number of decimals"
	self labelConvertion: [ :number | number asFloat round: anInteger ]
]

{ #category : #action }
RTAxisConfiguration >> getStringFromNumber: aNumber [
	^ (self labelConvertion rtValue: aNumber) asString
]

{ #category : #initialization }
RTAxisConfiguration >> initialize [
	super initialize.
	labelConvertion := [ :number | number asFloat round: 2 ].
	positionLabel := [ :aLabel :aTick | aLabel translateTo: aTick position ].
	numberOfTicks := 4.
	numberOfLabels := numberOfTicks.
	minValue := 0.
	maxValue := 0.
	self twoDecimals.
	self noThousandsSeparator.
	self noTitle
]

{ #category : #accessing }
RTAxisConfiguration >> labelConvertion [
	^ labelConvertion
]

{ #category : #accessing }
RTAxisConfiguration >> labelConvertion: aOneArgBlock [
	"The argument is a one arg block taking the numerical value"
	labelConvertion := aOneArgBlock
]

{ #category : #accessing }
RTAxisConfiguration >> maxValue [
	^ maxValue
]

{ #category : #accessing }
RTAxisConfiguration >> maxValue: aMinValue [
	maxValue := aMinValue
]

{ #category : #accessing }
RTAxisConfiguration >> minValue [
	^ minValue
]

{ #category : #accessing }
RTAxisConfiguration >> minValue: aMinValue [
	minValue := aMinValue
]

{ #category : #action }
RTAxisConfiguration >> moveLabel: label againstTick: aTick [
	positionLabel value: label value: aTick
]

{ #category : #configuration }
RTAxisConfiguration >> noDecimals [
	self labelConvertion: [ :number | number asInteger ]
]

{ #category : #configuration }
RTAxisConfiguration >> noLabels [
	self numberOfLabels: 0
]

{ #category : #configuration }
RTAxisConfiguration >> noThousandsSeparator [
	thousandsSeparator := false
]

{ #category : #configuration }
RTAxisConfiguration >> noTitle [
	self title: ''
]

{ #category : #accessing }
RTAxisConfiguration >> numberOfLabels [
	^ numberOfLabels
]

{ #category : #accessing }
RTAxisConfiguration >> numberOfLabels: aValue [
	numberOfLabels := aValue
]

{ #category : #accessing }
RTAxisConfiguration >> numberOfTicks [
	^ numberOfTicks
]

{ #category : #accessing }
RTAxisConfiguration >> numberOfTicks: aValue [
	numberOfTicks := aValue
]

{ #category : #configuration }
RTAxisConfiguration >> oneDecimal [
	self decimal: 1
]

{ #category : #accessing }
RTAxisConfiguration >> positionLabel [
	^ positionLabel
]

{ #category : #accessing }
RTAxisConfiguration >> positionLabel: aValue [
	positionLabel := aValue
]

{ #category : #accessing }
RTAxisConfiguration >> tickIntervalForLabel [
	^ numberOfTicks / numberOfLabels
]

{ #category : #accessing }
RTAxisConfiguration >> title [
	^ title
]

{ #category : #accessing }
RTAxisConfiguration >> title: aTitleAsString [
	title := aTitleAsString
]

{ #category : #configuration }
RTAxisConfiguration >> twoDecimals [
	self decimal: 2
]

{ #category : #configuration }
RTAxisConfiguration >> withThousandsSeparator [
	self labelConvertion: [ :number | number asInteger asStringWithCommas ] 
]