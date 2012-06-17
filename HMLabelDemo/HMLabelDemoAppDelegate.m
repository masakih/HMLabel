//
//  HMLabelDemoAppDelegate.m
//  HMLabelDemo
//
//  Created by Hori,Masaki on 10/05/09.
//  Copyright 2012 masakih. All rights reserved.
//

#import "HMLabelDemoAppDelegate.h"

#import "HMLabelField.h"
#import "HMLabelCell.h"


@implementation HMLabelDemoAppDelegate

@synthesize window;
@synthesize labelField;
@synthesize squareLabelField;
@synthesize labelControl;
@synthesize squareLabelControl;
@synthesize labelMenuItem;
@synthesize labelValue;

static NSString *DemoLabel = @"label";
static NSString *DemoName = @"name";

+ (NSSet *)keyPathsForValuesAffectingLabelColor
{
	return [NSSet setWithObject:@"labelValue"];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	
	[self willChangeValueForKey:@"contents"];
	contents = [NSArray arrayWithObjects:
				[NSDictionary dictionaryWithObjectsAndKeys:
				 [NSNumber numberWithInteger:0], DemoLabel,
				 @"Label None", DemoName, nil],
				[NSDictionary dictionaryWithObjectsAndKeys:
				 [NSNumber numberWithInteger:1], DemoLabel,
				 @"Label One", DemoName, nil],
				[NSDictionary dictionaryWithObjectsAndKeys:
				 [NSNumber numberWithInteger:2], DemoLabel,
				 @"Label Tow", DemoName, nil],
				[NSDictionary dictionaryWithObjectsAndKeys:
				 [NSNumber numberWithInteger:3], DemoLabel,
				 @"Label Three", DemoName, nil],
				[NSDictionary dictionaryWithObjectsAndKeys:
				 [NSNumber numberWithInteger:4], DemoLabel,
				 @"Label Four", DemoName, nil],
				[NSDictionary dictionaryWithObjectsAndKeys:
				 [NSNumber numberWithInteger:5], DemoLabel,
				 @"Label Five", DemoName, nil],
				[NSDictionary dictionaryWithObjectsAndKeys:
				 [NSNumber numberWithInteger:6], DemoLabel,
				 @"Label Six", DemoName, nil],
				[NSDictionary dictionaryWithObjectsAndKeys:
				 [NSNumber numberWithInteger:7], DemoLabel,
				 @"Label Seven", DemoName, nil],
				nil];
	[contents retain];
	[self didChangeValueForKey:@"contents"];
}

- (void)awakeFromNib
{
	[labelField setDrawX:YES];
	[labelField bind:@"value" toObject:self withKeyPath:@"labelValue" options:nil];
	
	[squareLabelField setDrawX:YES];
	[squareLabelField setLabelStyle:HMSquareStyle];
	[squareLabelField bind:@"value" toObject:self withKeyPath:@"labelValue" options:nil];
	
	[squareLabelControl setLabelStyle:HMSquareStyle];
	[squareLabelControl bind:@"value" toObject:self withKeyPath:@"labelValue" options:nil];
	[labelControl bind:@"value" toObject:self withKeyPath:@"labelValue" options:nil];
}

- (IBAction)changeLabel:(id)sender
{
	[self setValue:[sender objectValue] forKey:@"labelValue"];
}

- (void)setLabelValue:(NSInteger)newValue
{
	labelValue = newValue;
	[labelMenuItem setIntegerValue:newValue];
}

- (NSColor *)labelColor
{
	if(labelValue == 0) {
		return [NSColor blackColor];
	}
	return [NSColor whiteColor];
}

@end
