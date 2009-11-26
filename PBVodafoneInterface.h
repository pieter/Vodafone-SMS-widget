//
//  PBVodafoneInterface.h
//  Vodafone
//
//  Created by Pieter de Bie on 11/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Webkit/WebKit.h>

@interface PBVodafoneInterface : NSObject {

}

- (id)initWithWebView:(WebView *)webview;
- (void) windowScriptObjectAvailable:(WebScriptObject *)windowScriptObject;
@end
