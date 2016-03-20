//
//  CalculateStrategyViewController.m
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 8/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculateStrategyViewController.h"

#import "Utilities.h"


@interface CalculateStrategyViewController ()

@property (strong, nonatomic) IBOutlet UITextView *pastNumbers;

@end

@implementation CalculateStrategyViewController


- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)readBetNumbers
{
    self.first = [_value1.text intValue];
    self.second = [_value2.text intValue];
    self.third = [_value3.text intValue];
    self.fourth = [_value4.text intValue];
    self.fifth = [_value5.text intValue];
}

-(void)setBets
{
    self.myBets.bet01 = [NSNumber numberWithInt:_first];
    self.myBets.bet02 = [NSNumber numberWithInt:_second];
    self.myBets.bet03 = [NSNumber numberWithInt:_third];
    self.myBets.bet04 = [NSNumber numberWithInt:_fourth];
    self.myBets.bet05 = [NSNumber numberWithInt:_fifth];
    
    int number = [self.myBets.bet05 intValue];
    self.myBets.bet06 = [NSNumber numberWithInt:number * 2];
    self.myBets.bet07 = [NSNumber numberWithInt:number * 4];
    self.myBets.bet08 = [NSNumber numberWithInt:number * 8];
    self.myBets.bet09 = [NSNumber numberWithInt:number * 16];
    self.myBets.bet10 = [NSNumber numberWithInt:number * 32];
    self.myBets.bet11 = [NSNumber numberWithInt:number * 64];
    self.myBets.bet12 = [NSNumber numberWithInt:number * 128];
}

- (IBAction)modeChanged:(id)sender
{
    NSInteger mode = _modeSelect.selectedSegmentIndex;
    [_myBets setGameMode:mode];
    
    [Utilities archiveBets:_myBets];
}

- (IBAction)numberChanged:(id)sender
{
    self.needSaving = YES;
    
    [self readBetNumbers];

    [self setBets];

    [Utilities archiveBets:_myBets];
}

- (void)setFrequenciesColors:(NSMutableArray *)colors
                       Odds:(NSMutableArray *)odds 
                     Halves:(NSMutableArray *)halves
                     Dozens:(NSMutableArray *)dozens
                    Columns:(NSMutableArray *)columns
                 allNumbers:(NSMutableArray *)allNumbers
{
    self.colorsFrequency = colors;
    self.oddsFrequency = odds;
    self.halvesFrequency = halves;
    self.dozenFrequency = dozens;
    self.columnFrequency = columns;
    
    _allNumbersDrawn = [[NSMutableArray alloc] init];
    [_allNumbersDrawn addObjectsFromArray:allNumbers];
}

- (void)setCashForColors:(double)colors
                   Odds:(double)odds
                 Halves:(double)halves
                 Dozens:(double)dozens
                Columns:(double)columns
{
    self.cashColors = colors;
    self.cashOdds = odds;
    self.cashHalves = halves;
    self.cashDozens = dozens;
    self.cashColumns = columns;
}

- (IBAction)goBack
{    
    if (_needSaving)
    {
        [self update];
        
        [self setBets];
        
        [Utilities archiveBets:_myBets];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{    
	[textField resignFirstResponder];
    
	return YES;
}

- (void)showCash
{
    NSString *col = [NSString stringWithFormat:@"%d", (int)_cashColors];
    self.colorText.text = col;
    
    NSString *odd = [NSString stringWithFormat:@"%d", (int)_cashOdds];
    self.oddsText.text = odd;
    
    NSString *halves = [NSString stringWithFormat:@"%d", (int)_cashHalves];
    self.halvesText.text = halves;
    
    NSString *dozens = [NSString stringWithFormat:@"%d", (int)_cashDozens];
    self.dozenText.text = dozens;
    
    NSString *columns = [NSString stringWithFormat:@"%d", (int)_cashColumns];
    self.columnsText.text = columns;
}

- (void)calculate
{
    self.myBets = [Utilities myBets];
    
    self.cashColors = [Utilities updateColorFrequencies:_colorsFrequency
                                             allNumbers:_allNumbersDrawn
                                                   bets:_myBets];
    
    NSString *col = [NSString stringWithFormat:@"%.2f", _cashColors];
    self.colorText.text = col;
    
    self.cashOdds = [Utilities updateOddFrequencies:_oddsFrequency
                                         allNumbers:_allNumbersDrawn
                                               bets:_myBets];
    
    NSString *odd = [NSString stringWithFormat:@"%.2f", _cashOdds];
    self.oddsText.text = odd;

    self.cashHalves = [Utilities updateHalvesFrequencies:_halvesFrequency
                                              allNumbers:_allNumbersDrawn
                                                    bets:_myBets];
    
    NSString *halves = [NSString stringWithFormat:@"%.2f", _cashHalves];
    self.halvesText.text = halves;
    
    self.cashDozens = [Utilities updateDozenFrequencies:_dozenFrequency
                                             allNumbers:_allNumbersDrawn
                                                   bets:_myBets];
    
    NSString *dozens = [NSString stringWithFormat:@"%.2f", _cashDozens];
    self.dozenText.text = dozens;
    
    self.cashColumns = [Utilities updateColumnFrequencies:_columnFrequency
                                              allNumbers:_allNumbersDrawn
                                                    bets:_myBets];
    
    NSString *columns = [NSString stringWithFormat:@"%.2f", _cashColumns];
    self.columnsText.text = columns;
    
}

- (IBAction)update
{
    [self readBetNumbers];
    
    [self calculate];
}

/*
-(int)calcCategory:(NSMutableArray *)array
{
    int max = [array count];
    
    int cash = 0;
    
    //e.g. 5-10-20-40-0
    //
    if (first > 0) {
        cash += ([[array objectAtIndex:0] intValue] * first);
    } // else e.g. 0-5-10-20-40-0
    if (second > 0) {
        cash += ([[array objectAtIndex:1] intValue] * (second - first));
    }
    if (third > 0) {
        cash += ([[array objectAtIndex:2] intValue] * (third - second - first));
    }
    if (fourth > 0) {
        cash += ([[array objectAtIndex:3] intValue] * (fourth - third - second - first));
    }
    
    int i = 4;
    if (fifth > 0) {
        cash += ([[array objectAtIndex:4] intValue] * (fifth - fourth - third - second - first));
        i = 5;
    }
    
    int total = first + second + third + fourth + fifth;
    
    //add all the rest
    //
    int rest = 0;
    while (i < max) {
        rest += [[array objectAtIndex:i] intValue];
        i++;
    }
    cash -= (rest * total);

    return cash;
}
*/ 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    NSString *strategy = [[NSString alloc] initWithString:@"$5 - $10 - $20 - $40"];
//    strategyText.text = strategy;
    
    self.needSaving = NO; 
    
    self.myBets = [Utilities myBets];
    
    if (_myBets == nil) {
        _myBets = [[MyBets alloc] init];
        
        self.needSaving = YES;
    }
    
    int mode = [_myBets currentMode];
    _modeSelect.selectedSegmentIndex = mode;
    
    self.first = [[_myBets bet01] intValue];
    self.second = [[_myBets bet02] intValue];
    self.third = [[_myBets bet03] intValue];
    self.fourth = [[_myBets bet04] intValue];
    self.fifth = [[_myBets bet05] intValue];
    
    self.value1.text = [NSString stringWithFormat:@"%d", _first];
    self.value2.text = [NSString stringWithFormat:@"%d", _second];
    self.value3.text = [NSString stringWithFormat:@"%d", _third];
    self.value4.text = [NSString stringWithFormat:@"%d", _fourth];
    self.value5.text = [NSString stringWithFormat:@"%d", _fifth];
    
    NSString *colors = [[NSString alloc] initWithFormat:@"%d-%d-%d-%d-%d-%d", 
                     [[_colorsFrequency objectAtIndex:0] intValue],
                     [[_colorsFrequency objectAtIndex:1] intValue],
                     [[_colorsFrequency objectAtIndex:2] intValue],
                     [[_colorsFrequency objectAtIndex:3] intValue],
                     [[_colorsFrequency objectAtIndex:4] intValue],
                     [[_colorsFrequency objectAtIndex:5] intValue]];
    self.colorsLbl.text = colors;

    NSString *odds = [[NSString alloc] initWithFormat:@"%d-%d-%d-%d-%d-%d", 
                        [[_oddsFrequency objectAtIndex:0] intValue],
                        [[_oddsFrequency objectAtIndex:1] intValue],
                        [[_oddsFrequency objectAtIndex:2] intValue],
                        [[_oddsFrequency objectAtIndex:3] intValue],
                        [[_oddsFrequency objectAtIndex:4] intValue],
                        [[_oddsFrequency objectAtIndex:5] intValue]];
    self.oddsLbl.text = odds;

    NSString *half = [[NSString alloc] initWithFormat:@"%d-%d-%d-%d-%d-%d", 
                      [[_halvesFrequency objectAtIndex:0] intValue],
                      [[_halvesFrequency objectAtIndex:1] intValue],
                      [[_halvesFrequency objectAtIndex:2] intValue],
                      [[_halvesFrequency objectAtIndex:3] intValue],
                      [[_halvesFrequency objectAtIndex:4] intValue],
                      [[_halvesFrequency objectAtIndex:5] intValue]];
    self.halfLbl.text = half;

    NSString *dozen = [[NSString alloc] initWithFormat:@"%d-%d-%d-%d-%d-%d",
                      [[_dozenFrequency objectAtIndex:0] intValue],
                      [[_dozenFrequency objectAtIndex:1] intValue],
                      [[_dozenFrequency objectAtIndex:2] intValue],
                      [[_dozenFrequency objectAtIndex:3] intValue],
                      [[_dozenFrequency objectAtIndex:4] intValue],
                      [[_dozenFrequency objectAtIndex:5] intValue]];
    self.dozensLbl.text = dozen;

    NSString *column = [[NSString alloc] initWithFormat:@"%d-%d-%d-%d-%d-%d",
                       [[_columnFrequency objectAtIndex:0] intValue],
                       [[_columnFrequency objectAtIndex:1] intValue],
                       [[_columnFrequency objectAtIndex:2] intValue],
                       [[_columnFrequency objectAtIndex:3] intValue],
                       [[_columnFrequency objectAtIndex:4] intValue],
                       [[_columnFrequency objectAtIndex:5] intValue]];
    self.columnsLbl.text = column;

    [self showCash];
    
    NSMutableAttributedString *numbers = [[NSMutableAttributedString alloc] init];
    
    for (NSString *number in _allNumbersDrawn)
    {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:number];
        
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];

        [string addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];

        [string addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, string.length)];

        
        if ([Utilities isBlack:number]) {
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, string.length)];
        }
        else if ([Utilities isRed:number]) {
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, string.length)];
        }
        else {
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, string.length)];
        }
        
        NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:@"  "];
        
        [space addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, 2)];
        
        [numbers appendAttributedString:string];
        
        [numbers appendAttributedString:space];
    }
    
    self.pastNumbers.attributedText = numbers;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.colorText = nil;
    self.oddsText = nil;
    self.halvesText = nil;
    self.value1 = nil;
    self.value2 = nil;
    self.value3 = nil;
    self.value4 = nil;
    self.value5 = nil;
    self.colorsLbl = nil;
    self.oddsLbl = nil;
    self.halfLbl = nil;
}

@end
