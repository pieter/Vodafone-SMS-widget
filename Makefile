.PHONY: widget run

test:
	gcc -I. -fobjc-gc -std=gnu99 -framework Cocoa -framework AddressBook test.m PBAddressBook.m -o addressbook_test

widget:
	rm -rf Vodafone.wdgt
	xcodebuild -configuration Debug
	cp -r widget Vodafone.wdgt
	cp -r build/Debug/Vodafone.widgetplugin vodafone.wdgt/

run: widget
	open Vodafone.wdgt