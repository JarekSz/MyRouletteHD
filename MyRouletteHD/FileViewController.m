//
//  FileViewController.m
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 8/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FileViewController.h"

@interface FileViewController ()

@end

@implementation FileViewController

@synthesize FileDirectory;
@synthesize NumbersDrawn;
@synthesize FileNameText;
@synthesize selectedFilename;
//@synthesize fileNumber;
@synthesize allNumbersDrawn;


-(IBAction)goBack 
{    
//    int number = [[FileNameText text] intValue];
    
    *selectedFilename = [FileNameText text];
    
	[self dismissModalViewControllerAnimated:NO];
}

-(IBAction)nextFile:(id)sender
{
    int index = [Utilities indexOfSelectedFile:*selectedFilename];
    
    NSMutableArray  *allFiles = [Utilities arrayOfRouletteFiles];
    
    int max = [allFiles count];
 
    if (max > 0) {
        int last = max - 1;
        if (index < last) {
            index++;
        }
        
        *selectedFilename = [allFiles objectAtIndex:index];
        
        FileNameText.text = *selectedFilename;
        
        NSString *docPath = [Utilities archivePath];
        
        NSString *filePath = [docPath stringByAppendingPathComponent:*selectedFilename];
        
        [self showNumbersFromFile:filePath];
    }
    
    allFiles = nil;
}

-(IBAction)prevFile:(id)sender
{
    int index = [Utilities indexOfSelectedFile:*selectedFilename];
    
    if (index > 0) {
        index--;
    }
    
    NSMutableArray  *allFiles = [Utilities arrayOfRouletteFiles];
    
    int max = [allFiles count];
    
    if (max > 0)
    {
        *selectedFilename = [allFiles objectAtIndex:index];
        
        FileNameText.text = *selectedFilename;
        
        NSString *docPath = [Utilities archivePath];
        
        NSString *filePath = [docPath stringByAppendingPathComponent:*selectedFilename];
        
        [self showNumbersFromFile:filePath];
    }
    
    allFiles = nil;
}

- (IBAction)deleteFile:(id)sender
{
    NSMutableArray  *allFiles = [Utilities arrayOfRouletteFiles];
    
    int index = [Utilities indexOfSelectedFile:*selectedFilename];
    
    NSString *docPath = [Utilities archivePath];
    
    NSString *filePath = [docPath stringByAppendingPathComponent:*selectedFilename];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    BOOL success; // = [fileManager removeItemAtPath:filePath error:&error];
    NSDictionary *attrib;
    if ([fileManager fileExistsAtPath:filePath])
    {
        // UNLOCK THE FILE
        attrib = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                             forKey:NSFileImmutable];
        [fileManager setAttributes:attrib
                      ofItemAtPath:filePath
                             error:&error];
        // DELETE IT
        success = [fileManager removeItemAtPath:filePath
                                          error:&error];
        
        [allFiles removeObject:*selectedFilename];
    }
    
    [self showAllFiles];
    
    if (index > 0) {
        index--;
        
        *selectedFilename = [allFiles objectAtIndex:index];
    }
    else if (index < [allFiles count]) {
        index++;
        
        *selectedFilename = [allFiles objectAtIndex:index];
    }
    else {
        *selectedFilename = @"";
    }
    
    allFiles = nil;
    
    FileNameText.text = *selectedFilename;
}

- (NSString *)archiveFilePath:(int)number
{    
	NSString *docDir = [Utilities archivePath];
    
    NSString *filename = [NSString stringWithFormat:@"Roulette%02d.dat", number];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:filename];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    int count = 1;
    BOOL exist;
    exist = [fileManager fileExistsAtPath:filePath];
    
    if (NO == exist) {
        // if it doesn't exist start with one and get the latest
        do {
            exist = [fileManager fileExistsAtPath:filePath];
            if (YES == exist)
            {
                filename = [NSString stringWithFormat:@"Roulette%02d.dat", count];
                filePath = [docDir stringByAppendingPathComponent: filename];
                count++;
            }
        } while (exist);
    }

    
	return filePath;
}

-(void)showAllFiles
{
    FileDirectory.text = @"";
    
    NSString *directory = [[NSString alloc] init];

    NSMutableArray  *allFiles = [Utilities arrayOfRouletteFiles];
    
    for (NSString *filename in allFiles)
    {
        directory = [directory stringByAppendingString:filename];
        directory = [directory stringByAppendingString:@"\n"];
    }
    
    allFiles = nil;
    
    FileDirectory.text = directory;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)showNumbersFromFile:(NSString *)filePath
{
    NumbersDrawn.text = @"";
    
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if ([fileManager fileExistsAtPath:filePath])
    {
		self.allNumbersDrawn = [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
    }
    
    NSString *text = [[NSString alloc] init];
    
    for (NSString *number in allNumbersDrawn) {
        [self addNextNumber:number toText:&text];
    }
    
    NumbersDrawn.text = text;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showAllFiles];
    
    FileNameText.text = *selectedFilename;
    
    NumbersDrawn.text = @"";
    
    NSString *docPath = [Utilities archivePath];
    
    NSString *filePath = [docPath stringByAppendingPathComponent:*selectedFilename];
    
    [self showNumbersFromFile:filePath];
}

-(void)addNextNumber:(NSString *)number toText:(NSString **)text
{
//    counter++;
//
    BOOL black = [Utilities isBlack:number];
//    [self updateCounter:black index:BLACKS];
    
    BOOL red = [Utilities isRed:number];
//    [self updateCounter:red index:REDS];
    
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

- (void)viewDidUnload
{
    [self setFileDirectory:nil];
    [self setNumbersDrawn:nil];
    [self setFileNameText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//- (void)dealloc {
//    [FileDirectory release];
//    [NumbersDrawn release];
//    [FileNameText release];
//    [super dealloc];
//}
@end