//
//  DMInternalTile.h
//  TrafficJam
//
//  Created by Dylan Marriott on 28.12.13.
//  Copyright (c) 2013 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMTile.h"

@interface DMInternalTile : NSObject

@property (nonatomic) int distance;
@property (nonatomic) CGPoint position;
@property (nonatomic) id<DMTile> orgTile;

@end
