//
//  MyRouletteStatsTableView.h
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "MyRouletteViewController.h"
//@class MyRouletteViewController;

typedef enum {
    BLACKS=0,
    REDS,
    EVENS,
    ODDS,
    HIGHS,
    LOWS,
    FIRST12,
    SECOND12,
    THIRD12,
    COLUMN0,
    COLUMN1,
    COLUMN2,
    LAST
} INDEX;


@interface MyRouletteStatsTableView : UITableViewController

@property (nonatomic, retain) IBOutlet UIView *headerView;
@property (nonatomic, retain) IBOutlet UIView *footerView;
@property (nonatomic, retain) IBOutlet UITableViewCell *cell;

@property (nonatomic, assign) NSMutableArray *scoresCount;
@property (nonatomic, assign) NSMutableArray *probabArray;
@property (nonatomic, assign) NSMutableArray *timesDrawn;

@property bool bEditing;

@property int totalDraws;


- (void)setScores:(NSMutableArray *)scores;
- (int)percentage:(int)index;

@end