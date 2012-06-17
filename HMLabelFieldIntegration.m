//
//  HMLabelField.m
//  HMLabel
//
//  Created by Hori,Masaki on 10/06/09.
//  Copyright 2010 masakih. All rights reserved.
//

#import <InterfaceBuilderKit/InterfaceBuilderKit.h>
#import <HMLabel/HMLabelField.h>
#import <HMLabel/HMLabelControl.h>
#import <HMLabel/HMLabelCell.h>
#import <HMLabel/HMLabelMenuItem.h>
#import "HMLabelInspector.h"

@interface HMLabelField (HMIBPrivate)
- (NSSize)minimumSize;
@end


@implementation HMLabelField (HMLabel)

- (void)ibPopulateKeyPaths:(NSMutableDictionary *)keyPaths {
    [super ibPopulateKeyPaths:keyPaths];
	
	// Remove the comments and replace "MyFirstProperty" and "MySecondProperty" 
	// in the following line with a list of your view's KVC-compliant properties.
    [[keyPaths objectForKey:IBAttributeKeyPaths] addObjectsFromArray:[NSArray arrayWithObjects:@"value", @"labelStyle", @"drawX", nil]];
}

- (void)ibPopulateAttributeInspectorClasses:(NSMutableArray *)classes {
    [super ibPopulateAttributeInspectorClasses:classes];
    [classes addObject:[HMLabelInspector class]];
}

- (NSSize)ibMinimumSize
{
	return [self minimumSize];
}
- (NSSize)ibMaximumSize
{
	NSSize size = [self minimumSize];
	size.width = 100000;
	return size;
}
@end

@implementation HMLabelControl (HMLabel)

- (void)ibPopulateKeyPaths:(NSMutableDictionary *)keyPaths {
    [super ibPopulateKeyPaths:keyPaths];
	
	// Remove the comments and replace "MyFirstProperty" and "MySecondProperty" 
	// in the following line with a list of your view's KVC-compliant properties.
    [[keyPaths objectForKey:IBAttributeKeyPaths] addObjectsFromArray:[NSArray arrayWithObjects:@"value", @"labelStyle", @"drawX", nil]];
}

- (void)ibPopulateAttributeInspectorClasses:(NSMutableArray *)classes {
    [super ibPopulateAttributeInspectorClasses:classes];
    [classes addObject:[HMLabelInspector class]];
}
@end

@implementation HMLabelCell (HMLabel)

- (void)ibPopulateKeyPaths:(NSMutableDictionary *)keyPaths {
    [super ibPopulateKeyPaths:keyPaths];
	
	// Remove the comments and replace "MyFirstProperty" and "MySecondProperty" 
	// in the following line with a list of your view's KVC-compliant properties.
    [[keyPaths objectForKey:IBAttributeKeyPaths] addObjectsFromArray:[NSArray arrayWithObjects:@"value", @"labelStyle", @"drawX", nil]];
}

- (void)ibPopulateAttributeInspectorClasses:(NSMutableArray *)classes {
    [super ibPopulateAttributeInspectorClasses:classes];
    [classes addObject:[HMLabelInspector class]];
}
@end

