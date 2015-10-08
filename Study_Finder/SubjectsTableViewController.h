//
//  SubjectsTableViewController.h
//  Study_Finder
//
//  Created by Rich Blanchard on 9/25/15.
//  Copyright © 2015 Rich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SubjectsTableViewController : UITableViewController
@property (nonatomic,strong) NSMutableArray * subjectsArray;
@property (nonatomic,strong) PFObject * classClicked;
@property (nonatomic,strong) PFObject * subjectClicked;
@property (nonatomic,strong) NSSet * subjectSet;
@property (nonatomic,strong) NSArray * classmates;

@end
