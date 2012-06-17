//
//  HMLabelDemoAppDelegate.h
//  HMLabelDemo
//
//  Created by Hori,Masaki on 10/05/09.
//  Copyright 2010 masakih. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HMLabelField, HMLabelControl, HMLabelMenuItem;
@interface HMLabelDemoAppDelegate : NSObject <NSApplicationDelegate>
{
    NSWindow *window;
	HMLabelField *labelField;
	HMLabelField *squareLabelField;
	HMLabelControl *labelControl;
	HMLabelControl *squareLabelControl;
	HMLabelMenuItem *labelMenuItem;
	
	NSArray *contents;
	
	NSInteger labelValue;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet HMLabelField *labelField;
@property (assign) IBOutlet HMLabelField *squareLabelField;
@property (assign) IBOutlet HMLabelControl *labelControl;
@property (assign) IBOutlet HMLabelControl *squareLabelControl;
@property (assign) IBOutlet HMLabelMenuItem *labelMenuItem;
@property NSInteger labelValue;


- (IBAction)changeLabel:(id)sender;


@end
