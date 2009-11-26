#import <Cocoa/Cocoa.h>
#import <PBAddressBook.h>

int main (int argc, char const *argv[])
{
	if (argc < 2) {
		printf("Usage: %s <name>\n", argv[0]);
		exit(1);
	}

	NSArray *peopleFound = [[[PBAddressBook alloc] init] numbers];
	for (NSArray *n in peopleFound)
		printf("%s -- %s (%s)\n", [[n objectAtIndex:0] UTF8String], [[n objectAtIndex:2] UTF8String], [[n objectAtIndex:1] UTF8String]);
	
	// NSLog(@"Persons: %@", peopleFound);

	return 0;
}