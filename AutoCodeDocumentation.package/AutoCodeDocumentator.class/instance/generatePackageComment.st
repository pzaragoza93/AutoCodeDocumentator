as yet unclassified
generatePackageComment

	| api result summaries classes aPackageName |
	"generate summaries for all classes defined within the "
	classes := packageToBeAnalyzed reject: [ :aClass |
		           aClass isStub or: [ aClass name beginsWith: 'Manifest' ] ].
	aPackageName := selectedPackages first.
	"results := OrderedCollection new: classes size.
	semaphore := Semaphore new.
	counter := classes size."

	('Currently generating summaries for classes : '
	 , (', ' join: (classes collect: #name)) , '\n') record.
	"classes do: [ :eachClass |
		[ self generateSummaryForClass: eachClass sourceText ] future
			onSuccessDo: [ :classResult |
				results add: classResult.
				counter := counter - 1.
				('Done with summary for ' , eachClass name , ' : ' , counter
				 , '\n') record.
				counter = 0 ifTrue: [ semaphore signal ] ] ]."
	summaries := classes collect: [ :eachClass |
		             self generateSummaryForClass: eachClass sourceText ].

	"Block until all succeed"
	"semaphore wait.
	summaries := results collect: #value."

	"record to logs"
	('Done generating summaries for classes : '
	 , (', ' join: (classes collect: #name)) , '\n') record.

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
							  packageCommentHumanPrompt: summaries
							  for: aPackageName)) }.

	result := api performRequest.
	('Done generating Package summary: ' , result , '\n') record.
	^ result