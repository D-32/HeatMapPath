//
//  Particle.m
//  HeatMapPath
//
//  Created by Dylan Marriott on 12/15/13.
//  Copyright (c) 2013 Dylan Marriott. All rights reserved.
//

#import "Particle.h"

@implementation Particle

- (NSString *)description {
    return [NSString stringWithFormat:@"speed = %f, %@", self.speed, [super description]];
}

@end
