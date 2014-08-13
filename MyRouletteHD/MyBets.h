//
//  MyBets.h
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 8/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBets : NSObject <NSCoding> {
    NSNumber *bet1;
    NSNumber *bet2;
    NSNumber *bet3;
    NSNumber *bet4;
    NSNumber *bet5;
    int currBet;
}

@property (nonatomic, retain) NSNumber *bet1;
@property (nonatomic, retain) NSNumber *bet2;
@property (nonatomic, retain) NSNumber *bet3;
@property (nonatomic, retain) NSNumber *bet4;
@property (nonatomic, retain) NSNumber *bet5;
@property int currBet;

- (id)init;

- (void)encodeWithCoder: (NSCoder *)encoder;

- (id)initWithCoder: (NSCoder *)decoder;

- (double)nextBet;
- (double)startBet;

@end
