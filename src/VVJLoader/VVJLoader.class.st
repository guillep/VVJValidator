Class {
	#name : 'VVJLoader',
	#superclass : 'Object',
	#instVars : [
		'jar',
		'outputFilePath',
		'paths'
	],
	#category : 'VVJLoader',
	#package : 'VVJLoader'
}

{ #category : 'parsing' }
VVJLoader >> import [

	^ outputFilePath readStreamDo: [ :st | FamixJavaModel new importFromJSONStream: st ].
]

{ #category : 'parsing' }
VVJLoader >> initialize [

	super initialize.
	outputFilePath := (FileSystem workingDirectory / ('output-', UUID new asString)) , 'json'
]

{ #category : 'accessing' }
VVJLoader >> jar [

	^ jar
]

{ #category : 'accessing' }
VVJLoader >> jar: anObject [

	jar := anObject
]

{ #category : 'parsing' }
VVJLoader >> load [

	self parse.
	^ self import
]

{ #category : 'accessing' }
VVJLoader >> outputFilePath [

	^ outputFilePath
]

{ #category : 'accessing' }
VVJLoader >> outputFilePath: anObject [

	outputFilePath := anObject
]

{ #category : 'parsing' }
VVJLoader >> parse [

	| err |
	self validate.

	OSSUnixSubprocess new
			command: '/usr/bin/java';
			arguments: {
				'-jar'.
				jar fullName.
				'-format'.
				'json'.
				'-o'.
				outputFilePath fullName.
				'-jdkMode'.
				'-1.7'.
			}, paths;
			redirectStdout;
			redirectStderr;
			runAndWaitPollingEvery: (Delay forMilliseconds: 50)
			retrievingStreams: true onExitDo: [ :command :outString :errString | 
				err := errString ].
			
	err ifNotEmpty: [ 
		self error: 'Errors while parsing: ', err ].
]

{ #category : 'accessing' }
VVJLoader >> paths [

	^ paths
]

{ #category : 'accessing' }
VVJLoader >> paths: anObject [

	paths := anObject
]

{ #category : 'parsing' }
VVJLoader >> validate [
	
	jar asFileReference exists ifFalse: [ 
		self error: 'Missing vvj jar file' ].
]
