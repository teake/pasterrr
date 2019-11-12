use AppleScript version "2.4" -- The ability to use ASObjC in running scripts was introduced in Mac OS 10.10.
use framework "Foundation"
use framework "AppKit" -- NSEvent is an AppKit class.
use scripting additions

on run argv
	set theQuery to item 1 of argv
	set paragraphList to paragraphs of theQuery
	set paragraphCount to count of paragraphList
	repeat with i from 1 to paragraphCount
		repeat with char in characters of item i of paragraphList
			my keystrokeWithDelay(char)
		end repeat
		if i is not paragraphCount then
			my keystrokeWithDelay(return)
		end if
	end repeat
end run


on keystrokeWithDelay(char)
	if my isModifierKeyDown() then
		error "Aborted because modifier key press detected." number -128
	end if
	tell application "System Events"
		keystroke char
	end tell
	set delayAverage to (system attribute "delay_average") as number
	set delayVariation to (system attribute "delay_variation") as number
	delay (delayAverage + (random number from 0.0 to delayVariation) - (delayVariation / 2))
end keystrokeWithDelay

on isModifierKeyDown()
	set mf to current application's class "NSEvent"'s modifierFlags()
	return (mf div 524288 mod 2 is 1) or (mf div 1048576 mod 2 is 1) or (mf div 131072 mod 2 is 1) or (mf div 262144 mod 2 is 1)
end isModifierKeyDown