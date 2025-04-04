as yet unclassified
generatePackageCommentFromExistingCommentsAndOutgoingReferences

	| api result comments classes aPackageName |
	"generate summaries for all classes defined within the "
	classes := packageToBeAnalyzed reject: [ :aClass |
		           aClass isStub or: [ aClass name beginsWith: 'Manifest' ] ].
	aPackageName := selectedPackages first.

	('Currently handling package ' , aPackageName , '\n') record.

	comments := classes collect: [ :eachClass |
		            | comment outgoingRefs |
		            eachClass comments
			            ifEmpty: [
			            eachClass name
			            , ': No comment or summary found for this class.' ]
			            ifNotEmpty: [
				            comment := eachClass name , ' : '
				                       , eachClass comments first sourceText ].

		            outgoingRefs := String crlf join:
			                            ((eachClass methods flatCollect: [
				                              :method | method outgoingReferences ])
				                             collect: [ :ref |
				                             ref referencer name , ' -> '
				                             , ref referredType name ]).
		            comment , String crlf
		            ,
		            'This class'' methods have outgoing references towards these classes (the package collaborators:'
		            , String crlf , outgoingRefs ].

	api := AutoCodeDocumentator api.

	api payload
		temperature: 0.1;
		model: 'mistral-small-latest';
		top_p: 1;
		max_tokens: 10000;
		messages: {
				(LLMAPIChatObjectMessage
					 role: 'system'
					 content: self class packageCommentSystemPrompt).
				(LLMAPIChatObjectMessage
					 role: 'user'
					 content:
						 (self class
							  packageCommentHumanPrompt: comments
							  for: aPackageName)) }.

	result := api performRequest.
	('Done generating Package summary: ' , result , '\n') record.
	^ result