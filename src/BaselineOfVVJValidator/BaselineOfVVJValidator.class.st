Class {
	#name : 'BaselineOfVVJValidator',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfVVJValidator',
	#package : 'BaselineOfVVJValidator'
}

{ #category : 'baselines' }
BaselineOfVVJValidator >> baseline: spec [

	<baseline>
	spec baseline: 'DDMin' with: [
			spec repository:
				'github://Alamvic/DDmin' ].

	spec baseline: 'OSSubprocess' with: [
			spec repository:
				'github://pharo-contributions/OSSubprocess:v2.0.1/repository' ].

	spec package: #VVJLoader with: [ 
		spec requires: #( OSSubprocess DDMin ) ]
]
