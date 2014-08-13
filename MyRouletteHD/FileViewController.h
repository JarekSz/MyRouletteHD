//
//  FileViewController.h
//  MyRoulette
//
//  Created by Jaroslaw Szymczyk on 8/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Utilities.h"

@interface FileViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextView *FileDirectory;
@property (retain, nonatomic) IBOutlet UITextView *NumbersDrawn;
@property (retain, nonatomic) IBOutlet UITextField *FileNameText;
@property (assign, nonatomic) NSString * __autoreleasing *selectedFilename;
//@property int fileNumber;
@property (retain, nonatomic) NSMutableArray *allNumbersDrawn;


-(void)addNextNumber:(NSString *)number toText:(NSString **)text;
-(NSString *)archiveFilePath:(int)number;
//-(IBAction)archiveNumbers;
//-(IBAction)unarchiveNumbers;
//-(NSMutableArray *)arrayOfRouletteFiles;
-(void)showAllFiles;
//-(IBAction)fileNumberEntered:(id)sender;
-(IBAction)goBack;
-(IBAction)nextFile:(id)sender;
-(IBAction)prevFile:(id)sender;
-(IBAction)deleteFile:(id)sender;

@end
