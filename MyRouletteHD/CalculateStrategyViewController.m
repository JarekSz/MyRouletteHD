//
//  CalculateStrategyViewController.m
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 8/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculateStrategyViewController.h"

@interface CalculateStrategyViewController ()

@end

@implementation CalculateStrategyViewController

//@synthesize portretView;
//@synthesize landscapeView;

//@synthesize colorsFrequency;
//@synthesize oddsFrequency;
//@synthesize halvesFrequency;

//@synthesize strategyText;
//@synthesize colorText;
//@synthesize oddsText;
//@synthesize halvesText;

//@synthesize value1, value2, value3, value4, value5;

//@synthesize myBets;
//@synthesize first;
//@synthesize second;
//@synthesize third;
//@synthesize fourth;
//@synthesize fifth;
//@synthesize needSaving;

//@synthesize colorsLbl;
//@synthesize oddsLbl;
//@synthesize halfLbl;
//@synthesize cashColors, cashOdds, cashHalves;
//@synthesize allNumbersDrawn;


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
    self.myBets.bet1 = [NSNumber numberWithInt:_first];
    self.myBets.bet2 = [NSNumber numberWithInt:_second];
    self.myBets.bet3 = [NSNumber numberWithInt:_third];
    self.myBets.bet4 = [NSNumber numberWithInt:_fourth];
    self.myBets.bet5 = [NSNumber numberWithInt:_fifth];
}

-(IBAction)numberChanged:(id)sender
{
    self.needSaving = YES;
    
    [self readBetNumbers];

    [self setBets];

    [Utilities archiveBets:_myBets];
}

-(void)setFrequenciesColors:(NSMutableArray *)colors 
                       Odds:(NSMutableArray *)odds 
                     Halves:(NSMutableArray *)halves
                 allNumbers:(NSMutableArray *)allNumbers
{
    self.colorsFrequency = colors;
    self.oddsFrequency = odds;
    self.halvesFrequency = halves;
    
    _allNumbersDrawn = [[NSMutableArray alloc] init];
    [_allNumbersDrawn addObjectsFromArray:allNumbers];
}

-(void)setCashForColors:(double)colors
                   Odds:(double)odds
                 Halves:(double)halves
{
    self.cashColors = colors;
    self.cashOdds = odds;
    self.cashHalves = halves;
}

-(IBAction)goBack 
{    
    if (_needSaving)
    {
        [self update];
        
        [self setBets];
        
        [Utilities archiveBets:_myBets];
    }
    
	[self dismissModalViewControllerAnimated:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{    
	[textField resignFirstResponder];
    
	return YES;
}

-(void)showCash
{
    NSString *col = [NSString stringWithFormat:@"%.2f", _cashColors];
    self.colorText.text = col;
    
    NSString *odd = [NSString stringWithFormat:@"%.2f", _cashOdds];
    self.oddsText.text = odd;
    
    NSString *halves = [NSString stringWithFormat:@"%.2f", _cashHalves];
    self.halvesText.text = halves;
}

-(void)calculate
{
    self.cashColors = [Utilities updateColorFrequencies:_colorsFrequency allNumbers:_allNumbersDrawn];
    
    NSString *col = [NSString stringWithFormat:@"%.2f", _cashColors];
    self.colorText.text = col;
    
    self.cashOdds = [Utilities updateOddFrequencies:_oddsFrequency allNumbers:_allNumbersDrawn];
    
    NSString *odd = [NSString stringWithFormat:@"%.2f", _cashOdds];
    self.oddsText.text = odd;

    self.cashHalves = [Utilities updateHalvesFrequencies:_halvesFrequency allNumbers:_allNumbersDrawn];
    
    NSString *halves = [NSString stringWithFormat:@"%.2f", _cashHalves];
    self.halvesText.text = halves;
}

-(IBAction)update
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
    
    self.first = [[_myBets bet1] intValue];
    self.second = [[_myBets bet2] intValue];
    self.third = [[_myBets bet3] intValue];
    self.fourth = [[_myBets bet4] intValue];
    self.fifth = [[_myBets bet5] intValue];
    
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

    [self showCash];
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

//- (void)dealloc
//{
//    [colorText release];
//    [oddsText release];
//    [halvesText release];
//    [value1 release];
//    [value2 release];
//    [value3 release];
//    [value4 release];
//    [value5 release];
//    [colorsLbl release];
//    [oddsLbl release];
//    [halfLbl release];
//    
//    [super dealloc];
//}

/*
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view = portretView;
        self.view.transform = CGAffineTransformMakeRotation(0);
        self.view.bounds = CGRectMake(0.0, 0.0, 460.0, 320.0);
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.view = landscapeView;
        self.view.transform = CGAffineTransformMakeRotation(deg2rad * (-90));
        self.view.bounds = CGRectMake(0.0, 0.0, 300.0, 480.0);
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.view = landscapeView;
        self.view.transform = CGAffineTransformMakeRotation(deg2rad * 90);
        self.view.bounds = CGRectMake(0.0, 0.0, 300.0, 480.0);
    }
}
*/ 

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//            interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
//            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
