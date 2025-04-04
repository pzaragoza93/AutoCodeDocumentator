prompts
packageCommentHumanPrompt: aListOfClassSummaries
	"a human prompt for generating a class comment using the class source text as input"

	| prompt |
	prompt := String streamContents: [ :stream |
		          stream
			          nextPutAll:
				          'The following is a set of class summaries of the package which are separated by # ---';
			          cr;
			          nextPutAll: '# Begin class summaries';
			          cr.

		          aListOfClassSummaries do: [ :eachSummary |
			          stream
				          nextPutAll: eachSummary;
				          cr;
				          nextPutAll: '# ---';
				          cr ].

		          stream
			          cr;
			          nextPutAll: '# End class summaries'.
			stream cr; nextPutAll: 'Now write a comment on the package that has these classes while respecting the formating and styling:' ].
	^ prompt