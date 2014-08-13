//
//  MyRouletteMath.h
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRouletteMath : NSObject

+(float) probability:(float)p trials:(int)n successes:(int)k;

+(int) factorial:(int)num;
+(int) permutationsN:(int)n overR:(int)r;
+(int) combinationsN:(int)n overR:(int)r;

@end
