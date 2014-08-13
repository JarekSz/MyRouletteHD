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

@interface ViewController : UIViewController

@end
