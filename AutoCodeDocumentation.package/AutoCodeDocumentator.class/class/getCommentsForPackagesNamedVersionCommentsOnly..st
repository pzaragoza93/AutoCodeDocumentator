analyzing
getCommentsForPackagesNamedVersionCommentsOnly: aListOfPackageNames
	"get list of classes, a generated comment and the original comment for each package name"

	| packagesCommentAssoc result count |
	packagesCommentAssoc := self getPackagesWithComments:
		                        aListOfPackageNames.
	count := 0.
	result := packagesCommentAssoc collect: [ :assoc |
		          | generatedPackageComment packageClassNames final_assoc |
		          packageClassNames := assoc key classes collect: [ :class |
			                               class name ].
		          "1 halt."
		          ('Generating package comment ' , count asString) record.
		          count := count + 1.
		          generatedPackageComment := self new
			
			                                     generateMooseModelOfPackageNamed:
				                                     assoc key name;
			
				                                     generatePackageCommentFromExistingComments.
		          final_assoc := assoc key -> {
			                         assoc value.
			                         generatedPackageComment.
			                         packageClassNames }.
		          self
			          saveResultAsJson: final_assoc
			          inFolder: 'existing_comments_generation'.
		          final_assoc ].
	^ 'done'