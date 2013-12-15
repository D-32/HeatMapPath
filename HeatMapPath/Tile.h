//
//  Tile.h
//  HeatMapPath
//
//  Created by Dylan Marriott on 12/14/13.
//  Copyright (c) 2013 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMTile.h"

@interface Tile : NSObject <DMTile>

@property (nonatomic) int cost;

@end
