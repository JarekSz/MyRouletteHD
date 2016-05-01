//
//  Utilities.m
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 6/20/13.
//
//

#import "Utilities.h"

#import "MyRouletteMath.h"


#define ProbSuccessDouble (18.0 / 38.0)
#define ProbSuccessTriple (12.0 / 38.0)


@implementation Utilities

+ (NSString *)archivePath {
    
	NSString *docDir =
	[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
										 NSUserDomainMask, YES) objectAtIndex: 0];
	return docDir;
}

+ (NSString *)archiveNumbersPath:(NSString *)fileName {
    
    NSString *docDir = [Utilities archivePath];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:fileName];
    
    return filePath;
}

+ (void)archiveNumbers:(NSArray *)numbers withFileName:fileName
{
    NSString *filePath = [Utilities archiveNumbersPath:fileName];
    
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
        success = [NSKeyedArchiver archiveRootObject:numbers
                                              toFile:filePath];
        if (success)
        {
            // LOCK IT BACK
            NSDictionary *attrib;
            attrib = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES]
                                                 forKey:NSFileImmutable];
            success = [fileManager setAttributes:attrib
                                    ofItemAtPath:filePath
                                           error:&error];
        }
        else {
            NSLog(@"Error: %@",[error localizedDescription]);
        }
    }
    else {
        NSLog(@"Could not UNLOCK the file.");
    }
}

+ (NSArray *)unarchiveNumbers {
    
    NSString *last = [self lastFileName];
    NSString *name = [self archiveNumbersPath:last];
    
    NSArray *myNumbers;
    
    myNumbers = [NSKeyedUnarchiver unarchiveObjectWithFile:name];
    
    return myNumbers;
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
    
    if (lastFile == nil) {
        lastFile = @"Roulette01.dat";
    }
    
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

+ (NSNumber *)isBlackProbability:(NSNumber *)count
{
    return [Utilities doubleProbability:count];
}


+ (BOOL)isRed:(NSString *)number
{
    BOOL red = FALSE;
    
    if ([Utilities.redSet containsObject:number]) {
        red = TRUE;
    }
    
    return red;
}

+ (NSNumber *)isRedProbability:(NSNumber *)count
{
    return [Utilities doubleProbability:count];
}

+ (BOOL)isHigh:(NSString *)number
{
    BOOL high = FALSE;
    
    if ([number intValue] > 18) {
        high = TRUE;
    }
    
    return high;
}

+ (NSNumber *)isHighProbability:(NSNumber *)count
{
    return [Utilities doubleProbability:count];
}

+ (BOOL)isLow:(NSString *)number
{
    BOOL low = FALSE;
    
    if ([number intValue] < 19 && [number intValue] > 0) {
        low = TRUE;
    }
    
    return low;
}

+ (NSNumber *)isLowProbability:(NSNumber *)count
{
    return [Utilities doubleProbability:count];
}


+ (BOOL)isOdd:(NSString *)number
{
    BOOL odd = FALSE;
    
    if (([number intValue] % 2) == 1 && [number intValue] > 0) {
        odd = TRUE;
    }
    
    return odd;
}

+ (NSNumber *)isOddProbability:(NSNumber *)count
{
    return [Utilities doubleProbability:count];
}


+ (BOOL)isEven:(NSString *)number
{
    BOOL even = FALSE;
    
    if (([number intValue] % 2) == 0 && [number intValue] > 0) {
        even = TRUE;
    }
    
    return even;
}

+ (NSNumber *)isEvenProbability:(NSNumber *)count
{
    return [Utilities doubleProbability:count];
}

+ (NSNumber *)doubleProbability:(NSNumber *)count
{
    double probability = 0.0;
    
    // probability of 1..n successes in n trials
    int n = [count intValue] + 1;
    
    probability = 1 - [MyRouletteMath probability:ProbSuccessDouble trials:n successes:0];
    
    return [NSNumber numberWithDouble:probability];
}


+ (BOOL)isFirstDozen:(NSString *)number
{
    BOOL first = FALSE;
    
    if (([number intValue] > 0) && ([number intValue] < 13)) {
        first = TRUE;
    }
    
    return first;
}

+ (NSNumber *)isFirstDozenProbability:(NSNumber *)count
{
    return [Utilities tripleProbability:count];
}

+ (BOOL)isSecondDozen:(NSString *)number
{
    BOOL second = FALSE;
    
    if (([number intValue] > 12) && ([number intValue] < 25)) {
        second = TRUE;
    }
    
    return second;
}

+ (NSNumber *)isSecondDozenProbability:(NSNumber *)count
{
    return [Utilities tripleProbability:count];
}

+ (BOOL)isThirdDozen:(NSString *)number
{
    BOOL third = FALSE;
    
    if (([number intValue] > 24) && ([number intValue] < 37)) {
        third = TRUE;
    }
    
    return third;
}

+ (NSNumber *)isThirdDozenProbability:(NSNumber *)count
{
    return [Utilities tripleProbability:count];
}

+ (NSNumber *)tripleProbability:(NSNumber *)count
{
    double probability = 0.0;
    
    // probability of 1..n successes in n trials
    int n = [count intValue] + 1;
    
    probability = 1 - [MyRouletteMath probability:ProbSuccessTriple trials:n successes:0];
    
    return [NSNumber numberWithDouble:probability];
}


+ (BOOL)isFirstColumn:(NSString *)number
{
    BOOL first = FALSE;
    
    if (([number intValue] % 3) == 1) {
        first = TRUE;
    }
    
    return first;
}

+ (NSNumber *)isFirstColumnProbability:(NSNumber *)count
{
    return [Utilities tripleProbability:count];
}

+ (BOOL)isSecondColumn:(NSString *)number
{
    BOOL second = FALSE;
    
    if (([number intValue] % 3) == 2) {
        second = TRUE;
    }
    
    return second;
}

+ (NSNumber *)isSecondColumnProbability:(NSNumber *)count
{
    return [Utilities tripleProbability:count];
}

+ (BOOL)isThirdColumn:(NSString *)number
{
    BOOL third = FALSE;
    
    if (([number intValue] % 3) == 0) {
        third = TRUE;
    }
    
    return third;
}

+ (NSNumber *)isThirdColumnProbability:(NSNumber *)count
{
    return [Utilities tripleProbability:count];
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
    NSLog(@"******************************");
    NSLog(@"%@",NSStringFromSelector(func1));
    NSLog(@"%@",NSStringFromSelector(func2));
    NSLog(@"******************************");
    
    bool betOne = false;
    bool betTwo = false;
    
    SEL probFunc1 = [Utilities probFuncFromFunc:func1];
    SEL probFunc2 = [Utilities probFuncFromFunc:func2];
    
    int col1 = 0, col2 = 0;
    int bet1 = 0, bet2 = 0;
    
    [frequency removeAllObjects];
    
    double cash = 0;
    
//    double bet = (double)[[myBets bet01] intValue];
    
    bool firstDraw = true;
    for (NSString *number in allNumbersDrawn )
    {
        col1++; col2++;
        
        if (firstDraw) {
            firstDraw = false;
            
            double prob = [[Utilities performSelector:probFunc1 withObject:[NSNumber numberWithInt:col1]] doubleValue];

            if ([Utilities performSelector:func1 withObject:number]) {
                betTwo = true;
                
                bet2 = [Utilities betNow:prob];
                cash -= bet2;
                col1 = 0;
            }
            else if ([Utilities performSelector:func2 withObject:number]) {
                betOne = true;
                
                bet1 = [Utilities betNow:prob];
                cash -= bet1;
                col2 = 0;
            }
        }
        else
        {
            ////////////////////////////////////////////////////////////////
            //
            // W I N N E R
            //
            if ([Utilities performSelector:func1 withObject:number])
            {
                if (betOne) {
                    cash += (2.0 * bet1);
                    [frequency addObject:[NSNumber numberWithInt:col1-1]];
                }
                col1 = 0;
            }
            if ([Utilities performSelector:func2 withObject:number])
            {
                if (betTwo) {
                    cash += (2.0 * bet2);
                    [frequency addObject:[NSNumber numberWithInt:col2-1]] ;
                }
                col2 = 0;
            }
            
            int maxCount = col1;
            if (col2 > maxCount) {
                maxCount = col2;
            }
            //
            // what we bet next
            //
            betOne = false;
            betTwo = false;
            
            bet1 = 0; bet2 = 0;
            
            if (maxCount == col1 && ![Utilities performSelector:func1 withObject:number])
            {
                double prob = [[Utilities performSelector:probFunc1 withObject:[NSNumber numberWithInt:col1]] doubleValue];
                
                bet1 = [Utilities betNow:prob];
                
                betOne = true;
            }
            if (maxCount == col2 && ![Utilities performSelector:func2 withObject:number])
            {
                double prob = [[Utilities performSelector:probFunc2 withObject:[NSNumber numberWithInt:col2]] doubleValue];
                
                bet2 = [Utilities betNow:prob];
                
                betTwo = true;
            }
            
            NSLog(@"number = %@", number);
            NSLog(@"col1 = %d, col2 = %d", col1, col2);
            NSLog(@"bet1 = %d, bet2 = %d", bet1, bet2);
            
            cash -= (bet1 + bet2);
        }
        
    } // allNumbersDrawn
    
    if (col1 > 1) {
        [frequency addObject:[NSNumber numberWithInt:col1-1]];
    }
    if (col2 > 1) {
        [frequency addObject:[NSNumber numberWithInt:col2-1]];
    }
    
    [self combineArray:frequency];
    
    NSLog(@"cash = %.2f", cash);
    
    return cash;
}

+ (SEL)probFuncFromFunc:(SEL)func
{
    NSMutableString *name = [NSMutableString stringWithString:NSStringFromSelector(func)];
    NSRange range = NSMakeRange([name length] - 1, 1);
    
    [name deleteCharactersInRange:range];

    [name appendString:@"Probability:"];
    
    return NSSelectorFromString(name);
}

+ (double)updateTrippleFrequencies:(NSMutableArray *)frequency
                        allNumbers:(NSMutableArray *)allNumbersDrawn
                         function1:(SEL)func1
                         function2:(SEL)func2
                         function3:(SEL)func3
                              bets:(MyBets *)myBets
{
    NSLog(@"******************************");
    NSLog(@"%@",NSStringFromSelector(func1));
    NSLog(@"%@",NSStringFromSelector(func2));
    NSLog(@"%@",NSStringFromSelector(func3));
    NSLog(@"******************************");
    
    bool betOne = false;
    bool betTwo = false;
    bool betThree = false;
    
    SEL probFunc1 = [Utilities probFuncFromFunc:func1];
    SEL probFunc2 = [Utilities probFuncFromFunc:func2];
    SEL probFunc3 = [Utilities probFuncFromFunc:func3];
    
    int col1 = 0, col2 = 0, col3 = 0;
    int bet1 = 0, bet2 = 0, bet3 = 0;
    
    [frequency removeAllObjects];
    
    double cash = 0;
    
//    double bet = (double)[[myBets bet01] intValue];
    
    bool firstDraw = true;
    for (NSString *number in allNumbersDrawn )
    {
        col1++; col2++; col3++;

        if (firstDraw) {
            firstDraw = false;
            
            if ([Utilities performSelector:func1 withObject:number]) {
                betTwo = true;
                betThree = true;
                col1 = 0;
            }
            else if ([Utilities performSelector:func2 withObject:number]) {
                betOne = true;
                betThree = true;
                col2 = 0;
            }
            else if ([Utilities performSelector:func3 withObject:number]) {
                betOne = true;
                betTwo = true;
                col3 = 0;
            }
        }
        else
        {
            ///////////////////////////////////////////////////////////
            //
            // W I N N E R
            //
            if ([Utilities performSelector:func1 withObject:number])
            {
                if (betOne) {
                    cash += (3.0 * bet1);
                    [frequency addObject:[NSNumber numberWithInt:col1-1]];
                }
                col1 = 0;
            }
            if ([Utilities performSelector:func2 withObject:number])
            {
                if (betTwo) {
                    cash += (3.0 * bet2);
                    [frequency addObject:[NSNumber numberWithInt:col2-1]];
                }
                col2 = 0;
            }
            if ([Utilities performSelector:func3 withObject:number])
            {
                if (betThree) {
                    cash += (3.0 * bet3);
                    [frequency addObject:[NSNumber numberWithInt:col3-1]];
                }
                col3 = 0;
            }
            
            int maxCount = col1;
            if (col2 > maxCount) {
                maxCount = col2;
            }
            if (col3 > maxCount) {
                maxCount = col3;
            }
            //
            // what we bet next
            //
            betOne = false;
            betTwo = false;
            betThree = false;
            
            bet1 = 0; bet2 = 0; bet3 = 0;
            
            if (col1 > 0 && maxCount == col1 && ![Utilities performSelector:func1 withObject:number])
            {
                double prob = [[Utilities performSelector:probFunc1 withObject:[NSNumber numberWithInt:col1]] doubleValue];
                
                bet1 = [Utilities betNow:prob];
                
                betOne = true;
            }
            if (col2 > 0 && maxCount == col2 && ![Utilities performSelector:func2 withObject:number])
            {
                double prob = [[Utilities performSelector:probFunc2 withObject:[NSNumber numberWithInt:col2]] doubleValue];
                
                bet2 = [Utilities betNow:prob];
                
                betTwo = true;
            }
            if (col3 > 0 && maxCount == col3 && ![Utilities performSelector:func3 withObject:number])
            {
                double prob = [[Utilities performSelector:probFunc3 withObject:[NSNumber numberWithInt:col3]] doubleValue];
                
                bet3 = [Utilities betNow:prob];
                
                betThree = true;
            }
            
            NSLog(@"number = %@", number);
            NSLog(@"col1 = %d, col2 = %d, col3 = %d", col1, col2, col3);
            NSLog(@"bet1 = %d, bet2 = %d, bet3 = %d", bet1, bet2, bet3);
            
            cash -= (bet1 + bet2 + bet3);
        }
        
    } // allNumbersDrawn
    
    if (col1 > 1) {
        [frequency addObject:[NSNumber numberWithInt:col1-1]];
    }
    if (col2 > 1) {
        [frequency addObject:[NSNumber numberWithInt:col2-1]];
    }
    if (col3 > 1) {
        [frequency addObject:[NSNumber numberWithInt:col3-1]];
    }
    
    [self combineArray:frequency];
    
    NSLog(@"cash = %.2f", cash);
    
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

+ (int)betNow:(double)prob
{
    int bet = 0;
    
    MyBets *myBets = [Utilities myBets];
    
    if (prob > 0.9998) {
        bet = [myBets.bet12 intValue];
    }
    else if (prob > 0.9997) {
        bet = [myBets.bet11 intValue];
    }
    else if (prob > 0.9994) {
        bet = [myBets.bet10 intValue];
    }
    else if (prob > 0.998) {
        bet = [myBets.bet09 intValue];
    }
    else if (prob > 0.997) {
        bet = [myBets.bet08 intValue];
    }
    else if (prob > 0.994) {
        bet = [myBets.bet07 intValue];
    }
    else if (prob > 0.98) {
        bet = [myBets.bet06 intValue];
    }
    else if (prob > 0.97) {
        bet = [myBets.bet05 intValue];
    }
    else if (prob > 0.94) {
        bet = [myBets.bet04 intValue];
    }
    else if (prob > 0.89) {
        bet = [myBets.bet03 intValue];
    }
    else if (prob > 0.77) {
        bet = [myBets.bet02 intValue];
    }
    else if (prob > 0.52) {
        bet = [myBets.bet01 intValue];
    }
    
    return bet;
}

@end
