//
//  Tile.m
//  HeatMapPath
//
//  Created by Dylan Marriott on 12/14/13.
//  Copyright (c) 2013 Dylan Marriott. All rights reserved.
//

#import "Tile.h"

@implementation Tile

- (id)init {
    self = [super init];
    self.cost = 1;
    return self;
}

- (int)costFromSource:(id<DMTile>)sourceTile {
    return self.cost;
}

@end
