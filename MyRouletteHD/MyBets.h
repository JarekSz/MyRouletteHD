//
//  MyBets.h
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 8/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBets : NSObject <NSCoding>


@property (nonatomic, retain) NSNumber *bet1;
@property (nonatomic, retain) NSNumber *bet2;
@property (nonatomic, retain) NSNumber *bet3;
@property (nonatomic, retain) NSNumber *bet4;
@property (nonatomic, retain) NSNumber *bet5;
@property int currBet;

- (id)init;

- (id)initWithArray:(NSArray *)array;

- (void)encodeWithCoder: (NSCoder *)encoder;

- (id)initWithCoder: (NSCoder *)decoder;

- (double)nextBet;
- (double)startBet;

@end
