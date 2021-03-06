//
//  SearchClassesViewController.m
//  Study_Finder
//
//  Created by Rich Blanchard on 9/23/15.
//  Copyright © 2015 Rich. All rights reserved.
//

#import "SearchClassesViewController.h"
#import "ClassMapper.h"
#import <Parse/Parse.h>
#import <KBRoundedButton.h>
#import "ParseDetails.h"
#import "OrderedDictionary.h"


@interface SearchClassesViewController ()
@property (weak, nonatomic) IBOutlet UITextField *classNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *classNumberTwoTextField;
@property (weak, nonatomic) IBOutlet KBRoundedButton *roundedButton;

@end

@implementation SearchClassesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpController];
    [self getMessages];
       
    
    
    // Do any additional setup after loading the view.
}
- (IBAction)search:(id)sender {
    NSMutableString * userSearch = [[NSMutableString alloc]init];
    [userSearch appendString:self.classNumberTextField.text];
    [userSearch appendString:self.classNumberTwoTextField.text];
    NSString * classFound = [ClassMapper hookUpClasses:userSearch];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Your Class" message:[NSString stringWithFormat:@"%@",classFound] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * yes = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        NSLog(@"Current user is %@",[PFUser currentUser]);
        [ClassMapper matchSearchWithClass:userSearch];
        
    }];
    [alertController addAction:yes];
    [self presentViewController:alertController animated:YES completion:nil];
    
   
}
-(void)setUpController {
    [self.navigationItem setHidesBackButton:YES animated:YES];
    [self.roundedButton setTitleColorForStateNormal:[UIColor blackColor]];
    [self.roundedButton setBackgroundColorForStateNormal:[UIColor colorWithRed:196.0/255.0 green:171.0/255.0 blue:105.0/255.0 alpha:1.0]];
    [self.roundedButton setTitle:@"Search" forState:UIControlStateNormal];
}
-(void)getMessages
{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        ParseDetails * parseDetails = [ParseDetails sharedParseDetails];
        NSMutableArray * checker = [parseDetails.parseDetails objectForKey:@"indexedSubjects"];
       
        for(int i = 0; i < checker.count; i++) {
             NSMutableArray * arrayOfArraysForMessages = [[NSMutableArray alloc]init];
            
            NSDictionary * dictForIndex = checker[i];
            NSArray * subjects = [dictForIndex valueForKey:@"subjects"];
            for(int j = 0; j < subjects.count; j++) {
                  NSMutableArray * postedBys = [[NSMutableArray alloc]init];
                PFObject * indxedSubject = subjects[j];
                PFRelation * messageForSubject = [indxedSubject relationForKey:@"Messages"];
                PFQuery * getMessages = [messageForSubject query];
                NSArray * messages = [getMessages findObjects];
                NSArray * potentialArray;
                OrderedDictionary * OrderedDict = [[OrderedDictionary alloc]init];
                if(messages.count ==0) {
                    potentialArray = [NSArray array];
                }
                else {
                    potentialArray = [getMessages findObjects];
                    for( PFObject * message in potentialArray) {
                        PFRelation * postedBy = message[@"postedBy"];
                        PFQuery * findUser = [postedBy query];
                        PFUser * user = [findUser getFirstObject];
                        NSLog(@"userName is %@",user[@"username"]);
                        [postedBys addObject:user];
                    }
                    [OrderedDict insertObject:potentialArray forKey:@"Messages" atIndex:0];
                    [OrderedDict insertObject:postedBys forKey:@"postedBy" atIndex:0];
                }
                [arrayOfArraysForMessages addObject:OrderedDict];
            }
            [dictForIndex setValue:arrayOfArraysForMessages forKey:@"Messages"];
            NSLog(@"arrayOfArrays = %d",arrayOfArraysForMessages.count);
        }
    });
}




@end
