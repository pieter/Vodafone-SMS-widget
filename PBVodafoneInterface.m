//
//  PBVodafoneInterface.m
//  Vodafone
//
//  Created by Pieter de Bie on 11/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PBVodafoneInterface.h"
#import "PBAddressBook.h"

@implementation PBVodafoneInterface

- (id)initWithWebView:(WebView *)webview;
{
	if (!(self = [super init]))
		return nil;
	
	return self;
}

- (void) windowScriptObjectAvailable:(WebScriptObject *)windowScriptObject
{
	[windowScriptObject setValue:[[PBAddressBook alloc] init] forKey:@"AddressBook"];
}
@end
