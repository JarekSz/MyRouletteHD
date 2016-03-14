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
+ (NSUInteger)indexOfSelectedFile:(NSString *)fileName;
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
+ (BOOL)isFirstDozen:(NSString *)number;
+ (BOOL)isSecondDozen:(NSString *)number;
+ (BOOL)isThirdDozen:(NSString *)number;
+ (BOOL)isFirstColumn:(NSString *)number;
+ (BOOL)isSecondColumn:(NSString *)number;
+ (BOOL)isThirdColumn:(NSString *)number;

+ (double)updateColorFrequencies:(NSMutableArray *)colorsFrequency
                      allNumbers:(NSMutableArray *)allNumbersDrawn
                            bets:(MyBets *)myBets;

+ (double)updateOddFrequencies:(NSMutableArray *)oddFrequency
                  allNumbers:(NSMutableArray *)allNumbersDrawn
                        bets:(MyBets *)myBets;


+ (double)updateHalvesFrequencies:(NSMutableArray *)halvesFrequency
                     allNumbers:(NSMutableArray *)allNumbersDrawn
                            bets:(MyBets *)myBets;

+ (double)updateDozenFrequencies:(NSMutableArray *)dozenFrequency
                      allNumbers:(NSMutableArray *)allNumbersDrawn
                            bets:(MyBets *)myBets;

+ (double)updateColumnFrequencies:(NSMutableArray *)columnFrequency
                       allNumbers:(NSMutableArray *)allNumbersDrawn
                             bets:(MyBets *)myBets;

+ (double)updateFrequencies:(NSMutableArray *)frequency
                 allNumbers:(NSMutableArray *)allNumbersDrawn
                  function1:(SEL)func1
                  function2:(SEL)func2
                       bets:(MyBets *)myBets;

+ (double)updateTrippleFrequencies:(NSMutableArray *)frequency
                        allNumbers:(NSMutableArray *)allNumbersDrawn
                         function1:(SEL)func1
                         function2:(SEL)func2
                         function3:(SEL)func3
                              bets:(MyBets *)myBets;

+ (void)combineArray:(NSMutableArray *)array;
+ (int)betNow:(double)prob;

+ (NSNumber *)isFirstDozenProbability:(NSNumber *)count;
+ (NSNumber *)isSecondDozenProbability:(NSNumber *)count;
+ (NSNumber *)isThirdDozenProbability:(NSNumber *)count;
+ (NSNumber *)isFirstColumnProbability:(NSNumber *)count;
+ (NSNumber *)isSecondColumnProbability:(NSNumber *)count;
+ (NSNumber *)isThirdColumnProbability:(NSNumber *)count;

@end
