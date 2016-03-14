//
//  MyRouletteMath.m
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyRouletteMath.h"

#import <math.h>

@implementation MyRouletteMath

+ (int)factorial:(int)num
{ 
    
    int res = 1; 
    
    for (int i = 2; i <= num; i++) 
    { 
        res *= i; 
    } 
    
    return res; 
} 

+ (int)permutationsN:(int)n overR:(int)r
{ 
    
    if( r > n ) 
    { 
        return 0; 
    } 
    
    int i = 0; 
    int res = 1; 
    while( i < r ) 
    { 
        res = res * n; 
        i++; 
        n--; 
    } 
    
    return res; 
} 

+ (int)combinationsN:(int)n overR:(int)r
{ 
    if( r > n ) 
    { 
        return 0; 
    } 
    
    int res = [self permutationsN:n overR:r]; 
    res = res / [self factorial:r]; 
    
    return res; 
} 

// probability of k or more successes in n trials
+ (float)probability:(float)p trials:(int)n successes:(int)k
{
    float prob = 0.0;
    
//    for (int i=k; i<=n; i++) {
        prob = pow(p, k) * pow(1 - p, n - k);
        prob *= (float)[self combinationsN:n overR:k];
//    }
    
    
    return prob;
}


@end
