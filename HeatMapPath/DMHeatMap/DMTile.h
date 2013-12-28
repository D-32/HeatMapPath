//
//  DMTile.h
//  HeatMapPath
//
//  Created by Dylan Marriott on 12/14/13.
//  Copyright (c) 2013 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DMTile <NSObject>

/**
 *  Returns the cost of this tile.
 *  Return values < 0 indicate that the tile is not walkable.
 *  The calculation for the path is done backwards!
 *
 *  @param sourceTile the previous tile (backwards), this can be used to determine the direction
 *
 *  @return cost
 */
- (int)costFromSource:(id<DMTile>)sourceTile;

@end
