HeatMapPath
===========

[![Build Status](https://travis-ci.org/D-32/HeatMapPath.svg)](https://travis-ci.org/D-32/HeatMapPath)
[![Version](https://img.shields.io/cocoapods/v/HeatMapPath.svg?style=flat)](http://cocoadocs.org/docsets/HeatMapPath)
[![License](https://img.shields.io/cocoapods/l/HeatMapPath.svg?style=flat)](http://cocoadocs.org/docsets/HeatMapPath)

Goal-Based vector field path finding for iOS.

If you need to calculate the shortest path for many objects with the same target than this approach should be more efficient than traditional path finding algorithms. It creates a heatmap for the hole map, which takes time. But for each object it than only has to follow the heatmap values.

![image](http://46.105.26.1/uploads/heatmap.png)

## Installation

HeatMapPath is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "HeatMapPath"

If you're not using CocoaPods you'll find the source code files inside `Pod/Classes`. 

## Usage

##### Tile
Just create your own Tile class which implements the protocol `DMTile`. 

Add the two synthesize:

	@synthesize distance;
	@synthesize position;

And add the method `costFromSource:`

	- (int)costFromSource:(id<DMTile>)sourceTile {
    	return 1;
	}
Here you can return the cost for that tile. How you'll do thatis your choice. You get the source tile (the one that's before it in the path) if your cost is different depending on the direction.

##### HeatMap

Initialize a `DMHeatMap` and keep it as member. Set the map property. The map property should be an array of arrays. The outer array is for each row. And each row is an NSArray with your tiles for that row. Hope this doesn't sound too complicated.

Everytime your target changes you'll have to set the target property and call the method `generate`.

For each object that needs a new path just call the method `points:`.

## Demo
http://www.youtube.com/watch?v=Y3H0WLZHtzU

## Diagonal
At the moment it doesn't support diagonal moves, as for my use case this wasn't needed. You can add this functionality quite easily. Just look at where neighbors are determined. Should be done at two places, once for the heatmap and once for the path finding.
