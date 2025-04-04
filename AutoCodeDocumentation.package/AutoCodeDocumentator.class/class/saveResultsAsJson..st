analyzing
saveResultsAsJson: aList
	"comment stating purpose of class-side method"

	| json filePath jsonString stringedList|
	stringedList := aList collect: [ :eachAssoc | (eachAssoc key name) -> (eachAssoc value)   ].
	json := stringedList asDictionary. "Convert association list to a Dictionary"
	jsonString := NeoJSONWriter toString: json. "Encode to JSON string"

	filePath := FileLocator downloads / 'myData.json'.
	filePath writeStreamDo: [ :stream | stream nextPutAll: jsonString ]