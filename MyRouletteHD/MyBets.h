//
//  MyBets.h
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 8/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBets : NSObject <NSCoding>


@property (nonatomic, retain) NSNumber *bet01;
@property (nonatomic, retain) NSNumber *bet02;
@property (nonatomic, retain) NSNumber *bet03;
@property (nonatomic, retain) NSNumber *bet04;
@property (nonatomic, retain) NSNumber *bet05;
@property (nonatomic, retain) NSNumber *bet06;
@property (nonatomic, retain) NSNumber *bet07;
@property (nonatomic, retain) NSNumber *bet08;
@property (nonatomic, retain) NSNumber *bet09;
@property (nonatomic, retain) NSNumber *bet10;
@property (nonatomic, retain) NSNumber *bet11;
@property (nonatomic, retain) NSNumber *bet12;
@property int currBet;

- (id)init;

- (id)initWithArray:(NSArray *)array;

- (void)encodeWithCoder: (NSCoder *)encoder;

- (id)initWithCoder: (NSCoder *)decoder;

- (double)nextBet;
- (double)startBet;

@end
