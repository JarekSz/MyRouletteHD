//
//  MyBets.m
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 8/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyBets.h"

@implementation MyBets

@synthesize bet1, bet2, bet3, bet4, bet5;
@synthesize currBet;

- (id)init {
	if (self == [super init]) 
	{
		bet1 = [[NSNumber alloc] initWithInt:5];
		bet2 = [[NSNumber alloc] initWithInt:10];
		bet3 = [[NSNumber alloc] initWithInt:20];
		bet4 = [[NSNumber alloc] initWithInt:40];
		bet5 = [[NSNumber alloc] initWithInt:0];
	}
	return self;
}

- (void)encodeWithCoder: (NSCoder *)encoder
{
    [encoder encodeObject:bet1 forKey:@"first"];
    [encoder encodeObject:bet2 forKey:@"second"];
    [encoder encodeObject:bet3 forKey:@"third"];
    [encoder encodeObject:bet4 forKey:@"fourth"];
    [encoder encodeObject:bet5 forKey:@"fifth"];
}

- (id)initWithCoder: (NSCoder *)decoder
{
	if (self == [super init]) 
    {
		self.bet1 = [decoder decodeObjectForKey:@"first"];
		self.bet2 = [decoder decodeObjectForKey:@"second"];
		self.bet3 = [decoder decodeObjectForKey:@"third"];
		self.bet4 = [decoder decodeObjectForKey:@"fourth"];
		self.bet5 = [decoder decodeObjectForKey:@"fifth"];
	}
	return self;
}

- (double)startBet
{
    currBet = 0;
    double value = [bet1 doubleValue];
    
    return value;
}

- (double)nextBet
{
    double value;
    
    currBet++;
    
    switch (currBet) {
        case 0:
            value = [bet1 doubleValue];
            break;
        case 1:
            value = [bet2 doubleValue];
            break;
        case 2:
            value = [bet3 doubleValue];
            break;
        case 3:
            value = [bet4 doubleValue];
            break;
        case 4:
            value = [bet5 doubleValue];
            break;
            
        default:
            value = 0;
            break;
    }
    
    return value;
}

@end
