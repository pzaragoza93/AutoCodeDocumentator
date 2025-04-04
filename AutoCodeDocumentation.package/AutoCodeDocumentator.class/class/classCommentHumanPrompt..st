prompts
classCommentHumanPrompt: aClassSourceText
	"a human prompt for generating a class comment using the class source text as input"

	^ 'The following is the class source text, it will be separated by # : \n # Begin source code '
	  , aClassSourceText , ' \n # End Source code'