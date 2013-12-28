//
//  DMHeatMap.m
//  HeatMapPath
//
//  Created by Dylan Marriott on 08.12.13.
//  Copyright (c) 2013 Dylan Marriott. All rights reserved.
//

#import "DMHeatMap.h"
#import "DMTile.h"
#import "DMInternalTile.h"
#import "NSMutableArray+NSMutableArray_DMAddition.h"

@interface DMHeatMap () {
    NSUInteger _width;
    NSUInteger _height;
    NSMutableArray* _queue;
}
@end

@implementation DMHeatMap

#pragma mark - Public
- (void)generate {
    // check map
    if (self.map.count == 0) {
        assert(@"map has to contain more than one row");
    }
    
    _height = self.map.count;
    _width = [[self.map objectAtIndex:0] count];
    
    if (self.target.x < 0 || self.target.x <= _width) {
        assert(@"target.x isn't inside map");
    }
    if (self.target.y < 0 || self.target.y <= _height) {
        assert(@"target.y isn't inside map");
    }
    
    int x = 0;
    int y = 0;
    for (NSArray* row in self.map) {
        for (DMInternalTile* tile in row) {
            tile.distance = 0;
            tile.position = CGPointMake(x, y);
            x++;
        }
        x = 0;
        y++;
    }
    
    _queue = [[NSMutableArray alloc] init];
    
    DMInternalTile* tile = [self tileAtPoint:self.target];
    tile.distance = -1;
    [_queue addObject:[NSValue valueWithCGPoint:self.target]];
    [self process];
}

- (NSArray *)points:(CGPoint)start {
    CGPoint next = start;
    NSMutableArray* points = [[NSMutableArray alloc] init];
    
    DMInternalTile* winner;
    while (winner.distance != -1) {
        NSMutableArray* neighbors = [[NSMutableArray alloc] init];
        [neighbors addObjectIfNotNil:[self tileAtPoint:CGPointMake(next.x, next.y - 1)]];
        [neighbors addObjectIfNotNil:[self tileAtPoint:CGPointMake(next.x + 1, next.y)]];
        [neighbors addObjectIfNotNil:[self tileAtPoint:CGPointMake(next.x, next.y + 1)]];
        [neighbors addObjectIfNotNil:[self tileAtPoint:CGPointMake(next.x - 1, next.y)]];
        winner = [self nextTile:(NSArray *)neighbors];
        [points addObject:winner.orgTile];
        next = winner.position;
    }
    
    return points;
}

- (int)distanceForPoint:(CGPoint)point {
    DMInternalTile* tile = [self tileAtPoint:point];
    return tile.distance;
}

- (void)setMap:(NSArray *)map {
    NSMutableArray* newMap = [[NSMutableArray alloc] init];
    for (NSArray* line in map) {
        NSMutableArray* newLine = [[NSMutableArray alloc] init];
        for (id<DMTile> tile in line) {
            DMInternalTile* newTile = [[DMInternalTile alloc] init];
            newTile.orgTile = tile;
            [newLine addObject:newTile];
        }
        [newMap addObject:newLine];
    }
    _map = newMap;
}

#pragma mark - Private

- (void)process {
    NSValue* nextValue = [_queue firstObject];
    CGPoint next = nextValue.CGPointValue;
    
    [_queue addObjectsFromArray:[self neighbors:next]];
    
    [_queue removeObjectAtIndex:0];
    if (_queue.count > 0) {
        [self process];
    }
}

- (NSArray *)neighbors:(CGPoint)point {
    NSMutableArray* neighbors = [[NSMutableArray alloc] init];
    
    DMInternalTile* source = [self tileAtPoint:point];
    
    [self addToNeighbors:neighbors point:CGPointMake(point.x, point.y - 1) source:source]; // top
    [self addToNeighbors:neighbors point:CGPointMake(point.x + 1, point.y) source:source]; // right
    [self addToNeighbors:neighbors point:CGPointMake(point.x, point.y + 1) source:source]; // bottom
    [self addToNeighbors:neighbors point:CGPointMake(point.x - 1, point.y) source:source]; // left
    
    return neighbors;
}

-(void)addToNeighbors:(NSMutableArray *)neighbors point:(CGPoint)point source:(DMInternalTile *)source {
    if (![self isPointInsideMap:point]) {
        return;
    }
    DMInternalTile* tile = [[self.map objectAtIndex:point.y] objectAtIndex:point.x];
    int cost = [tile.orgTile costFromSource:source.orgTile];
    if (tile.distance == 0 && cost > 0) {
        tile.distance = source.distance + cost + 1;
        [neighbors addObject:[NSValue valueWithCGPoint:point]];
    }
}

- (DMInternalTile *)nextTile:(NSArray *)tiles {
    DMInternalTile* winner;
    int topDistance = INT_MAX;
    for (DMInternalTile* tile in tiles) {
        if (tile.distance == 0) {
            tile.distance = INT_MAX;
        }
        
        if (tile.distance == -1) {
            winner = tile;
            break;
        } else {
            if (tile.distance < topDistance) {
                winner = tile;
                topDistance = tile.distance;
            }
        }
    }
    if (winner == nil) {
        winner = tiles.firstObject;
    }
    return winner;
}

- (BOOL)isPointInsideMap:(CGPoint)point {
    BOOL ret;
    
    if (point.x < 0 || point.x >= _width) {
        ret = NO;
    } else if (point.y < 0 || point.y >= _height) {
        ret = NO;
    } else {
        ret = YES;
    }
    
    return ret;
}

- (DMInternalTile *)tileAtPoint:(CGPoint)point {
    if (point.x < 0 || point.x >= _width) {
        return nil;
    } else if (point.y < 0 || point.y >= _height) {
        return nil;
    }
    
    return [[self.map objectAtIndex:point.y] objectAtIndex:point.x];
}

@end
