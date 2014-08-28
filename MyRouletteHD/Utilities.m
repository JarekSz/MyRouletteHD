//
//  Utilities.m
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 6/20/13.
//
//

#import "Utilities.h"

@implementation Utilities


+ (NSString *)archivePath {
    
	NSString *docDir =
	[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
										 NSUserDomainMask, YES) objectAtIndex: 0];
	return docDir;
}

+ (NSString *)archiveBetsPath {
    
	NSString *docDir = [Utilities archivePath];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"MyBets.dat"];
    
	return filePath;
}

+ (MyBets *)unarchiveBets {
	
	NSString *name = [self archiveBetsPath];
	
	MyBets *myBets;
    
    myBets = [NSKeyedUnarchiver unarchiveObjectWithFile:name];
    
    return myBets;
}

+ (void)archiveBets:(MyBets *)myBets {
	
    NSString *filePath = [self archiveBetsPath];
    
    NSError *error = nil;
    BOOL success = YES;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //
    // check if file already exist
    //
    BOOL exist = [fileManager fileExistsAtPath:filePath];
    if (YES == exist) {
        
        // UNLOCK THE FILE - if exists
        NSDictionary *attrib;
        attrib = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                             forKey:NSFileImmutable];
        
        success = [fileManager setAttributes:attrib
                                ofItemAtPath:filePath
                                       error:&error];
    }
    
    //
    // new file or unlocked
    //
    if (YES == success) {
        
        // SAVE THE FILE
        [NSKeyedArchiver archiveRootObject:myBets
                                    toFile:filePath];
        
        // LOCK IT BACK
        NSDictionary *attrib;
        attrib = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES]
                                             forKey:NSFileImmutable];
        success = [fileManager setAttributes:attrib
                                ofItemAtPath:filePath
                                       error:&error];
        
        if (NO == success) {
            NSLog(@"Error: %@",[error localizedDescription]);
        }
    }
    else {
        NSLog(@"Could not UNLOCK the file.");
    }
}

+ (NSMutableArray *)arrayOfRouletteFiles
{
	NSString *docDir = [Utilities archivePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    NSArray  *allFiles = [fileManager contentsOfDirectoryAtPath:docDir error:&error];
    
    NSMutableArray *allRouletteFiles = [[NSMutableArray alloc] init];
    
    for (NSString *filename in allFiles)
    {
        if ([filename hasPrefix:@"Roulette"])
        {
            [allRouletteFiles addObject:filename];
        }
    }
    
    return allRouletteFiles;
}

+ (NSUInteger)indexOfSelectedFile:(NSString *)fileName
{
    NSMutableArray  *allFiles = [Utilities arrayOfRouletteFiles];
    
    NSUInteger index = [allFiles indexOfObject:fileName];
    
    return index;
}

+ (NSString *)lastFileName
{
    NSMutableArray *allFiles = [Utilities arrayOfRouletteFiles];
    
    NSString *lastFile = [allFiles lastObject];
    
    return lastFile;
}

+ (MyBets *)myBets
{
    static MyBets *mybets = nil;
    if (nil == mybets) {
        mybets = [Utilities unarchiveBets];
        if (nil == mybets) {
            mybets = [[MyBets alloc] init];
        }
    }
    
    mybets.currBet = 0;
    
    return mybets;
}

+ (NSSet *)redSet
{
    static NSSet *redSet = nil;
    if (!redSet) {
        redSet = [NSSet setWithObjects:@"1", @"3", @"5", @"7", @"9", @"12", @"14", @"16", @"18", @"19", @"21", @"23", @"25", @"27", @"30", @"32", @"34", @"36", nil];
    }
    
    return redSet;
}

+ (NSSet *)blackSet
{
    static NSSet *blackSet = nil;
    if (!blackSet) {
        blackSet = [NSSet setWithObjects: @"2", @"4", @"6", @"8", @"10", @"11", @"13", @"15", @"17", @"20", @"22", @"24", @"26", @"28", @"29", @"31", @"33", @"35", nil];
    }
    
    return blackSet;
}

+ (NSSet *)zeroSet
{
    static NSSet *zeroSet = nil;
    if (!zeroSet) {
        zeroSet = [NSSet setWithObjects: @"0", @"00", nil];
    }
    
    return zeroSet;
}

+ (BOOL)isZero:(NSString *)number
{
    BOOL zero = FALSE;
    
    if ([[Utilities zeroSet] containsObject:number]) {
        zero = TRUE;
    }
    
    return zero;
}

+ (BOOL)isBlack:(NSString *)number
{
    BOOL black = FALSE;
    
    if ([Utilities.blackSet containsObject:number]) {
        black = TRUE;
    }
    
    return black;
}

+ (BOOL)isRed:(NSString *)number
{
    BOOL red = FALSE;
    
    if ([Utilities.redSet containsObject:number]) {
        red = TRUE;
    }
    
    return red;
}

+ (BOOL)isHigh:(NSString *)number
{
    BOOL high = FALSE;
    
    if ([number intValue] > 18) {
        high = TRUE;
    }
    
    return high;
}

+ (BOOL)isLow:(NSString *)number
{
    BOOL low = FALSE;
    
    if ([number intValue] < 19 && [number intValue] > 0) {
        low = TRUE;
    }
    
    return low;
}

+ (BOOL)isOdd:(NSString *)number
{
    BOOL odd = FALSE;
    
    if (([number intValue] % 2) == 1 && [number intValue] > 0) {
        odd = TRUE;
    }
    
    return odd;
}

+ (BOOL)isEven:(NSString *)number
{
    BOOL even = FALSE;
    
    if (([number intValue] % 2) == 0 && [number intValue] > 0) {
        even = TRUE;
    }
    
    return even;
}

+ (BOOL)isFirstDozen:(NSString *)number
{
    BOOL first = FALSE;
    
    if (([number intValue] > 0) && ([number intValue] < 13)) {
        first = TRUE;
    }
    
    return first;
}

+ (BOOL)isSecondDozen:(NSString *)number
{
    BOOL second = FALSE;
    
    if (([number intValue] > 12) && ([number intValue] < 25)) {
        second = TRUE;
    }
    
    return second;
}

+ (BOOL)isThirdDozen:(NSString *)number
{
    BOOL third = FALSE;
    
    if (([number intValue] > 24) && ([number intValue] < 37)) {
        third = TRUE;
    }
    
    return third;
}

+ (BOOL)isFirstColumn:(NSString *)number
{
    BOOL first = FALSE;
    
    if (([number intValue] % 3) == 1) {
        first = TRUE;
    }
    
    return first;
}

+ (BOOL)isSecondColumn:(NSString *)number
{
    BOOL second = FALSE;
    
    if (([number intValue] % 3) == 2) {
        second = TRUE;
    }
    
    return second;
}

+ (BOOL)isThirdColumn:(NSString *)number
{
    BOOL third = FALSE;
    
    if (([number intValue] % 3) == 0) {
        third = TRUE;
    }
    
    return third;
}

+ (double)updateColorFrequencies:(NSMutableArray *)colorsFrequency
                      allNumbers:(NSMutableArray *)allNumbersDrawn
                            bets:(MyBets *)myBets
{
    double cash = 0;
    cash = [Utilities updateFrequencies:colorsFrequency
                      allNumbers:allNumbersDrawn
                       function1:@selector(isRed:)
                       function2:@selector(isBlack:)
                            bets:myBets];
    
    return cash;
}

+ (double)updateOddFrequencies:(NSMutableArray *)oddFrequency
                    allNumbers:(NSMutableArray *)allNumbersDrawn
                          bets:(MyBets *)myBets
{
    double cash = 0;
    cash = [Utilities updateFrequencies:oddFrequency
                      allNumbers:allNumbersDrawn
                       function1:@selector(isOdd:)
                       function2:@selector(isEven:)
                            bets:myBets];
    
    return cash;
}

+ (double)updateHalvesFrequencies:(NSMutableArray *)halvesFrequency
                       allNumbers:(NSMutableArray *)allNumbersDrawn
                             bets:(MyBets *)myBets
{
    double cash = 0;
    cash = [Utilities updateFrequencies:halvesFrequency
                      allNumbers:allNumbersDrawn
                       function1:@selector(isHigh:)
                       function2:@selector(isLow:)
                            bets:myBets];
    
    return cash;
}

+ (double)updateDozenFrequencies:(NSMutableArray *)dozenFrequency
                       allNumbers:(NSMutableArray *)allNumbersDrawn
                             bets:(MyBets *)myBets
{
    double cash = 0;
    cash = [Utilities updateTrippleFrequencies:dozenFrequency
                                    allNumbers:allNumbersDrawn
                                     function1:@selector(isFirstDozen:)
                                     function2:@selector(isSecondDozen:)
                                     function3:@selector(isThirdDozen:)
                                          bets:myBets];
    
    return cash;
}

+ (double)updateColumnFrequencies:(NSMutableArray *)columnFrequency
                      allNumbers:(NSMutableArray *)allNumbersDrawn
                            bets:(MyBets *)myBets
{
    double cash = 0;
    cash = [Utilities updateTrippleFrequencies:columnFrequency
                                    allNumbers:allNumbersDrawn
                                     function1:@selector(isFirstColumn:)
                                     function2:@selector(isSecondColumn:)
                                     function3:@selector(isThirdColumn:)
                                          bets:myBets];
    
    return cash;
}

+ (double)updateFrequencies:(NSMutableArray *)frequency
                 allNumbers:(NSMutableArray *)allNumbersDrawn
                  function1:(SEL)func1
                  function2:(SEL)func2
                       bets:(MyBets *)myBets
{
    bool prevOne = false;
    bool prevTwo = false;
    
//    MyBets *myBets = [Utilities myBets];
    
    [frequency removeAllObjects];
    
    double cash = 0;
    
    double bet = (double)[[myBets bet01] intValue];
    
    int count = 0;
    bool firstDraw = true;
    for (NSString *number in allNumbersDrawn)
    {
        //
        // same one drawn = loosing
        //
        if ([Utilities performSelector:func1 withObject:number] && prevOne) {
            count++;
            cash -= bet;
            bet = [myBets nextBet];
        }
        else if ([Utilities performSelector:func2 withObject:number] && prevTwo) {
            count++;
            cash -= bet;
            bet = [myBets nextBet];
        }
        //
        // opposite drawn = winning
        //
        else {
            if (count > 0) {
                [frequency addObject:[NSNumber numberWithInt:count]];
            }
            
            count = 1;
            
            if (firstDraw) {
                firstDraw = false;
            }
            else {
                cash += bet;
                bet = [myBets startBet];
            }
            
            if ([Utilities performSelector:func1 withObject:number]) {
                prevOne = true;
                prevTwo = false;
            }
            else if ([Utilities performSelector:func2 withObject:number]) {
                prevTwo = true;
                prevOne = false;
            }
            else {
                prevTwo = false;
                prevOne = false;
                count = 0;
            }
        }
    } // allNumbersDrawn
    
    // add last count
    if (count > 0) {
        [frequency addObject:[NSNumber numberWithInt:count]];
    }
    
    [self combineArray:frequency];
    
    return cash;
}

+ (double)updateTrippleFrequencies:(NSMutableArray *)frequency
                        allNumbers:(NSMutableArray *)allNumbersDrawn
                         function1:(SEL)func1
                         function2:(SEL)func2
                         function3:(SEL)func3
                              bets:(MyBets *)myBets
{
    int col1 = 0, col2 = 0, col3 = 0;
    int bet1 = 0, bet2 = 0, bet3 = 0;
    
    [frequency removeAllObjects];
    
    double cash = 0;
    
    double bet = (double)[[myBets bet01] intValue];
    
//    NSArray *numbers = @[@"1",@"5",@"8",@"7",@"10",@"9",@"11",@"14",@"17",@"20",@"0",@"15",@"18",@"1",@"2",@"1",@"2",@"5",@"8",@"3",@"3",@"2"];
    
    int count = 0;
    for (NSString *number in allNumbersDrawn)
    {
        col1++; col2++; col3++;
        
        //
        // same one drawn = loosing
        //
        if ([Utilities performSelector:func1 withObject:number]) {
            col1 = 0;
            cash += (2.0 * bet1);
            bet1 = 0;
            if (col2 > 1) {
                bet2 = bet * pow(2, col2 - 2);
            }
            if (col3 > 1) {
                bet3 = bet * pow(2, col3 - 2);
            }
        }
        else if ([Utilities performSelector:func2 withObject:number]) {
            col2 = 0;
            cash += (2.0 * bet2);
            bet2 = 0;
            if (col1 > 1) {
                bet1 = bet * pow(2, col1 - 2);
            }
            if (col3 > 1) {
                bet3 = bet * pow(2, col3 - 2);
            }
        }
        else if ([Utilities performSelector:func3 withObject:number]) {
            col3 = 0;
            cash += (2.0 * bet3);
            bet3 = 0;
            if (col1 > 1) {
                bet1 = bet * pow(2, col1 - 2);
            }
            if (col2 > 1) {
                bet2 = bet * pow(2, col2 - 2);
            }
        }
        
        NSLog(@"col1 = %d, col2 = %d, col3 = %d", col1, col2, col3);
        NSLog(@"bet1 = %d, bet2 = %d, bet3 = %d", bet1, bet2, bet3);
        
        cash -= (bet1 + bet2 + bet3);
        
    } // allNumbersDrawn
    
    // add last count
    if (count > 0) {
        [frequency addObject:[NSNumber numberWithInt:count]];
    }
    
    [self combineArray:frequency];
    
    return cash;
}

+ (void)combineArray:(NSMutableArray *)array
{
    int count1 = 0;
    int count2 = 0;
    int count3 = 0;
    int count4 = 0;
    int count5 = 0;

    int count99 = 0;
    
    for (NSNumber *numb in array) {
        int num = [numb intValue];
        switch (num) {
            case 1:
                count1++;
                break;
            case 2:
                count2++;
                break;
            case 3:
                count3++;
                break;
            case 4:
                count4++;
                break;
            case 5:
                count5++;
                break;
                
            default:
                count99++;
                break;
        }
    }
    
    [array removeAllObjects];
    
    [array addObject:[NSNumber numberWithInt:count1]];
    [array addObject:[NSNumber numberWithInt:count2]];
    [array addObject:[NSNumber numberWithInt:count3]];
    [array addObject:[NSNumber numberWithInt:count4]];
    [array addObject:[NSNumber numberWithInt:count5]];
    //    [array addObject:[NSNumber numberWithInt:count6]];
    [array addObject:[NSNumber numberWithInt:count99]];
    
}

@end
