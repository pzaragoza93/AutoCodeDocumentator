as yet unclassified
packageStats

	| packagesWithComment packages classes methods filteredPkgsWithComments pkgPlot classesWithComments classesPlot methodsWithComments methodsPlot |
	"stats on packages"
	packagesWithComment := (Object packageOrganizer packages collect: [
		                        :pkg |
		                        | manifestClass |
		                        manifestClass := pkg classes
			                                         detect: [ :aClass |
			                                         aClass name beginsWith:
				                                         'Manifest' ]
			                                         ifNone: [ nil ].
		                        manifestClass
			                        ifNil: [ nil ]
			                        ifNotNil: [
			                        pkg -> manifestClass class comment ] ])
		                       reject: #isNil.

	filteredPkgsWithComments := packagesWithComment reject: [
		                            :pkgWithComment |
		                            pkgWithComment value size = 135 or: [
			                            pkgWithComment value size = 260 or: [
				                            pkgWithComment value size = 0 ] ] ].
	(packagesWithComment collect: [ :pkgWithComment |
		 pkgWithComment value size ]) sort: [ :a :b | a > b ].
	pkgPlot := RSHistogramPlot
		           of: filteredPkgsWithComments
		           on: [ :pkgWithComment | pkgWithComment value size ].
	pkgPlot bins: (0 to: 1000 by: 1).
	pkgPlot show.

	"stats on classes"
	classes := Object packageOrganizer packages flatCollect: #classes.
	classesWithComments := classes select: [ :cl | cl comment size > 0 ].
	classesPlot := RSHistogramPlot
		               of: classes
		               on: [ :class | class comment size ].
	classesPlot bins: (0 to: 1000 by: 1).
	classesPlot show.

	"stats on methods"
	methods := classes flatCollect: #methods.
	methodsWithComments := methods reject: [ :method |
		                       method comment isNil ].
	methodsPlot := RSHistogramPlot
		               of: methodsWithComments
		               on: [ :method | method comment size ].
	methodsPlot bins: (0 to: 1000 by: 1).
	methodsPlot show