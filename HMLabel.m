//
//  HMLabel.m
//  HMLabel
//
//  Created by Hori,Masaki on 10/06/09.
//  Copyright 2010 masakih. All rights reserved.
//

#import "HMLabel.h"

@implementation HMLabel
- (NSArray *)libraryNibNames {
    return [NSArray arrayWithObject:@"HMLabelLibrary"];
}

- (NSArray *)requiredFrameworks {
    return [NSArray arrayWithObjects:[NSBundle bundleWithIdentifier:@"com.masakih.HMLabelFramework"], nil];
}

//- (void)didLoad
- (void)awakeFromNib
{
	[labelControlTemplate setValue:[NSNumber numberWithInteger:1]];
	[labelCellTemplate setValue:[NSNumber numberWithInteger:1]];
}

@end
