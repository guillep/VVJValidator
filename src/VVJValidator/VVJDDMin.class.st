"
```smalltalk
jar := FileLocator home / 'git/VerveineJ/app/build/libs/VerveineJ-Snapshot.jar'.
minResult := VVJDDMin new
	jar: jar;
	run: ccFiles
	asserting: [ :loader :model | | mu as |
		""The model is ok if...""
		mu := model entityNamed: 'org.apache.commons.collections.MapUtils'.
		as := model entityNamed: 'org.apache.commons.collections.ArrayStack.ArrayStack(int)'.
		""A model is ok if the problematic entities are not there""
		as isNil or: [ mu isNil or: [ as isStub or: [
			""But if they are there, then ArrayStack should have 2 incoming invocations!""
				as incomingInvocations size = 2] ] ]
].
```
"
Class {
	#name : 'VVJDDMin',
	#superclass : 'VVJHandlerClass',
	#category : 'VVJValidator',
	#package : 'VVJValidator'
}

{ #category : 'as yet unclassified' }
VVJDDMin >> run: files asserting: aBlock [

	| ddmin |
	ddmin := AnonymousDDMin testing: [ :vvjInputFiles |	
		| shuffled loader model |
		shuffled := vvjInputFiles shuffle.
		loader := VVJLoader new
			jar: jar;
			paths: files.
		model := loader load.
		aBlock value: loader value: model. 
	].
	^ ddmin reduce: files
]
