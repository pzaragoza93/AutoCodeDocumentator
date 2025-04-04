as yet unclassified
generateCommentForClass: classSourceText
	"generate a summary of what a class does using an LLM"

	| api result modifiedSourceText |
	api := AutoCodeDocumentator api.
classSourceText size > 10000 ifTrue: [modifiedSourceText := classSourceText copyFrom: 1 to: (10000 min: classSourceText size).] ifFalse: [modifiedSourceText := classSourceText].
	api payload
		temperature: 0.1;
		model: 'mistral-small-latest';
		top_p: 1;
		max_tokens: 10000;
		messages: {
				(LLMAPIChatObjectMessage
					 role: 'system'
					 content: self class classCommentSystemPrompt).
				(LLMAPIChatObjectMessage
					 role: 'user'
					 content: (self class classCommentHumanPrompt: modifiedSourceText)) }. 
	result := api performRequest.
	^ result