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
 *  Distance, can be used to draw the heatmap, otherwise only used internaly.
 */
@property (nonatomic) int distance;

/**
 *  Position of the tile, used internaly.
 */
@property (nonatomic) CGPoint position;

/**
 *  Returns the cost of this tile.
 *  Return values < 0 indicate that the tile is not walkable.
 *
 *  @param sourceTile the previous tile, this can be used to determine the direction
 *
 *  @return cost
 */
- (int)costFromSource:(id<DMTile>)sourceTile;

@end
