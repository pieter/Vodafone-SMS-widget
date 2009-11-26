all:
	gcc -fobjc-gc -std=gnu99 -framework Cocoa -framework AddressBook test.m -o addressbook_test