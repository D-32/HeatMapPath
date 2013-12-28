//
//  DMHeatMap.h
//  HeatMapPath
//
//  Created by Dylan Marriott on 08.12.13.
//  Copyright (c) 2013 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMHeatMap : NSObject

/**
 *  The map. Each object in the map is a row, which is also a NSArray containing an id<DMTile> for each tile.
 */
@property (nonatomic) NSArray* map;

/**
 *  The target that should be used for the generation of the heatmap.
 */
@property (nonatomic) CGPoint target;

/**
 *  Generate the heatmap. This has to be only done once until the target changes.
 *  This is a lengthy operation, but if all objects share the same target it only has to be done once.
 *  The path finding for each object is then done in the method 'points:' which is fast.
 */
- (void)generate;

/**
 *  Get the path to the target.
 *
 *  @param start the starting point
 *
 *  @return list of id<DMTile> where the property 'position' can be used to get the next location. Index 0 should be the next point to move to.
 */
- (NSArray *)points:(CGPoint)start;

/**
 *  Get the distance to the target from a certain point.
 *  Can be used to draw the heatmap.
 *
 *  @param point start point
 *
 *  @return distance to target point
 */
- (int)distanceForPoint:(CGPoint)point;

@end
