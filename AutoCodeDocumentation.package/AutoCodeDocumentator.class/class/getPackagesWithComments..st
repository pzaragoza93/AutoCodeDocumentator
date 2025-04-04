analyzing
getPackagesWithComments: aListOfPackageNames
	"retrieves a packages and their comments from a list of package names"

	| packages |
	packages := Object packageOrganizer packages select: [ :pkg |
		            aListOfPackageNames includes: pkg name ].
	^ (packages collect: [ :pkg |
		   | manifestClass |
		   manifestClass := pkg classes
			                    detect: [ :aClass |
			                    aClass name beginsWith: 'Manifest' ]
			                    ifNone: [ nil ].
		   manifestClass
			   ifNil: [ nil ]
			   ifNotNil: [ pkg -> manifestClass class comment ] ]) reject:
		  #isNil