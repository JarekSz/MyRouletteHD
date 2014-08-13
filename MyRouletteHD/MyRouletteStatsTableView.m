//
//  MyRouletteStatsTableView.m
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyRouletteStatsTableView.h"

@interface MyRouletteStatsTableView ()

@end

@implementation MyRouletteStatsTableView


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
    
	// Do any additional setup after loading the view, typically from a nib.
//    if (timesDrawn) {
//        self.totalDraws = [[timesDrawn objectAtIndex:BLACKS] intValue] + [[timesDrawn objectAtIndex:REDS] intValue] + [[timesDrawn objectAtIndex:ZEROS] intValue];
//    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    
	[self dismissModalViewControllerAnimated:NO];    
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
