//
//  MyRouletteStatsTableView.m
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyRouletteStatsTableView.h"

#import "Utilities.h"


@interface MyRouletteStatsTableView ()

@end

@implementation MyRouletteStatsTableView

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)setScores:(NSMutableArray *)scores
{
    self.scoresCount = scores;
    //self.probArray = prob;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewDidAppear:(BOOL)animated 
{
    [super viewDidAppear:animated];
    
    self.myBets = [Utilities myBets];

	// Do any additional setup after loading the view, typically from a nib.
//    if (timesDrawn) {
//        self.totalDraws = [[timesDrawn objectAtIndex:BLACKS] intValue] + [[timesDrawn objectAtIndex:REDS] intValue] + [[timesDrawn objectAtIndex:ZEROS] intValue];
//    }
    double blacks = [[_probabArray objectAtIndex:BLACKS] doubleValue];
    double reds = [[_probabArray objectAtIndex:REDS] doubleValue];
    NSString *betColors = nil;
    if (blacks > reds) {
        betColors = [NSString stringWithFormat:@"Bet %d on BLACKS",[self betNow:blacks]];
    }
    else {
        betColors = [NSString stringWithFormat:@"Bet %d on REDS",[self betNow:reds]];
    }
    
    NSString *betOdd = nil;
    double odds = [[_probabArray objectAtIndex:ODDS] doubleValue];
    double evens = [[_probabArray objectAtIndex:EVENS] doubleValue];
    if (odds > evens) {
        betOdd = [NSString stringWithFormat:@"Bet %d on ODD",[self betNow:odds]];
    }
    else {
        betOdd = [NSString stringWithFormat:@"Bet %d on EVEN",[self betNow:evens]];
    }
    
    NSString *betHigh = nil;
    double highs = [[_probabArray objectAtIndex:HIGHS] doubleValue];
    double lows = [[_probabArray objectAtIndex:LOWS] doubleValue];
    if (highs > lows) {
        betHigh = [NSString stringWithFormat:@"Bet %d on HIGH",[self betNow:highs]];
    }
    else {
        betHigh = [NSString stringWithFormat:@"Bet %d on LOW",[self betNow:lows]];
    }
    
    NSString *betDozen = nil;
    double first = [[_probabArray objectAtIndex:FIRST12] doubleValue];
    double second = [[_probabArray objectAtIndex:SECOND12] doubleValue];
    double third = [[_probabArray objectAtIndex:THIRD12] doubleValue];
    if (first >= second && first >= third) {
        betDozen = [NSString stringWithFormat:@"Bet %d on DOZ: 1-12",[self betNow:first]];
    }
    if (second >= first && second >= third) {
        betDozen = [NSString stringWithFormat:@"Bet %d on DOZ: 13-24",[self betNow:second]];
    }
    if (third >= first && third >= second) {
        betDozen = [NSString stringWithFormat:@"Bet %d on DOZ: 25-36",[self betNow:third]];
    }
    
    NSString *betColumn = nil;
    double column0 = [[_probabArray objectAtIndex:COLUMN0] doubleValue];
    double column1 = [[_probabArray objectAtIndex:COLUMN1] doubleValue];
    double column2 = [[_probabArray objectAtIndex:COLUMN2] doubleValue];
    if (column0 >= column1 && column0 >= column2) {
        betColumn = [NSString stringWithFormat:@"Bet %d on COL: 1-34",[self betNow:column0]];
    }
    if (column1 >= column0 && column1 >= column2) {
        betColumn = [NSString stringWithFormat:@"Bet %d on COL: 2-35",[self betNow:column1]];
    }
    if (column2 >= column0 && column2 >= column1) {
        betColumn = [NSString stringWithFormat:@"Bet %d on COL: 3-36",[self betNow:column2]];
    }
    
    NSMutableString *message = [[NSMutableString alloc] init];
    [message appendString:betColors];
    [message appendString:@"\n"];
    [message appendString:betOdd];
    [message appendString:@"\n"];
    [message appendString:betHigh];
    [message appendString:@"\n"];
    [message appendString:betDozen];
    [message appendString:@"\n"];
    [message appendString:betColumn];
    
    UIAlertView *alertView =
    [[UIAlertView alloc] initWithTitle:@"PLAY NOW:"
                               message:message
                              delegate:self
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil];
    
    [alertView show];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (int)betNow:(double)prob
{
    int min = [_myBets.bet01 intValue];
    
    int bet = 0;
    if (prob > 0.9998) {
        bet = min*2048;
    }
    else if (prob > 0.9997) {
        bet = min*1024;
    }
    else if (prob > 0.9994) {
        bet = min*512;
    }
    else if (prob > 0.998) {
        bet = min*256;
    }
    else if (prob > 0.997) {
        bet = min*128;
    }
    else if (prob > 0.994) {
        bet = min*64;
    }
    else if (prob > 0.98) {
        bet = min*32;
    }
    else if (prob > 0.97) {
        bet = min*16;
    }
    else if (prob > 0.94) {
        bet = min*8;
    }
    else if (prob > 0.89) {
        bet = min*4;
    }
    else if (prob > 0.77) {
        bet = min*2;
    }
    else if (prob > 0.52) {
        bet = min*1;
    }

    return bet;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    int rows = 0;
    switch (section) {
        case 0:
            rows = 6;
            break;
        case 1:
            rows = 6;
        default:
            break;
    }
    return rows;
}

- (int)percentage:(int)index
{
    float perc = 0;
    
//    if (totalDraws == 0) {
//        self.totalDraws = [[timesDrawn objectAtIndex:BLACKS] intValue] + [[timesDrawn objectAtIndex:REDS] intValue] + [[timesDrawn objectAtIndex:ZEROS] intValue];
//    }
    
    if (_totalDraws > 0) {
        int times = [[_timesDrawn objectAtIndex:index] intValue];
        
        perc = ((float)times / _totalDraws) * 100;
    }
    
    return perc;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    self.cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil] lastObject];
    
    // Configure the cell...
	int index = indexPath.row;
    int section = indexPath.section;
    
    UILabel *text1 = (UILabel *)[_cell viewWithTag:101];
    UILabel *text2 = (UILabel *)[_cell viewWithTag:102];
    UILabel *text3 = (UILabel *)[_cell viewWithTag:103];
   
    NSString *text;
    NSString *prob;

    if (section == 0) {
        switch (index) {
            case BLACKS:
                text1.text = @"Black";
                text = [_scoresCount objectAtIndex:BLACKS];
                text = [text stringByAppendingFormat:@" (%d%%)", 
                        [self percentage:BLACKS]];
                prob = [_probabArray objectAtIndex:BLACKS];
                break;
            case REDS:
                text1.text = @"Red";
                text = [_scoresCount objectAtIndex:REDS];
                text = [text stringByAppendingFormat:@" (%d%%)",
                        [self percentage:REDS]];
                prob = [_probabArray objectAtIndex:REDS];
                break;
            case EVENS:
                text1.text = @"Even";
                text = [_scoresCount objectAtIndex:EVENS];
                text = [text stringByAppendingFormat:@" (%d%%)",
                        [self percentage:EVENS]];
                prob = [_probabArray objectAtIndex:EVENS];
                break;
            case ODDS:
                text1.text = @"Odd";
                text = [_scoresCount objectAtIndex:ODDS];
                text = [text stringByAppendingFormat:@" (%d%%)",
                        [self percentage:ODDS]];
                prob = [_probabArray objectAtIndex:ODDS];
                break;
            case HIGHS:
                text1.text = @"High 19-36";
                text = [_scoresCount objectAtIndex:HIGHS];
                text = [text stringByAppendingFormat:@" (%d%%)",
                        [self percentage:HIGHS]];
                prob = [_probabArray objectAtIndex:HIGHS];
                break;
            case LOWS:
                text1.text = @"Low 1-18";
                text = [_scoresCount objectAtIndex:LOWS];
                text = [text stringByAppendingFormat:@" (%d%%)",
                        [self percentage:LOWS]];
                prob = [_probabArray objectAtIndex:LOWS];
                break;
            default:
                break;
        }
    }
    else if (section == 1)
    {
        switch (index) {
            case FIRST12-FIRST12:
                text1.text = @"Dozen 1-12";
                text = [_scoresCount objectAtIndex:FIRST12];
                text = [text stringByAppendingFormat:@" (%d%%)",
                        [self percentage:FIRST12]];
                prob = [_probabArray objectAtIndex:FIRST12];
                break;
            case SECOND12-FIRST12:
                text1.text = @"Dozen 13-24";
                text = [_scoresCount objectAtIndex:SECOND12];
                text = [text stringByAppendingFormat:@" (%d%%)",
                        [self percentage:SECOND12]];
                prob = [_probabArray objectAtIndex:SECOND12];
                break;
            case THIRD12-FIRST12:
                text1.text = @"Dozen 25-36";
                text = [_scoresCount objectAtIndex:THIRD12];
                text = [text stringByAppendingFormat:@" (%d%%)",
                        [self percentage:THIRD12]];
                prob = [_probabArray objectAtIndex:THIRD12];
                break;
            case COLUMN0-FIRST12:
                text1.text = @"Column 1-34";
                text = [_scoresCount objectAtIndex:COLUMN0];
                text = [text stringByAppendingFormat:@" (%d%%)",
                        [self percentage:COLUMN0]];
                prob = [_probabArray objectAtIndex:COLUMN0];
                break;
            case COLUMN1-FIRST12:
                text1.text = @"Column 2-35";
                text = [_scoresCount objectAtIndex:COLUMN1];
                text = [text stringByAppendingFormat:@" (%d%%)",
                        [self percentage:COLUMN1]];
                prob = [_probabArray objectAtIndex:COLUMN1];
                break;
            case COLUMN2-FIRST12:
                text1.text = @"Column 3-36";
                text = [_scoresCount objectAtIndex:COLUMN2];
                text = [text stringByAppendingFormat:@" (%d%%)",
                        [self percentage:COLUMN2]];
                prob = [_probabArray objectAtIndex:COLUMN2];
                break;
                
            default:
                break;
        }
    }
    
    text2.text = text;
    text3.text = prob;
    
    double probability = [prob doubleValue];
    if (probability > 0.95) {
        _cell.contentView.backgroundColor = [UIColor redColor];
    }
    else if (probability > 0.9) {
        _cell.contentView.backgroundColor = [UIColor yellowColor];
    }
    else if (probability > 0.6) {
        _cell.contentView.backgroundColor = [UIColor greenColor];
    }
    _cell.contentView.alpha = 0.65;
    
    return _cell;
}

- (IBAction)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)enterEditMode
{
    _bEditing = _bEditing == false ? true : false;
    
    if (_bEditing) {
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    }
    
    [self.tableView setEditing:_bEditing animated:YES];
    
}

#pragma mark -
#pragma mark -row

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

#pragma mark -
#pragma mark -header

// specify the height of your footer section
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section 
{
	
    //differ between your sections or if you
    //have only on section return a static value
    return 32;
}

// Notice: this will work only for one section within the table view
- (UIView *)tableView:(UITableView *)tableView 
viewForHeaderInSection:(NSInteger)section 
{
    switch (section) {
        case 0:
            self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"Header" owner:self options:nil] lastObject];
            break;
        case 1:
            self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"Header2" owner:self options:nil] lastObject];
            break;
            
        default:
            break;
    }
    
	//return the view for the footer
	return _headerView;
}

#pragma mark -
#pragma mark -footer

// specify the height of your footer section
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	
    //differ between your sections or if you
    //have only on section return a static value
    int height = 0;
    switch (section) {
        case 0:
            break;
        case 1:
            height = 34;
            break;
        default:
            break;
    }
	
    return height;
}

// custom view for footer. will be adjusted to default or specified footer height
// Notice: this will work only for one section within the table view
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section 
{
    switch (section) {
        case 0:
            self.footerView = nil;
            break;
        case 1:
            self.footerView = [[[NSBundle mainBundle] loadNibNamed:@"Footer" owner:self options:nil] lastObject];
        default:
            break;
    }
    
    //return the view for the footer
    return _footerView;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}


@end
