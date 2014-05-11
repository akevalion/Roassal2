Extension { #name : #CompiledMethod }

{ #category : #'*roassal2' }
CompiledMethod >> ageInDays [

	^ (DateAndTime now - self date) asDays
]

{ #category : #'*roassal2' }
CompiledMethod >> ageInDaysRounded [
	^ self ageInDays rounded
]

{ #category : #'*roassal2' }
CompiledMethod >> computeDate [
	"Return the DateAndTime associated to this method"
	| s nbOfSpaces |
	s := self timeStamp.
	nbOfSpaces := s select: [ :c | c = $  ].
	nbOfSpaces size = 1
		ifTrue: [ ^ DateAndTime fromString: s ].

	nbOfSpaces size = 2
		ifTrue: [ ^ DateAndTime fromString: (s copyAfter: $ ) ].
]

{ #category : #'*roassal2' }
CompiledMethod >> date [
	"Return the DateAndTime associated to me"
	^ (self properties includesKey: #date)
		ifTrue: [ self properties at: #date ]
		ifFalse: [ 
			| m |
			m := self computeDate.
			self properties at: #date put: m.
			m ]
]

{ #category : #'*roassal2' }
CompiledMethod >> dateSinceEpoch [
	^ self date - DateAndTime dosEpoch
]

{ #category : #'*roassal2' }
CompiledMethod >> livingInDays [

	^ (DateAndTime now - self date) asDays
]