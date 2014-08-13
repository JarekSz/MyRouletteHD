//
//  Utilities.h
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 6/20/13.
//
//

#import <Foundation/Foundation.h>

#import "MyBets.h"


@interface Utilities : NSObject


+ (NSString *)archivePath;
+ (NSString *)archiveBetsPath;
+ (MyBets *)unarchiveBets;
+ (void)archiveBets:(MyBets *)myBets;
+ (NSMutableArray *)arrayOfRouletteFiles;
+ (int)indexOfSelectedFile:(NSString *)fileName;
+ (NSString *)lastFileName;

+ (MyBets *)myBets;
+ (NSSet *)redSet;
+ ( NSSet *)blackSet;
+ (NSSet *)zeroSet;

+ (BOOL)isZero:(NSString *)number;
+ (BOOL)isBlack:(NSString *)number;
+ (BOOL)isRed:(NSString *)number;
+ (BOOL)isHigh:(NSString *)number;
+ (BOOL)isOdd:(NSString *)number;

+ (double)updateColorFrequencies:(NSMutableArray *)colorsFrequency
                      allNumbers:(NSMutableArray *)allNumbersDrawn;

+ (double)updateOddFrequencies:(NSMutableArray *)oddFrequency
                  allNumbers:(NSMutableArray *)allNumbersDrawn;

+ (double)updateHalvesFrequencies:(NSMutableArray *)halvesFrequency
                     allNumbers:(NSMutableArray *)allNumbersDrawn;

+ (double)updateFrequencies:(NSMutableArray *)frequency
                 allNumbers:(NSMutableArray *)allNumbersDrawn
                  function1:(SEL)func1
                  function2:(SEL)func2;

+ (void)combineArray:(NSMutableArray *)array;

@end
