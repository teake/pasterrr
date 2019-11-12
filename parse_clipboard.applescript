on run argv
	
	set theQuery to item 1 of argv
	
	set textItemList to splitString(theQuery)
	
	if textItemList is {} then
		return
	end if
	
	set skipPrefix to (system attribute "skip_prefix")
	set firstOk to false
	repeat while not firstOk and textItemList is not {}
		set firstTextItem to trimWhitespace(first item of textItemList)
		set restTextItems to the rest of textItemList
		set textItemList to restTextItems
		set firstOk to (firstTextItem does not start with skipPrefix)
	end repeat
	
	set the clipboard to trimWhitespace(joinToString(restTextItems))
	
	if firstOk then
		set bundleID to (system attribute "alfred_workflow_bundleid")
		tell application id "com.runningwithcrayons.Alfred"
			run trigger "singleItemPaste" in workflow bundleID with argument firstTextItem
		end tell
	end if
	
end run

on splitString(thisString)
	set previousDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to getDelimiter()
	set textItemList to text items of thisString
	set AppleScript's text item delimiters to previousDelimiters
	return textItemList
end splitString

on joinToString(thisList)
	set previousDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to getDelimiter()
	set joinedString to thisList as text
	set AppleScript's text item delimiters to previousDelimiters
	return joinedString
end joinToString

on getDelimiter()
	set prefD to (system attribute "delimiter")
	return {linefeed & prefD & linefeed, return & prefD & return, return & prefD & return, character id 8233 & prefD & character id 8233, character id 8233 & prefD & character id 8233}
end getDelimiter

on trimWhitespace(this_text)
	return trimString(this_text, return & linefeed & character id 8233 & character id 8232 & " ", 2)
end trimWhitespace

on trimString(this_text, trim_chars, trim_indicator)
	-- 0 = beginning, 1 = end, 2 = both
	-- TRIM BEGINNING
	if the trim_indicator is in {0, 2} then
		repeat while the length of this_text > 0 and trim_chars contains character 1 of this_text
			try
				set this_text to characters 2 thru -1 of this_text as string
			on error
				-- the text contains nothing but the trim characters
				return ""
			end try
		end repeat
	end if
	-- TRIM ENDING
	if the trim_indicator is in {1, 2} then
		repeat while the length of this_text > 0 and trim_chars contains character -1 of this_text
			try
				set this_text to characters 1 thru -2 of this_text as string
			on error
				-- the text contains nothing but the trim characters
				return ""
			end try
		end repeat
	end if
	return this_text
end trimString