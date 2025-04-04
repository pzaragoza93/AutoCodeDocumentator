as yet unclassified
generateSummaryForClass: classSourceText
	"generate a summary of what a class does using an LLM"

	| api result comment |
	"generate a comment to reduce increase quality of the result."
	'Generating comment.' record.
	comment := self generateCommentForClass: classSourceText.
	'Done generating comment.' record.

	api := AutoCodeDocumentator api.

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
					 content: (self class classCommentHumanPrompt: comment)) }.
	'Generating summary.' record.
	result := api performRequest. 
	'Done generating summary.' record.
	^ result