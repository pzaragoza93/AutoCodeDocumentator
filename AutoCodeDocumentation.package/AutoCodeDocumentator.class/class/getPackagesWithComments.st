analyzing
getPackagesWithComments
	"comment stating purpose of class-side method"

	^ (Object packageOrganizer packages collect: [ :pkg |
		   | manifestClass |
		   manifestClass := pkg classes
			                    detect: [ :aClass |
			                    aClass name beginsWith: 'Manifest' ]
			                    ifNone: [ nil ].
		   manifestClass
			   ifNil: [ nil ]
			   ifNotNil: [ pkg -> manifestClass class comment ] ]) reject:
		  #isNil