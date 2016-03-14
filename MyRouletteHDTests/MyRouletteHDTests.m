//
//  MyRouletteHDTests.m
//  MyRouletteHDTests
//
//  Created by Jaroslaw Szymczyk on 8/12/14.
//  Copyright (c) 2014 Jaroslaw Szymczyk. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Utilities.h"


@interface MyRouletteHDTests : XCTestCase

@end

@implementation MyRouletteHDTests


//if (prob > 0.9998) {
//    bet = [myBets.bet12 intValue];
//}
//else if (prob > 0.9997) {
//    bet = [myBets.bet11 intValue];
//}
//else if (prob > 0.9994) {
//    bet = [myBets.bet10 intValue];
//}
//else if (prob > 0.998) {
//    bet = [myBets.bet09 intValue];
//}
//else if (prob > 0.997) {
//    bet = [myBets.bet08 intValue];
//}
//else if (prob > 0.994) {
//    bet = [myBets.bet07 intValue];
//}
//else if (prob > 0.98) {
//    bet = [myBets.bet06 intValue];
//}
//else if (prob > 0.97) {
//    bet = [myBets.bet05 intValue];
//}
//else if (prob > 0.94) {
//    bet = [myBets.bet04 intValue];
//}
//else if (prob > 0.89) {
//    bet = [myBets.bet03 intValue];
//}
//else if (prob > 0.77) {
//    bet = [myBets.bet02 intValue];
//}
//else if (prob > 0.52) {


- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    double prob = [[Utilities isFirstDozenProbability:[NSNumber numberWithInt:1]] doubleValue];
    
    if (fabs(prob - 0.531855) > 0.00001) {
        XCTFail(@"Should be 0.531855 and was %f.", prob);
    }
    
    //prob > 0.52
    int bet = [Utilities betNow:prob];
    
    if (bet != [[Utilities myBets].bet01 intValue]) {
        XCTFail(@"Should be %d and was %d.", [[Utilities myBets].bet01 intValue], bet);
    }

    prob = [[Utilities isFirstDozenProbability:[NSNumber numberWithInt:2]] doubleValue];
    
    if (fabs(prob - 0.679690) > 0.00001) {
        XCTFail(@"Should be 0.679690 and was %f.", prob);
    }

    bet = [Utilities betNow:prob];
    
    if (bet != [[Utilities myBets].bet01 intValue]) {
        XCTFail(@"Should be %d and was %d.", [[Utilities myBets].bet01 intValue], bet);
    }

    prob = [[Utilities isFirstDozenProbability:[NSNumber numberWithInt:3]] doubleValue];
    
    if (fabs(prob - 0.780841) > 0.00001) {
        XCTFail(@"Should be 0.780841 and was %f.", prob);
    }
    
    //prob > 0.77
    bet = [Utilities betNow:prob];
    
    if (bet != [[Utilities myBets].bet02 intValue]) {
        XCTFail(@"Should be %d and was %d.", [[Utilities myBets].bet02 intValue], bet);
    }

    prob = [[Utilities isFirstDozenProbability:[NSNumber numberWithInt:4]] doubleValue];
    
    if (fabs(prob - 0.850049) > 0.00001) {
        XCTFail(@"Should be 0.850049 and was %f.", prob);
    }
    
    bet = [Utilities betNow:prob];
    
    if (bet != [[Utilities myBets].bet02 intValue]) {
        XCTFail(@"Should be %d and was %d.", [[Utilities myBets].bet02 intValue], bet);
    }
    
    prob = [[Utilities isFirstDozenProbability:[NSNumber numberWithInt:5]] doubleValue];
    
    if (fabs(prob - 0.897402) > 0.00001) {
        XCTFail(@"Should be 0.897402 and was %f.", prob);
    }
    
    //prob > 0.89
    bet = [Utilities betNow:prob];
    
    if (bet != [[Utilities myBets].bet03 intValue]) {
        XCTFail(@"Should be %d and was %d.", [[Utilities myBets].bet03 intValue], bet);
    }
    
    prob = [[Utilities isFirstDozenProbability:[NSNumber numberWithInt:6]] doubleValue];
    
    if (fabs(prob - 0.929801) > 0.00001) {
        XCTFail(@"Should be 0.929801 and was %f.", prob);
    }
    
    prob = [[Utilities isFirstDozenProbability:[NSNumber numberWithInt:7]] doubleValue];
    
    if (fabs(prob - 0.951969) > 0.00001) {
        XCTFail(@"Should be 0.951969 and was %f.", prob);
    }
    
    //prob > 0.94
    bet = [Utilities betNow:prob];
    
    if (bet != [[Utilities myBets].bet04 intValue]) {
        XCTFail(@"Should be %d and was %d.", [[Utilities myBets].bet04 intValue], bet);
    }

    prob = [[Utilities isFirstDozenProbability:[NSNumber numberWithInt:8]] doubleValue];
    
    if (fabs(prob - 0.967136) > 0.00001) {
        XCTFail(@"Should be 0.967136 and was %f.", prob);
    }
    
    prob = [[Utilities isFirstDozenProbability:[NSNumber numberWithInt:9]] doubleValue];
    
    if (fabs(prob - 0.977514) > 0.00001) {
        XCTFail(@"Should be 0.977514 and was %f.", prob);
    }
    
    //prob > 0.97
    bet = [Utilities betNow:prob];
    
    if (bet != [[Utilities myBets].bet05 intValue]) {
        XCTFail(@"Should be %d and was %d.", [[Utilities myBets].bet05 intValue], bet);
    }
    
    prob = [[Utilities isFirstDozenProbability:[NSNumber numberWithInt:10]] doubleValue];
    
    if (fabs(prob - 0.984615) > 0.00001) {
        XCTFail(@"Should be 0.984615 and was %f.", prob);
    }
    
    //prob > 0.98
    bet = [Utilities betNow:prob];
    
    if (bet != [[Utilities myBets].bet06 intValue]) {
        XCTFail(@"Should be %d and was %d.", [[Utilities myBets].bet06 intValue], bet);
    }
    
    prob = [[Utilities isFirstDozenProbability:[NSNumber numberWithInt:11]] doubleValue];
    
    if (fabs(prob - 0.989473) > 0.00001) {
        XCTFail(@"Should be 0.989473 and was %f.", prob);
    }
    
    prob = [[Utilities isFirstDozenProbability:[NSNumber numberWithInt:12]] doubleValue];
    
    if (fabs(prob - 0.992797) > 0.00001) {
        XCTFail(@"Should be 0.992797 and was %f.", prob);
    }
    
    prob = [[Utilities isFirstDozenProbability:[NSNumber numberWithInt:13]] doubleValue];
    
    if (fabs(prob - 0.995072) > 0.00001) {
        XCTFail(@"Should be 0.992797 and was %f.", prob);
    }
    
    //prob > 0.994
    bet = [Utilities betNow:prob];
    
    if (bet != [[Utilities myBets].bet07 intValue]) {
        XCTFail(@"Should be %d and was %d.", [[Utilities myBets].bet07 intValue], bet);
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    NSMutableArray *allNumbersDrawn = [[NSMutableArray alloc] initWithObjects: @"1",@"32",@"17",@"27",@"33",@"10",@"19",@"29",@"3",@"22",nil];
    
    NSMutableArray *frequency = [[NSMutableArray alloc] init];
    
    //
    // bets: 5, 10, 20, 40, 80
    //
    NSNumber *n0 = [NSNumber numberWithInt:5];
    NSNumber *n1 = [NSNumber numberWithInt:10];
    NSNumber *n2 = [NSNumber numberWithInt:20];
    NSNumber *n3 = [NSNumber numberWithInt:40];
    NSNumber *n4 = [NSNumber numberWithInt:80];
    NSNumber *n5 = [NSNumber numberWithInt:160];
    NSNumber *n6 = [NSNumber numberWithInt:320];
    NSNumber *n7 = [NSNumber numberWithInt:640];
    NSNumber *n8 = [NSNumber numberWithInt:1280];
    NSNumber *n9 = [NSNumber numberWithInt:2560];
    NSNumber *n10 = [NSNumber numberWithInt:5120];
    NSNumber *n11 = [NSNumber numberWithInt:10240];
    
    NSArray *bets = @[n0,n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11];
    
    MyBets *myBets = [[MyBets alloc] initWithArray:bets];
//    [Utilities archiveBets:myBets];
    
    double cash = 0;
    cash = [Utilities updateColorFrequencies:frequency
                                  allNumbers:allNumbersDrawn
                                        bets:myBets];
    
    if (cash != 35.0) {
        XCTFail(@"Should be 35 and was %f.", cash);
    }
    
    cash = [Utilities updateOddFrequencies:frequency
                                allNumbers:allNumbersDrawn
                                      bets:myBets];
    
    if (cash != 25.0) {
        XCTFail(@"Should be 25 and was %f.", cash);
    }
    
    cash = [Utilities updateHalvesFrequencies:frequency
                                   allNumbers:allNumbersDrawn
                                         bets:myBets];
    
    if (cash != 35.0) {
        XCTFail(@"Should be 35 and was %f.", cash);
    }
    
    allNumbersDrawn = [[NSMutableArray alloc] initWithObjects: @"1",@"32",@"14",@"27",@"32",@"9",@"19",@"36",@"3",@"22",@"2",@"33",@"14",@"27",@"31",@"6",@"19",@"28",@"11",@"22",@"1",@"32",@"14",@"27",@"32",@"9",@"19",@"36",@"3",@"22",@"5",@"31",@"15",@"18",@"7",@"6",@"34",@"24",@"21",@"7",nil];
    
    cash = [Utilities updateColorFrequencies:frequency
                                  allNumbers:allNumbersDrawn
                                        bets:myBets];
    
    if (cash != 65.0) {
        XCTFail(@"Should be 65 and was %f.", cash);
    }

    cash = [Utilities updateOddFrequencies:frequency
                                allNumbers:allNumbersDrawn
                                      bets:myBets];
    
    if (cash != 130.0) {
        XCTFail(@"Should be 130 and was %f.", cash);
    }

    cash = [Utilities updateHalvesFrequencies:frequency
                                   allNumbers:allNumbersDrawn
                                         bets:myBets];
    
    if (cash != 140.0) {
        XCTFail(@"Should be 140 and was %f.", cash);
    }

    /*
    //
    // bets: 2, 4, 8, 16, 32
    //
    n1 = [NSNumber numberWithInt:2];
    n2 = [NSNumber numberWithInt:4];
    n3 = [NSNumber numberWithInt:8];
    n4 = [NSNumber numberWithInt:16];
    n5 = [NSNumber numberWithInt:32];
    
    bets = @[n1,n2,n3,n4,n5];

    myBets = [[MyBets alloc] initWithArray:bets];
//    [Utilities archiveBets:myBets];

    cash = [Utilities updateColorFrequencies:frequency
                                  allNumbers:allNumbersDrawn
                                        bets:myBets];
    
    if (cash != -102.0) {
        XCTFail(@"Should be 102 and was %f.", cash);
    }
    
    cash = [Utilities updateOddFrequencies:frequency
                                allNumbers:allNumbersDrawn
                                      bets:myBets];
    
    if (cash != 54.0) {
        XCTFail(@"Should be 54 and was %f.", cash);
    }
    
    cash = [Utilities updateHalvesFrequencies:frequency
                                   allNumbers:allNumbersDrawn
                                         bets:myBets];
    
    if (cash != 56.0) {
        XCTFail(@"Should be 56 and was %f.", cash);
    }
     */
}

@end
