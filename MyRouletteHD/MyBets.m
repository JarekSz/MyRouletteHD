//
//  MyBets.m
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 8/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyBets.h"


@interface MyBets ()

// COL-ODD-HIGH-DOZ-CLM-ALL
@property (nonatomic, retain) NSNumber *mode;

@end

@implementation MyBets


- (id)init {
	if (self == [super init]) 
	{
//        _mode = [[NSNumber alloc] initWithInt:0];
//        
		_bet01 = [[NSNumber alloc] initWithInt:5];
		_bet02 = [[NSNumber alloc] initWithInt:10];
		_bet03 = [[NSNumber alloc] initWithInt:20];
		_bet04 = [[NSNumber alloc] initWithInt:40];
		_bet05 = [[NSNumber alloc] initWithInt:80];
		_bet06 = [[NSNumber alloc] initWithInt:160];
		_bet07 = [[NSNumber alloc] initWithInt:320];
		_bet08 = [[NSNumber alloc] initWithInt:640];
		_bet09 = [[NSNumber alloc] initWithInt:1280];
		_bet10 = [[NSNumber alloc] initWithInt:2560];
		_bet11 = [[NSNumber alloc] initWithInt:5120];
		_bet12 = [[NSNumber alloc] initWithInt:10240];
        
	}
	return self;
}

- (id)initWithArray:(NSArray *)array {
	if (self == [super init])
	{
//        _mode = [array objectAtIndex:0];
//        
		_bet01 = [array objectAtIndex:0];
		_bet02 = [array objectAtIndex:1];
		_bet03 = [array objectAtIndex:2];
		_bet04 = [array objectAtIndex:3];
		_bet05 = [array objectAtIndex:4];
		_bet06 = [array objectAtIndex:5];
		_bet07 = [array objectAtIndex:6];
		_bet08 = [array objectAtIndex:7];
		_bet09 = [array objectAtIndex:8];
		_bet10 = [array objectAtIndex:9];
		_bet11 = [array objectAtIndex:10];
		_bet12 = [array objectAtIndex:11];
	}
	return self;
}

- (void)encodeWithCoder: (NSCoder *)encoder
{
    [encoder encodeObject:_mode  forKey:@"mode"];
    
    [encoder encodeObject:_bet01 forKey:@"first"];
    [encoder encodeObject:_bet02 forKey:@"second"];
    [encoder encodeObject:_bet03 forKey:@"third"];
    [encoder encodeObject:_bet04 forKey:@"fourth"];
    [encoder encodeObject:_bet05 forKey:@"fifth"];
    [encoder encodeObject:_bet06 forKey:@"six"];
    [encoder encodeObject:_bet07 forKey:@"seven"];
    [encoder encodeObject:_bet08 forKey:@"eight"];
    [encoder encodeObject:_bet09 forKey:@"nine"];
    [encoder encodeObject:_bet10 forKey:@"ten"];
    [encoder encodeObject:_bet11 forKey:@"eleven"];
    [encoder encodeObject:_bet12 forKey:@"twelve"];
}

- (id)initWithCoder: (NSCoder *)decoder
{
	if (self == [super init]) 
    {
        self.mode = [decoder decodeObjectForKey:@"mode"];
        
		self.bet01 = [decoder decodeObjectForKey:@"first"];
		self.bet02 = [decoder decodeObjectForKey:@"second"];
		self.bet03 = [decoder decodeObjectForKey:@"third"];
		self.bet04 = [decoder decodeObjectForKey:@"fourth"];
		self.bet05 = [decoder decodeObjectForKey:@"fifth"];
		self.bet06 = [decoder decodeObjectForKey:@"six"];
		self.bet07 = [decoder decodeObjectForKey:@"seven"];
		self.bet08 = [decoder decodeObjectForKey:@"eight"];
		self.bet09 = [decoder decodeObjectForKey:@"nine"];
		self.bet10 = [decoder decodeObjectForKey:@"ten"];
		self.bet11 = [decoder decodeObjectForKey:@"eleven"];
		self.bet12 = [decoder decodeObjectForKey:@"twelve"];
	}
	return self;
}

- (double)startBet
{
    self.currBet = 0;
    double value = [_bet01 doubleValue];
    
    return value;
}

- (double)nextBet
{
    double value;
    
    _currBet++;
    
    switch (_currBet) {
        case 0:
        value = [_bet01 doubleValue];
        break;
        case 1:
        value = [_bet02 doubleValue];
        break;
        case 2:
        value = [_bet03 doubleValue];
        break;
        case 3:
        value = [_bet04 doubleValue];
        break;
        case 4:
        value = [_bet05 doubleValue];
        break;
        case 5:
        value = [_bet06 doubleValue];
        break;
        case 6:
        value = [_bet07 doubleValue];
        break;
        case 7:
        value = [_bet08 doubleValue];
        break;
        case 8:
        value = [_bet09 doubleValue];
        break;
        case 9:
        value = [_bet10 doubleValue];
        break;
        case 10:
        value = [_bet11 doubleValue];
        break;
        case 11:
        value = [_bet12 doubleValue];
        break;
        
        default:
        value = 0;
        break;
    }
    
    return value;
}

- (int)currentMode
{
    return [_mode intValue];
}

- (void)setGameMode:(NSInteger)mode
{
    _mode = [[NSNumber alloc] initWithInt:(int)mode];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%d - %d - %d - %d - %d - %d - %d - %d - %d - %d - %d - %d",
            [self.bet01 intValue],
            [self.bet02 intValue],
            [self.bet03 intValue],
            [self.bet04 intValue],
            [self.bet05 intValue],
            [self.bet06 intValue],
            [self.bet07 intValue],
            [self.bet08 intValue],
            [self.bet09 intValue],
            [self.bet10 intValue],
            [self.bet11 intValue],
            [self.bet12 intValue]];
}


@end
