//
//  ViewController.m
//  MyRouletteHD
//
//  Created by Jaroslaw Szymczyk on 8/12/14.
//  Copyright (c) 2014 Jaroslaw Szymczyk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark -
#pragma mark -file operation

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (NSString *)nextNewFile:(NSString *)docDir
{
    NSString *filename = @"Roulette01.dat";
    
    NSString *filePath = [docDir stringByAppendingPathComponent:filename];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    int count = 1;
    BOOL exist;
    do {
        exist = [fileManager fileExistsAtPath:filePath];
        if (YES == exist) {
            filename = [NSString stringWithFormat:@"Roulette%02d.dat", count];
            filePath = [docDir stringByAppendingPathComponent: filename];
            count++;
        }
    } while (exist);
    
    return filename;
}

- (void)archiveNumbers:(NSString *)fileName
{
    NSString *docPath = [Utilities archivePath];
    
    if (nil == fileName) {
        fileName = @"Roulette01.dat";
    }
    
    _selectedFilename = fileName;
    
    NSString *filePath = [docPath stringByAppendingPathComponent:_selectedFilename];
    
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
        success = [NSKeyedArchiver archiveRootObject:_allNumbersDrawn
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

#pragma mark -
#pragma mark -actions

-(IBAction)winner
{
    [self archiveNumbers:_selectedFilename];
    
    if (nil == _strategyView) {
        _strategyView = [[CalculateStrategyViewController alloc]
                        initWithNibName:@"CalculateStrategyViewController"
                        bundle:nil];
    }
    
    [self updateFrequencies];
    
    [_strategyView setFrequenciesColors:_colorsFrequency
                                   Odds:_oddsFrequency
                                 Halves:_halvesFrequency
                                 Dozens:_dozenFrequency
                                Columns:_columnFrequency
                             allNumbers:_allNumbersDrawn];
    
    [_strategyView setCashForColors:_cashColors
                              Odds:_cashOdds
                            Halves:_cashHalves
                             Dozens:_cashDozens
                            Columns:_cashColumns];
    
    
    if (nil == _selectedFilename) {
        _selectedFilename = [Utilities lastFileName];
    }
    
    [self presentViewController:_strategyView animated:YES completion:nil];
    
    self.strategyView = nil;
}

-(IBAction)removeLast
{
    [_allNumbersDrawn removeLastObject];
    
    [self resetScores];
    
    //
    // redo all numbers
    //
    NSString *text = [[NSString alloc] init];
    
    for (NSString *number in _allNumbersDrawn) {
        [self addNextNumber:number toText:&text];
    }
    
    self.history.text = text;
    self.history2.text = text;
    
    [self recalculateAllNumbers];
}

-(IBAction)viewStats
{
    [self archiveNumbers:_selectedFilename];
    
    if (nil == _tableView) {
		_tableView = [[MyRouletteStatsTableView alloc]
                     initWithNibName: @"MyRouletteStatsTableView" bundle: nil];
	}
    
    self.tableView.scoresCount = self.scoresCount;
    self.tableView.probabArray = self.probabArray;
    self.tableView.timesDrawn = self.timesDrawn;
//    self.tableView.myBets = self.myBets;
//    self.tableView.notDrawnFor = self.notDrawnFor;
    self.tableView.probabArray = self.probabArray;
    
    self.tableView.totalDraws = [_allNumbersDrawn count];
    
    if (nil == _selectedFilename) {
        _selectedFilename = [Utilities lastFileName];
    }
    
//    self.selectFileView.selectedFilename = &(_selectedFilename);
    
    [self presentViewController:_tableView animated:YES completion:nil];
    
    self.tableView = nil;
}

- (IBAction)save:(id)sender
{
    NSMutableArray *allFiles = [Utilities arrayOfRouletteFiles];
    
    NSUInteger last = [allFiles count];
    
    allFiles = nil;
    
    NSString *filename = [NSString stringWithFormat:@"Roulette%02d.dat", (int)++last];
    
    self.selectedFilename = filename;
    
    //
    // create new file and save
    //
    [self archiveNumbers:_selectedFilename];
}

- (IBAction)loadFile
{
    [self archiveNumbers:_selectedFilename];
    
    if (_selectedFilename == nil) {
        self.selectedFilename = [Utilities lastFileName];
    }
    
    if (nil == _selectFileView) {
        _selectFileView = [[FileViewController alloc]
                          initWithNibName:@"FileViewController"
                          bundle:nil];
    }
    
    if (nil == _selectedFilename) {
        _selectedFilename = [Utilities lastFileName];
    }
    
//    self.selectFileView.selectedFilename = &(_selectedFilename);
    
    [self presentViewController:_selectFileView animated:YES completion:nil];
    
    //    self.selectFileView = nil;
}

- (IBAction)clearAll:(id)sender
{
    [_allNumbersDrawn removeAllObjects];
    
    [self resetScores];
}

#pragma mark -
#pragma mark -updating

-(void)updateCounter:(BOOL)flag index:(int)i
{
    if (!flag) {
        int count = [[_scoresCount objectAtIndex:i] intValue];
        count++;
        NSString *val = [[NSString alloc] initWithFormat:@"%d", count];
        [_scoresCount replaceObjectAtIndex:i withObject:val];
    }
    else {
        NSString *val = [[NSString alloc] initWithFormat:@"%d", 0];
        [_scoresCount replaceObjectAtIndex:i withObject:val];
        int count = [[_timesDrawn objectAtIndex:i] intValue];
        count++;
        [_timesDrawn replaceObjectAtIndex:i withObject:[[NSNumber alloc] initWithInt:count]];
    }
}

-(void)updateProbability:(BOOL)flag1
                  index1:(int)i1
          andProbability:(BOOL)flag2
                  index2:(int)i2
                  probab:(float)p
{
    int count = 0;
    
    if (flag1) {
        count = [[_scoresCount objectAtIndex:i2] intValue];
    }
    else if (flag2) {
        count = [[_scoresCount objectAtIndex:i1] intValue];
    }
    count++;
    
    float prob1 = [MyRouletteMath probability:p trials:count successes:count];
    float prob2 = 1 - [MyRouletteMath probability:1 - p trials:count successes:count];
    
    if (flag1) {
        NSString *val = [[NSString alloc] initWithFormat:@"%.4f", prob1];
        [_probabArray replaceObjectAtIndex:i1 withObject:val];
    }
    else {
        NSString *val = [[NSString alloc] initWithFormat:@"%.4f", prob2];
        [_probabArray replaceObjectAtIndex:i1 withObject:val];
    }
    
    if (flag2) {
        NSString *val = [[NSString alloc] initWithFormat:@"%.4f", prob1];
        [_probabArray replaceObjectAtIndex:i2 withObject:val];
    }
    else {
        NSString *val = [[NSString alloc] initWithFormat:@"%.4f", prob2];
        [_probabArray replaceObjectAtIndex:i2 withObject:val];
    }
}

-(void)updateProbability:(BOOL)flag1
                  index1:(int)index1
          andProbability:(BOOL)flag2
                  index2:(int)index2
          andProbability:(BOOL)flag3
                  index3:(int)index3
                  probab:(float)p
{
    int count1 = [[_scoresCount objectAtIndex:index1] intValue];
    int count2 = [[_scoresCount objectAtIndex:index2] intValue];
    int count3 = [[_scoresCount objectAtIndex:index3] intValue];
    
    int count = MAX(count1, count2);
    count = MAX(count, count3);
    count++;
    
    if (flag1) { // col1 was drawn
        float prob1 = [MyRouletteMath probability:p trials:2 successes:2];
        NSString *val = [[NSString alloc] initWithFormat:@"%.4f", prob1];
        [_probabArray replaceObjectAtIndex:index1 withObject:val];
    }
    else { // col2 or col3 was drawn
        float prob2 = 1 - [MyRouletteMath probability:p trials:count1 successes:0];
        //        for (int i=1; i<count; i++) {
        //            prob2 += [MyRouletteMath probability:1 - p trials:count successes:i];
        //        }
        NSString *val = [[NSString alloc] initWithFormat:@"%.4f", prob2];
        [_probabArray replaceObjectAtIndex:index1 withObject:val];
    }
    
    if (flag2) { // col2 was drawn
        float prob1 = [MyRouletteMath probability:p trials:2 successes:2];
        NSString *val = [[NSString alloc] initWithFormat:@"%.4f", prob1];
        [_probabArray replaceObjectAtIndex:index2 withObject:val];
    }
    else { // col1 or col3 was drawn
        float prob2 = 1 - [MyRouletteMath probability:p trials:count2 successes:0];
        //        for (int i=1; i<count; i++) {
        //            prob2 += [MyRouletteMath probability:1 - p trials:count successes:i];
        //        }
        NSString *val = [[NSString alloc] initWithFormat:@"%.4f", prob2];
        [_probabArray replaceObjectAtIndex:index2 withObject:val];
    }
    
    if (flag3) { // col3 was drawn
        float prob1 = [MyRouletteMath probability:p trials:2 successes:2];
        NSString *val = [[NSString alloc] initWithFormat:@"%.4f", prob1];
        [_probabArray replaceObjectAtIndex:index3 withObject:val];
    }
    else { // col1 or col2 was drawn
        float prob2 = 1 - [MyRouletteMath probability:p trials:count3 successes:0];
        //        for (int i=1; i<count; i++) {
        //            prob2 += [MyRouletteMath probability:1 - p trials:count successes:i];
        //        }
        NSString *val = [[NSString alloc] initWithFormat:@"%.4f", prob2];
        [_probabArray replaceObjectAtIndex:index3 withObject:val];
    }
    
}

-(void)updateFrequencies
{
    assert(_colorsFrequency);
    assert(_oddsFrequency);
    assert(_halvesFrequency);
    assert(_dozenFrequency);
    assert(_colorsFrequency);
    
    self.myBets = [Utilities myBets];
    
    self.cashColors = [Utilities updateColorFrequencies:_colorsFrequency
                                             allNumbers:_allNumbersDrawn
                                                   bets:_myBets];
    
    self.cashOdds = [Utilities updateOddFrequencies:_oddsFrequency
                                         allNumbers:_allNumbersDrawn
                                               bets:_myBets];
    
    self.cashHalves = [Utilities updateHalvesFrequencies:_halvesFrequency
                                              allNumbers:_allNumbersDrawn
                                                    bets:_myBets];
    
    self.cashDozens = [Utilities updateDozenFrequencies:_dozenFrequency
                                              allNumbers:_allNumbersDrawn
                                                    bets:_myBets];

    self.cashColumns = [Utilities updateColumnFrequencies:_columnFrequency
                                             allNumbers:_allNumbersDrawn
                                                   bets:_myBets];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	[textField resignFirstResponder];
    
	return YES;
}

#pragma mark -
#pragma mark -adding numbers

-(IBAction)addNumber:(UIButton *)sender
{
    NSString *number = [[sender titleLabel] text];
    
    self.counter++;
    
    //
    // Payout 1 : 1
    //
    BOOL black = [Utilities isBlack:number];
    [self updateCounter:black index:BLACKS];
    
    BOOL red = [Utilities isRed:number];
    [self updateCounter:red index:REDS];
    
    [self updateProbability:black
                     index1:BLACKS
             andProbability:red
                     index2:REDS
                     probab:0.47368];
    
    BOOL zero = (black || red) ? FALSE : TRUE;
    
    int num = [number intValue];
    
    BOOL even = (num % 2) == 0;
    [self updateCounter:even index:EVENS];
    
    BOOL odd = (!zero && !even) ? TRUE : FALSE;
    [self updateCounter:odd index:ODDS];
    
    [self updateProbability:even
                     index1:EVENS
             andProbability:odd
                     index2:ODDS
                     probab:0.47368];
    
    BOOL high = (num > 18) ? TRUE : FALSE;
    [self updateCounter:high index:HIGHS];
    
    BOOL low = (!zero && !high) ? TRUE : FALSE;
    [self updateCounter:low index:LOWS];
    
    [self updateProbability:high
                     index1:HIGHS
             andProbability:low
                     index2:LOWS
                     probab:0.47368];
    
    //
    // Payout 2 : 1
    //
    BOOL first = (!zero && num < 13) ? TRUE : FALSE;
    [self updateCounter:first index:FIRST12];
    
    BOOL second = (!zero && !first && num < 25) ? TRUE : FALSE;
    [self updateCounter:second index:SECOND12];
    
    BOOL third = (!zero && !first && !second) ? TRUE : FALSE;
    [self updateCounter:third index:THIRD12];
    
    [self updateProbability:first
                     index1:FIRST12
             andProbability:second
                     index2:SECOND12
             andProbability:third
                     index3:THIRD12
                     probab:0.31579];
    
    
    BOOL col1 = ((num % 3) == 1) ? TRUE : FALSE;
    [self updateCounter:col1 index:COLUMN0];
    
    BOOL col2 = ((num % 3) == 2) ? TRUE : FALSE;
    [self updateCounter:col2 index:COLUMN1];
    
    
    BOOL col3 = ((num % 3) == 0) ? TRUE : FALSE;
    [self updateCounter:col3 index:COLUMN2];
    
    [self updateProbability:col1
                     index1:COLUMN0
             andProbability:col2
                     index2:COLUMN1
             andProbability:col3
                     index3:COLUMN2
                     probab:0.31579];
    
    
    NSString *text = _history.text;
    //    NSLog(@"history.text: %@",text);
    
    if ([text isEqualToString:@""] && red) {
        _history.text = [text stringByAppendingFormat:@"%@", number];
        _history2.text = [text stringByAppendingFormat:@"%@", number];
    }
    else if ([text isEqualToString:@""] && black) {
        _history.text = [text stringByAppendingFormat:@"[%@]", number];
        _history2.text = [text stringByAppendingFormat:@"[%@]", number];
    }
    else if ([text isEqualToString:@""]) {
        _history.text = [text stringByAppendingFormat:@"*%@*", number];
        _history2.text = [text stringByAppendingFormat:@"*%@*", number];
    }
    else if (red) {
        _history.text = [text stringByAppendingFormat:@", %@", number];
        _history2.text = [text stringByAppendingFormat:@", %@", number];
    }
    else if (black) {
        _history.text = [text stringByAppendingFormat:@", [%@]", number];
        _history2.text = [text stringByAppendingFormat:@", [%@]", number];
    }
    else {
        _history.text = [text stringByAppendingFormat:@", *%@*", number];
        _history2.text = [text stringByAppendingFormat:@", *%@*", number];
    }
    
    assert(_allNumbersDrawn);
    
    [_allNumbersDrawn addObject:number];
    
    [self increaseNotDrawn];
    
    //    if (sender == btn0) {
    if (![number compare:@"0"]) {
        [_notDrawnFor replaceObjectAtIndex:0 withObject:[[NSNumber alloc] initWithInt:0]];
    }
    //    else if (sender == btn00) {
    else if (![number compare:@"00"]) {
        [_notDrawnFor replaceObjectAtIndex:37 withObject:[[NSNumber alloc] initWithInt:0]];
    }
    else {
        //        int index = [[[sender titleLabel] text] intValue];
        int index = [number intValue];
        [_notDrawnFor replaceObjectAtIndex:index withObject:[[NSNumber alloc] initWithInt:0]];
    }
    
    [self makeRangeVisible];
    
    [self viewStats];
}

-(void)addNextNumber:(NSString *)number toText:(NSString **)text
{
    _counter++;
    
    BOOL black = [Utilities isBlack:number];
    [self updateCounter:black index:BLACKS];
    
    BOOL red = [Utilities isRed:number];
    [self updateCounter:red index:REDS];
    
    if ([*text isEqualToString:@""] && red) {
        *text = [*text stringByAppendingFormat:@"%@", number];
    }
    else if ([*text isEqualToString:@""] && black) {
        *text = [*text stringByAppendingFormat:@"[%@]", number];
    }
    else if ([*text isEqualToString:@""]) {
        *text = [*text stringByAppendingFormat:@"*%@*", number];
    }
    else if (red) {
        *text = [*text stringByAppendingFormat:@", %@", number];
    }
    else if (black) {
        *text = [*text stringByAppendingFormat:@", [%@]", number];
    }
    else {
        *text = [*text stringByAppendingFormat:@", *%@*", number];
    }
}

#pragma mark -
#pragma mark -recalculating numbers

-(void)recalculateAllNumbers
{
    [self resetScores];
    
    for (NSString *number in _allNumbersDrawn)
    {
        BOOL black = [Utilities isBlack:number];
        [self updateCounter:black index:BLACKS];
        
        BOOL red = [Utilities isRed:number];
        [self updateCounter:red index:REDS];
        
        [self updateProbability:black
                         index1:BLACKS
                 andProbability:red
                         index2:REDS
                         probab:0.47368];
        
        BOOL zero = (black || red) ? FALSE : TRUE;
        
        int num = [number intValue];
        
        BOOL even = (num % 2) == 0;
        [self updateCounter:even index:EVENS];
        
        BOOL odd = (!zero && !even) ? TRUE : FALSE;
        [self updateCounter:odd index:ODDS];
        
        [self updateProbability:even
                         index1:EVENS
                 andProbability:odd
                         index2:ODDS
                         probab:0.47368];
        
        BOOL high = (num > 18) ? TRUE : FALSE;
        [self updateCounter:high index:HIGHS];
        
        BOOL low = (!zero && !high) ? TRUE : FALSE;
        [self updateCounter:low index:LOWS];
        
        [self updateProbability:high
                         index1:HIGHS
                 andProbability:low
                         index2:LOWS
                         probab:0.47368];
        //
        // Payout 2 : 1
        //
        BOOL first = (!zero && num < 13) ? TRUE : FALSE;
        [self updateCounter:first index:FIRST12];
        
        BOOL second = (!zero && !first && num < 25) ? TRUE : FALSE;
        [self updateCounter:second index:SECOND12];
        
        BOOL third = (!zero && !first && !second) ? TRUE : FALSE;
        [self updateCounter:third index:THIRD12];
        
        [self updateProbability:first
                         index1:FIRST12
                 andProbability:second
                         index2:SECOND12
                 andProbability:third
                         index3:THIRD12
                         probab:0.31579];
        
        
        BOOL col1 = ((num % 3) == 1) ? TRUE : FALSE;
        [self updateCounter:col1 index:COLUMN0];
        
        BOOL col2 = ((num % 3) == 2) ? TRUE : FALSE;
        [self updateCounter:col2 index:COLUMN1];
        
        BOOL col3 = ((num % 3) == 0) ? TRUE : FALSE;
        [self updateCounter:col3 index:COLUMN2];
        
        [self updateProbability:col1
                         index1:COLUMN0
                 andProbability:col2
                         index2:COLUMN1
                 andProbability:col3
                         index3:COLUMN2
                         probab:0.31579];
        
        [self increaseNotDrawn];
        
        //    if (sender == btn0) {
        if (![number compare:@"0"]) {
            [_notDrawnFor replaceObjectAtIndex:0 withObject:[[NSNumber alloc] initWithInt:0]];
        }
        //    else if (sender == btn00) {
        else if (![number compare:@"00"]) {
            [_notDrawnFor replaceObjectAtIndex:37 withObject:[[NSNumber alloc] initWithInt:0]];
        }
        else {
            //        int index = [[[sender titleLabel] text] intValue];
            int index = [number intValue];
            [_notDrawnFor replaceObjectAtIndex:index withObject:[[NSNumber alloc] initWithInt:0]];
        }
    }
    
    [self updateFrequencies];
    
    [self makeRangeVisible];
}

-(void)makeRangeVisible
{
    if (_portret) {
        NSInteger len = [_history.text length];
        NSRange range = NSMakeRange(len - 1, 1);
        
        self.history.selectedRange = range;
        [_history scrollRangeToVisible:range];
        
        self.history.scrollEnabled = YES;
    }
    else {
        NSInteger len = [_history2.text length];
        NSRange range = NSMakeRange(len - 1, 1);
        
        self.history2.selectedRange = range;
        [_history2 scrollRangeToVisible:range];
        
        self.history2.scrollEnabled = YES;
    }
}

-(void)increaseNotDrawn
{
    for (int i=0; i<38; i++) {
        NSNumber *numb = [_notDrawnFor objectAtIndex:i];
        int val = [numb intValue];
        val++;
        [_notDrawnFor replaceObjectAtIndex:i withObject:[[NSNumber alloc] initWithInt:val]];
    }
}

- (void)resetScores
{
    _counter = 0;
    
    for (int i=0; i<38; i++)
    {
        [_notDrawnFor replaceObjectAtIndex:i withObject:[[NSNumber alloc] initWithInt:0]];
    }
    
    for (int i=0; i<LAST; i++)
    {
        [_scoresCount replaceObjectAtIndex:i withObject:@"0"];
        [_probabArray replaceObjectAtIndex:i withObject:@"0.01"];
        [_timesDrawn replaceObjectAtIndex:i withObject:[[NSNumber alloc] initWithInt:0]];
    }
    
//    self.history.text = @"";
//    self.history2.text = @"";
}

#pragma mark -
#pragma mark -View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    if (_allNumbersDrawn == nil) {
        self.allNumbersDrawn = [[NSMutableArray alloc] init];
    }
    
    if (_notDrawnFor == nil)
    {
        _notDrawnFor = [[NSMutableArray alloc] init];
        for (int i=0; i<38; i++) {
            [_notDrawnFor addObject:[[NSNumber alloc] initWithInt:0]];
        }
    }
    
    if (_scoresCount == nil)
    {
        _scoresCount = [[NSMutableArray alloc] init];
        for (int i=0; i<LAST; i++) {
            [_scoresCount addObject:@"0"];
        }
    }
    
    if (_probabArray == nil)
    {
        _probabArray = [[NSMutableArray alloc] init];
        for (int i=0; i<LAST; i++) {
            [_probabArray addObject:@"0.01"];
        }
    }
    
    if (_timesDrawn == nil)
    {
        _timesDrawn = [[NSMutableArray alloc] init];
        for (int i=0; i<LAST; i++) {
            [_timesDrawn addObject:[[NSNumber alloc] initWithInt:0]];
        }
    }
    
    if (_colorsFrequency == nil)
    {
        _colorsFrequency = [[NSMutableArray alloc] init];
        for (int i=0; i<ALL_THE_REST; i++) {
            [_colorsFrequency addObject:[[NSNumber alloc] initWithInt:0]];
        }
    }
    
    if (_oddsFrequency == nil)
    {
        _oddsFrequency = [[NSMutableArray alloc] init];
        for (int i=0; i<ALL_THE_REST; i++) {
            [_oddsFrequency addObject:[[NSNumber alloc] initWithInt:0]];
        }
    }
    
    if (_halvesFrequency == nil)
    {
        _halvesFrequency = [[NSMutableArray alloc] init];
        for (int i=0; i<ALL_THE_REST; i++) {
            [_halvesFrequency addObject:[[NSNumber alloc] initWithInt:0]];
        }
    }
    
    if (_dozenFrequency == nil) {
        _dozenFrequency = [[NSMutableArray alloc] init];
        for (int i=0; i<ALL_THE_REST; i++) {
            [_dozenFrequency addObject:[[NSNumber alloc] initWithInt:0]];
        }
    }
    
    if (_columnFrequency == nil) {
        _columnFrequency = [[NSMutableArray alloc] init];
        for (int i=0; i<ALL_THE_REST; i++) {
            [_columnFrequency addObject:[[NSNumber alloc] initWithInt:0]];
        }
    }
    
    if (_allNumbersDrawn) {
        
    }
    
    self.myBets = [Utilities myBets];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    [self resetScores];
    
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
    if (_selectedFilename == nil) {
        self.selectedFilename = [Utilities lastFileName];
    }
    
    NSString *docPath = [Utilities archivePath];
    
    NSString *filePath = [docPath stringByAppendingPathComponent:_selectedFilename];
    
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if ([fileManager fileExistsAtPath:filePath])
    {
		self.allNumbersDrawn = [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
    }
    
    if (nil == _allNumbersDrawn) {
        _allNumbersDrawn = [[NSMutableArray alloc] init];
    }
    
    [self makeRangeVisible];
	
    //
    // redo all numbers
    //
    [self resetScores];
    
    NSString *text = [[NSString alloc] init];
    
    for (NSString *number in _allNumbersDrawn) {
        [self addNextNumber:number toText:&text];
    }
    
    self.history.text = text;
    self.history2.text = text;
    
    [self recalculateAllNumbers];
    
//    [pool drain];
    
    
    //
    // redo all numbers
    //
    self.counter = 0;
    //
    CGSize size = _history.frame.size;
    size.height *= 2.0;
    self.history.contentSize = size;
    self.history.showsVerticalScrollIndicator = YES;
    
    CGSize size2 = _history2.frame.size;
    size2.height *= 2.0;
    self.history2.contentSize = size2;
    self.history2.showsVerticalScrollIndicator = YES;
    
    
    [self makeRangeVisible];
    
//    [self updateFrequencies];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.portretView = nil;
    self.landscapeView = nil;
}

//- (void)dealloc
//{
//    [portretView release];
//    [landscapeView release];
//    
//    [super dealloc];
//}

#pragma mark -
#pragma mark -Orientation

//-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//    
//    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
//        self.view = _portretView;
//        self.portret = true;
//        
//        self.view.transform = CGAffineTransformMakeRotation(0);
//        self.view.bounds = CGRectMake(0.0, 0.0, 460.0, 320.0);
//        [self makeRangeVisible];
//    }
//    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
//        self.view = _landscapeView;
//        self.portret = false;
//        
//        self.view.transform = CGAffineTransformMakeRotation(deg2rad * (-90));
//        self.view.bounds = CGRectMake(0.0, 0.0, 300.0, 480.0);
//        [self makeRangeVisible];
//    }
//    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
//        self.view = _landscapeView;
//        self.portret = false;
//        
//        self.view.transform = CGAffineTransformMakeRotation(deg2rad * 90);
//        self.view.bounds = CGRectMake(0.0, 0.0, 300.0, 480.0);
//        [self makeRangeVisible];
//    }
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
//            interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
//            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
//}

@end
