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

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
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
    NSNumber *n1 = [NSNumber numberWithInt:5];
    NSNumber *n2 = [NSNumber numberWithInt:10];
    NSNumber *n3 = [NSNumber numberWithInt:20];
    NSNumber *n4 = [NSNumber numberWithInt:40];
    NSNumber *n5 = [NSNumber numberWithInt:80];
    
    NSArray *bets = @[n1,n2,n3,n4,n5];
    
    MyBets *myBets = [[MyBets alloc] initWithArray:bets];
    [Utilities archiveBets:myBets];
    
    double cash = 0;
    cash = [Utilities updateColorFrequencies:frequency allNumbers:allNumbersDrawn];
    
    if (cash != 35.0) {
        XCTFail(@"Should be 35 and was %f.", cash);
    }
    
    cash = [Utilities updateOddFrequencies:frequency allNumbers:allNumbersDrawn];
    
    if (cash != 25.0) {
        XCTFail(@"Should be 25 and was %f.", cash);
    }
    
    cash = [Utilities updateHalvesFrequencies:frequency allNumbers:allNumbersDrawn];
    
    if (cash != 35.0) {
        XCTFail(@"Should be 35 and was %f.", cash);
    }
    
    allNumbersDrawn = [[NSMutableArray alloc] initWithObjects: @"1",@"32",@"14",@"27",@"32",@"9",@"19",@"36",@"3",@"22",@"2",@"33",@"14",@"27",@"31",@"6",@"19",@"28",@"11",@"22",@"1",@"32",@"14",@"27",@"32",@"9",@"19",@"36",@"3",@"22",@"5",@"31",@"15",@"18",@"7",@"6",@"34",@"24",@"21",@"7",nil];
    
    cash = [Utilities updateColorFrequencies:frequency allNumbers:allNumbersDrawn];
    
    if (cash != -255.0) {
        XCTFail(@"Should be -255 and was %f.", cash);
    }

    cash = [Utilities updateOddFrequencies:frequency allNumbers:allNumbersDrawn];
    
    if (cash != 135.0) {
        XCTFail(@"Should be 135 and was %f.", cash);
    }

    cash = [Utilities updateHalvesFrequencies:frequency allNumbers:allNumbersDrawn];
    
    if (cash != 140.0) {
        XCTFail(@"Should be 150 and was %f.", cash);
    }

//    //
//    // bets: 2, 4, 8, 16, 32
//    //
//    n1 = [NSNumber numberWithInt:2];
//    n2 = [NSNumber numberWithInt:4];
//    n3 = [NSNumber numberWithInt:8];
//    n4 = [NSNumber numberWithInt:16];
//    n5 = [NSNumber numberWithInt:32];
//    
//    bets = @[n1,n2,n3,n4,n5];
//
//    myBets = [[MyBets alloc] initWithArray:bets];
//    [Utilities archiveBets:myBets];
//
//    cash = [Utilities updateColorFrequencies:frequency allNumbers:allNumbersDrawn];
//    
//    if (cash != 35.0) {
//        XCTFail(@"Should be 35 and was %f.", cash);
//    }
//    
//    cash = [Utilities updateOddFrequencies:frequency allNumbers:allNumbersDrawn];
//    
//    if (cash != 25.0) {
//        XCTFail(@"Should be 25 and was %f.", cash);
//    }
//    
//    cash = [Utilities updateHalvesFrequencies:frequency allNumbers:allNumbersDrawn];
//    
//    if (cash != 35.0) {
//        XCTFail(@"Should be 35 and was %f.", cash);
//    }
}

@end
