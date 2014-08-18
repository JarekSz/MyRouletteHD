//
//  MyBets.m
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 8/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyBets.h"

@implementation MyBets


- (id)init {
	if (self == [super init]) 
	{
		_bet1 = [[NSNumber alloc] initWithInt:5];
		_bet2 = [[NSNumber alloc] initWithInt:10];
		_bet3 = [[NSNumber alloc] initWithInt:20];
		_bet4 = [[NSNumber alloc] initWithInt:40];
		_bet5 = [[NSNumber alloc] initWithInt:0];
	}
	return self;
}

- (id)initWithArray:(NSArray *)array {
	if (self == [super init])
	{
		_bet1 = [array objectAtIndex:0];
		_bet2 = [array objectAtIndex:1];
		_bet3 = [array objectAtIndex:2];
		_bet4 = [array objectAtIndex:3];
		_bet5 = [array objectAtIndex:4];
	}
	return self;
}

- (void)encodeWithCoder: (NSCoder *)encoder
{
    [encoder encodeObject:_bet1 forKey:@"first"];
    [encoder encodeObject:_bet2 forKey:@"second"];
    [encoder encodeObject:_bet3 forKey:@"third"];
    [encoder encodeObject:_bet4 forKey:@"fourth"];
    [encoder encodeObject:_bet5 forKey:@"fifth"];
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
    self.currBet = 0;
    double value = [_bet1 doubleValue];
    
    return value;
}

- (double)nextBet
{
    double value;
    
    _currBet++;
    
    switch (_currBet) {
        case 0:
            value = [_bet1 doubleValue];
            break;
        case 1:
            value = [_bet2 doubleValue];
            break;
        case 2:
            value = [_bet3 doubleValue];
            break;
        case 3:
            value = [_bet4 doubleValue];
            break;
        case 4:
            value = [_bet5 doubleValue];
            break;
            
        default:
            value = 0;
            break;
    }
    
    return value;
}

@end
