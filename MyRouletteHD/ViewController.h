//
//  ViewController.h
//  MyRouletteHD
//
//  Created by Jaroslaw Szymczyk on 8/12/14.
//  Copyright (c) 2014 Jaroslaw Szymczyk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyRouletteStatsTableView.h"

#import "MyRouletteMath.h"
#import "CalculateStrategyViewController.h"
#import "FileViewController.h"
#import "MyBets.h"

#define deg2rad (3.1415926/180.0)

enum TURNS {
    FIRST = 0,
    SECOND,
    THIRD,
    FOURTH,
    FIFTH,
    SIXTH,
    SEVENTH,
    EIGHTH,
    ALL_THE_REST
};

@interface ViewController : UIViewController <UITextViewDelegate>

//@property (nonatomic, retain) UIView *portretView;
//@property (nonatomic, retain) UIView *landscapeView;
//@property bool portret;

@property (nonatomic, retain) IBOutlet UIButton *btn00, *btn0;
@property (nonatomic, retain) IBOutlet UIButton *btn01, *btn02, *btn03;
@property (nonatomic, retain) IBOutlet UIButton *btn04, *btn05, *btn06;
@property (nonatomic, retain) IBOutlet UIButton *btn07, *btn08, *btn09;
@property (nonatomic, retain) IBOutlet UIButton *btn10, *btn11, *btn12;
@property (nonatomic, retain) IBOutlet UIButton *btn13, *btn14, *btn15;
@property (nonatomic, retain) IBOutlet UIButton *btn16, *btn17, *btn18;
@property (nonatomic, retain) IBOutlet UIButton *btn19, *btn20, *btn21;
@property (nonatomic, retain) IBOutlet UIButton *btn22, *btn23, *btn24;
@property (nonatomic, retain) IBOutlet UIButton *btn25, *btn26, *btn27;
@property (nonatomic, retain) IBOutlet UIButton *btn28, *btn29, *btn30;
@property (nonatomic, retain) IBOutlet UIButton *btn31, *btn32, *btn33;
@property (nonatomic, retain) IBOutlet UIButton *btn34, *btn35, *btn36;

@property (nonatomic, retain) IBOutlet UITextView *history;
//@property (nonatomic, retain) IBOutlet UITextView *history2;

@property (nonatomic, retain) NSMutableArray *allNumbersDrawn;
@property (nonatomic, retain) NSMutableArray *notDrawnFor;
@property (nonatomic, retain) NSMutableArray *timesDrawn;
@property (nonatomic, retain) NSMutableArray *scoresCount;
@property (nonatomic, retain) NSMutableArray *probabArray;

@property (nonatomic, retain) NSMutableArray *colorsFrequency;
@property (nonatomic, retain) NSMutableArray *oddsFrequency;
@property (nonatomic, retain) NSMutableArray *halvesFrequency;
@property (nonatomic, retain) NSMutableArray *dozenFrequency;
@property (nonatomic, retain) NSMutableArray *columnFrequency;

@property int counter;

@property (nonatomic, retain) MyRouletteStatsTableView *tableView;
@property (nonatomic, retain) CalculateStrategyViewController *strategyView;
@property (nonatomic, retain) FileViewController *selectFileView;

@property (nonatomic, retain) NSString *selectedFilename;

@property (nonatomic, retain) MyBets *myBets;
@property double cashColors;
@property double cashOdds;
@property double cashHalves;
@property double cashDozens;
@property double cashColumns;

-(IBAction)save:(id)sender;
-(IBAction)loadFile;
-(IBAction)addNumber:(UIButton *)sender;
-(IBAction)removeLast;

-(void)archiveNumbers:(NSString *)fileName;
-(void)recalculateAllNumbers;

-(void)addNextNumber:(NSString *)number toText:(NSString **)text;
-(void)increaseNotDrawn;
-(IBAction)viewStats;
-(void)resetScores;

-(void)updateProbability:(BOOL)flag1
                  index1:(int)i1
          andProbability:(BOOL)flag2
                  index2:(int)i2
                  probab:(float)p;

-(void)updateProbability:(BOOL)flag1
                  index1:(int)index1
          andProbability:(BOOL)flag2
                  index2:(int)index2
          andProbability:(BOOL)flag3
                  index3:(int)index3
                  probab:(float)p;

-(void)updateFrequencies;

-(IBAction)winner;
-(void)makeRangeVisible;

@end
