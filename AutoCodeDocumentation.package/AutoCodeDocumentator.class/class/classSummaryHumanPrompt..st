prompts
classSummaryHumanPrompt: comment

	^ 'The following is the class comment, it will be separated by # : \n # Begin source code '
	  , comment , '\n # end class comment. \n Write a summary of what this class does. Do not write a list of methods.'