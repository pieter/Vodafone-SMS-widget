#import <Cocoa/Cocoa.h>
#import <PBAddressBook.h>

int main (int argc, char const *argv[])
{
	NSArray *peopleFound = [[[PBAddressBook alloc] init] numbers];
	for (NSArray *n in peopleFound)
		printf("%s -- %s (%s)\n", [[n objectAtIndex:0] UTF8String], [[n objectAtIndex:2] UTF8String], [[n objectAtIndex:1] UTF8String]);

	return 0;
}