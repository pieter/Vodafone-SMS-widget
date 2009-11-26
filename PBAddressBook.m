#import <PBAddressBook.h>
#import <AddressBook/ABAddressBook.h>
#import <AddressBook/ABPerson.h>
#import <AddressBook/ABSearchElement.h>
#import <AddressBook/ABMultiValue.h>

@interface PBAddressBook ()
+ (NSArray *)numbersOfPeople:(NSArray *)people;
+ (NSString *)fullNameForPerson:(ABPerson *)person;
+ (NSString *)cleanNumber:(NSString *)phoneNumber;
@end


@implementation PBAddressBook

+ (NSString *)fullNameForPerson:(ABPerson *)person
{
	NSString *first = [person valueForProperty:kABFirstNameProperty];
	NSString *last = [person valueForProperty:kABLastNameProperty];
	if (!first)
		return last;
	if (!last)
		return first;

	return [NSString stringWithFormat:@"%@ %@", first, last];
}

+ (NSString *)cleanNumber:(NSString *)phoneNumber
{
	NSMutableString *n = [NSMutableString string];
	NSScanner *scanner = [NSScanner scannerWithString:phoneNumber];
	NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789+"];
	[scanner scanUpToCharactersFromSet:set intoString:NULL];
	NSString *cur = NULL;
	while ([scanner scanCharactersFromSet:set intoString:&cur]) {
		[n appendString:cur];
		[scanner scanUpToCharactersFromSet:set intoString:NULL];
	}
	[n replaceOccurrencesOfString:@"+" withString:@"00" options:NSLiteralSearch range:NSMakeRange(0, [n length])];
	[n replaceOccurrencesOfString:@"0031" withString:@"0" options:NSLiteralSearch range:NSMakeRange(0, [n length])];
	return n;
}

+ (NSArray *)numbersOfPeople:(NSArray *)people
{
	NSMutableArray *newPeople = [NSMutableArray array];

	for (ABPerson *person in people) {
		NSString *name = [self fullNameForPerson:person];
		if (!name)
			name = [person valueForProperty:kABOrganizationProperty];
		if (!name) // Don't add people that don't have a name or organization
				continue;

		ABMultiValue *phoneNumbers = [person valueForProperty:kABPhoneProperty];
		for (size_t i = 0; i < [phoneNumbers count]; i++) {
			NSString *phoneNumber = [self cleanNumber:[phoneNumbers valueAtIndex:i]];
			NSString *label = [phoneNumbers labelAtIndex:i];

			if ([phoneNumber hasPrefix:@"06"] && [phoneNumber length] == 10) {
				[newPeople addObject:[NSArray arrayWithObjects:name, label, phoneNumber, nil]];
			}
		}
	}

	return newPeople;
}

+ (NSArray *)numbers
{
	ABSearchElement *phoneProperty = [ABPerson searchElementForProperty:kABPhoneProperty
		label:nil
		key:nil
		value:@"6"
		comparison:kABContainsSubString];

	ABAddressBook *AB = [ABAddressBook sharedAddressBook];
	NSArray *peopleFound = [AB recordsMatchingSearchElement:phoneProperty];

	return [self numbersOfPeople:peopleFound];
}
@end