# pasterrr

This [Alfred](https://www.alfredapp.com) workflow is a paste queue and a 
character-by-character paster in one.

## Usage

The character-by-character paste takes whatever is on the clipboard and pastes
it one character at a time to the frontmost application, giving the impression
 of typing. It can be triggered by the default hotkey ⇧⌃⌘V.

The paste queue is invoked with ⌃⌘V. It splits the content of the clipboard
according to a delimiter (defaults to a blank line), and gives the first entry
to the character-by-character paster. The remainder is copied to the clipboard.

For instance, if the following is on the clipboard:
```
This is the first line.

This is the second.

// This line is skipped.

This is the fourth line.
```
Then pressing ⌃⌘V will paste "This is the first line.". Pressing it again will
 paste "This is the second.", and pressing it a third time will paste 
 "This is the fourth line.".

Note that the workflow does not actually paste, but simulates keypresses. 
Hence non-ASCII characters do not work.

The character-by-character paster will be aborted when pressing a modifier key.
This comes in handy when you accidentally pasted a large amount of text.

The default delimiter is "", and the default skip prefix is "//". Both can be 
changed by adjusting their variables ("delimiter" and "skip_prefix", 
respectively).
