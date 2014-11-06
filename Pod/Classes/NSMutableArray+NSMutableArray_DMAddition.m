//
//  NSMutableArray+NSMutableArray_DMAddition.m
//  HeatMapPath
//
//  Created by Dylan Marriott on 12/15/13.
//  Copyright (c) 2013 Dylan Marriott. All rights reserved.
//

#import "NSMutableArray+NSMutableArray_DMAddition.h"

@implementation NSMutableArray (NSMutableArray_DMAddition)

- (void)addObjectIfNotNil:(id)anObject {
    if (anObject != nil) {
        [self addObject:anObject];
    }
}

@end
