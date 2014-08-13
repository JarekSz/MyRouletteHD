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
}

@end
