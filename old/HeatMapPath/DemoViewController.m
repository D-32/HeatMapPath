//
//  DemoViewController.m
//  HeatMapPath
//
//  Created by Dylan Marriott on 12/14/13.
//  Copyright (c) 2013 Dylan Marriott. All rights reserved.
//

#import "DemoViewController.h"
#import "Tile.h"
#import "DMHeatMap.h"
#import "Particle.h"

@implementation DemoViewController {
    NSMutableArray* _map;
    DMHeatMap* _heatmap;
    NSMutableArray* _particles;
    float _tileWidth;
    float _tileHeight;
    
    UIView* _mapsContainer;
    UIView* _particlesContainer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapsContainer = [[UIView alloc] initWithFrame:self.view.frame];
    _particlesContainer = [[UIView alloc] initWithFrame:self.view.frame];
    [_particlesContainer setUserInteractionEnabled:NO];
    [self.view addSubview:_mapsContainer];
    [self.view addSubview:_particlesContainer];
    
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] init];
    [tapRecognizer setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapRecognizer];
    
    _tileWidth = self.view.frame.size.width / 20;
    _tileHeight = self.view.frame.size.height / 32;
    
    _map = [[NSMutableArray alloc] init];
    for (int i = 0; i < 32; i++) {
        NSMutableArray* row = [[NSMutableArray alloc] init];
        
        for (int j = 0; j < 20; j++) {
            Tile* tile = [[Tile alloc] init];
            tile.position = CGPointMake(j, i);
            [row addObject:tile];
        }
        
        [_map addObject:row];
    }
    
    [self tileAtPoint:CGPointMake(0, 15)].cost = -1;
    [self tileAtPoint:CGPointMake(1, 15)].cost = -1;
    [self tileAtPoint:CGPointMake(2, 15)].cost = -1;
    [self tileAtPoint:CGPointMake(3, 15)].cost = -1;
    [self tileAtPoint:CGPointMake(4, 15)].cost = -1;
    [self tileAtPoint:CGPointMake(5, 15)].cost = -1;
    [self tileAtPoint:CGPointMake(6, 15)].cost = -1;
    [self tileAtPoint:CGPointMake(7, 15)].cost = -1;
    [self tileAtPoint:CGPointMake(8, 15)].cost = -1;
    [self tileAtPoint:CGPointMake(9, 15)].cost = -1;

    [self tileAtPoint:CGPointMake(3, 12)].cost = -1;
    [self tileAtPoint:CGPointMake(4, 12)].cost = -1;
    [self tileAtPoint:CGPointMake(5, 12)].cost = -1;
    [self tileAtPoint:CGPointMake(6, 12)].cost = -1;
    [self tileAtPoint:CGPointMake(7, 12)].cost = -1;
    [self tileAtPoint:CGPointMake(8, 12)].cost = -1;
    [self tileAtPoint:CGPointMake(9, 12)].cost = -1;
    [self tileAtPoint:CGPointMake(10, 12)].cost = -1;
    [self tileAtPoint:CGPointMake(11, 12)].cost = -1;
    [self tileAtPoint:CGPointMake(12, 12)].cost = -1;
    [self tileAtPoint:CGPointMake(13, 12)].cost = -1;
    [self tileAtPoint:CGPointMake(14, 12)].cost = -1;
    [self tileAtPoint:CGPointMake(15, 12)].cost = -1;
    [self tileAtPoint:CGPointMake(16, 12)].cost = -1;
    [self tileAtPoint:CGPointMake(17, 12)].cost = -1;
    [self tileAtPoint:CGPointMake(18, 12)].cost = -1;
    [self tileAtPoint:CGPointMake(19, 12)].cost = -1;
    
    [self tileAtPoint:CGPointMake(0, 8)].cost = -1;
    [self tileAtPoint:CGPointMake(1, 8)].cost = -1;
    [self tileAtPoint:CGPointMake(2, 8)].cost = -1;
    [self tileAtPoint:CGPointMake(3, 8)].cost = -1;
    [self tileAtPoint:CGPointMake(4, 8)].cost = -1;
    [self tileAtPoint:CGPointMake(5, 8)].cost = -1;
    [self tileAtPoint:CGPointMake(6, 8)].cost = -1;
    [self tileAtPoint:CGPointMake(7, 8)].cost = -1;
    [self tileAtPoint:CGPointMake(8, 8)].cost = -1;
    [self tileAtPoint:CGPointMake(9, 8)].cost = -1;
    
    _heatmap = [[DMHeatMap alloc] init];
    _heatmap.map = _map;
    
    
    // generate particles
    _particles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 100; i++) {
        Particle* particle = [[Particle alloc] initWithFrame:CGRectMake(0, 0, 2, 2)];
        particle.backgroundColor = [UIColor blueColor];
        particle.speed = 0.2 + (i / 100.0f);
        [_particlesContainer addSubview:particle];
        [_particles addObject:particle];
    }
    
    
    [self drawMap:CGPointMake(10, 17)];
}

- (void)drawMap:(CGPoint)target {
    for (UIView* v in [_mapsContainer subviews]) {
        [v removeFromSuperview];
    }
    
    _heatmap.target = target;
    [_heatmap generate];
    
    int x;
    int y = 0;
    for (NSArray* row in _map) {
        x = 0;
        for (Tile* tile in row) {
            int distance = [_heatmap distanceForPoint:tile.position];
            
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(x * _tileWidth, y * _tileHeight, _tileWidth, _tileHeight)];
            view.backgroundColor = [UIColor colorWithWhite:distance / 120.0f alpha:1.0];
            if (tile.cost == -1) {
                view.backgroundColor = [UIColor redColor];
            }
            if (distance == -1) {
                view.backgroundColor = [UIColor yellowColor];
            }
            [_mapsContainer addSubview:view];
            
            x++;
        }
        y++;
    }
    
    [self updateParticlesPath];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [[event allTouches] anyObject];
    [self drawMap:CGPointMake(touch.view.frame.origin.x / _tileWidth, touch.view.frame.origin.y / _tileHeight)];
}

- (void)updateParticlesPath {
    for (Particle* particle in _particles) {
        int x = particle.frame.origin.x /_tileWidth;
        int y = particle.frame.origin.y /_tileHeight;
        particle.path = [[NSMutableArray alloc] initWithArray:[_heatmap points:CGPointMake(x, y)]];
        
        if (particle.path.count > 0 && !particle.animating) {
            [self animateParticle:particle];
        }
    }
}

- (void)animateParticle:(Particle *)particle {
    particle.animating = YES;
    [UIView animateWithDuration:particle.speed delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^(void) {
        Tile* tile = particle.path.firstObject;
        particle.frame = CGRectMake(tile.position.x * _tileWidth + (_tileWidth / 2), tile.position.y * _tileHeight + (_tileHeight / 2), particle.frame.size.width, particle.frame.size.height);
    } completion:^(BOOL finished) {
        particle.animating = NO;
        [self finishedParticleAnimation:particle];
    }];
}

- (void)finishedParticleAnimation:(Particle *)particle {
    if (particle.path.count > 0) {
        [particle.path removeObjectAtIndex:0];
        if (particle.path.count > 0) {
            [self animateParticle:particle];
        }
    }
}

- (Tile *)tileAtPoint:(CGPoint)point {
    return [[_map objectAtIndex:point.y] objectAtIndex:point.x];
}

@end
