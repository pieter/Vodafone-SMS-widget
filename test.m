#import <Cocoa/Cocoa.h>
#import <AddressBook/ABAddressBook.h>
#import <AddressBook/ABPerson.h>
#import <AddressBook/ABSearchElement.h>
#import <AddressBook/ABMultiValue.h>
ABSearchElement *elementForName(NSString *name)
{
	ABSearchElement *firstName = [ABPerson searchElementForProperty:kABFirstNameProperty
		label:nil
		key:nil
		value:name
		comparison:kABContainsSubString];

	ABSearchElement *lastProperty = [ABPerson searchElementForProperty:kABLastNameProperty
		label:nil
		key:nil
		value:name
		comparison:kABContainsSubString];

	ABSearchElement *nameProperty = [ABSearchElement searchElementForConjunction:kABSearchOr
		children:[NSArray arrayWithObjects:firstName, lastProperty, nil]];

	return nameProperty;
}

int main (int argc, char const *argv[])
{
	if (argc < 2) {
		printf("Usage: %s <name>\n", argv[0]);
		exit(1);
	}

	ABAddressBook *AB = [ABAddressBook sharedAddressBook];

	ABSearchElement *search = elementForName([NSString stringWithUTF8String:argv[1]]);
	NSArray *peopleFound = [AB recordsMatchingSearchElement:search];

	for (ABPerson *person in peopleFound) {
		ABMultiValue *phone = [person valueForProperty:kABPhoneProperty];
		for (size_t i = 0; i < [phone count]; i++) {
			NSString *identifier = [phone identifierAtIndex:i];
			id value = [phone valueAtIndex:i];
			NSString *label = [phone labelAtIndex:i];
			printf("%s -- %s (%s)\n", [[person valueForProperty:kABFirstNameProperty] UTF8String], [value UTF8String], [label UTF8String]);
		}
		// NSLog(@"Phone: %@", [phone primaryIdentifier]);
	}
	// NSLog(@"Persons: %@", peopleFound);

	return 0;
}