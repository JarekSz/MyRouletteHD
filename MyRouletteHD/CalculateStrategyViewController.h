//
//  CalculateStrategyViewController.h
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 8/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Utilities.h"
#import "MyBets.h"

#define deg2rad (3.1415926/180.0)

@interface CalculateStrategyViewController : UIViewController


@property (nonatomic, retain) IBOutlet UIView *portretView;
//@property (nonatomic, retain) UIView *landscapeView;

@property (nonatomic, assign) NSMutableArray *colorsFrequency;
@property (nonatomic, assign) NSMutableArray *oddsFrequency;
@property (nonatomic, assign) NSMutableArray *halvesFrequency;

//@property (nonatomic, retain) UITextField *strategyText;
@property (nonatomic, retain) IBOutlet UITextField *colorText;
@property (nonatomic, retain) IBOutlet UITextField *oddsText;
@property (nonatomic, retain) IBOutlet UITextField *halvesText;

@property (nonatomic, retain) IBOutlet UITextField *value1;
@property (nonatomic, retain) IBOutlet UITextField *value2;
@property (nonatomic, retain) IBOutlet UITextField *value3;
@property (nonatomic, retain) IBOutlet UITextField *value4;
@property (nonatomic, retain) IBOutlet UITextField *value5;

@property (nonatomic, retain) MyBets *myBets;
@property int first; 
@property int second; 
@property int third; 
@property int fourth; 
@property int fifth;
@property bool needSaving;

@property (nonatomic, retain) IBOutlet UILabel *colorsLbl;
@property (nonatomic, retain) IBOutlet UILabel *oddsLbl;
@property (nonatomic, retain) IBOutlet UILabel *halfLbl;

@property double cashColors;
@property double cashOdds;
@property double cashHalves;

@property (nonatomic, retain) NSMutableArray *allNumbersDrawn;


-(void)setFrequenciesColors:(NSMutableArray *)colors 
                       Odds:(NSMutableArray *)odds 
                     Halves:(NSMutableArray *)halves
                 allNumbers:(NSMutableArray *)allNumbers;

-(void)setCashForColors:(double)colors
                   Odds:(double)odds
                 Halves:(double)halves;

-(void)showCash;
-(void)calculate;
//-(int)calcCategory:(NSMutableArray *)array;
-(IBAction)goBack;
-(IBAction)update;
-(IBAction)numberChanged:(id)sender;

@end
