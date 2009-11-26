all:
	gcc -I. -fobjc-gc -std=gnu99 -framework Cocoa -framework AddressBook test.m PBAddressBook.m -o addressbook_test