//
//  ClassMapper.h
//  Study_Finder
//
//  Created by Rich Blanchard on 9/23/15.
//  Copyright © 2015 Rich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


@interface ClassMapper : NSObject
@property NSMutableArray *userClasses;
+(NSDictionary *)MakeDictionary;
+(NSArray *)create;
+(NSString *)hookUpClasses:(NSString *)userClassSearch;
+(void )matchSearchWithClass:(NSString *)userSearch;
- (void)getClasses:(void(^)(NSMutableArray * who))completionHandler;
+(NSString *)getUserName:(PFUser *)currentUser;
+(void)saveSubject:(PFObject *)classToCheck WithSubject:(NSString *)subjectToSave refreshTableView:(UITableView *)tableView;
+ (void)getSubjects:(PFObject *)classToSearch block:(void(^)(NSArray * parseReturnedSubjects))completionHandler;
+ (void)getMessages:(PFObject *)subjectsToSearch block:(void(^)(NSArray * parseReturnedMessages))completionHandler;
+(void)updateImage:(PFUser *)currentUser withPhoto:(UIImage *)profilePic;
+ (void)getProfilePictureFromParse:(PFUser *)currentUser block:(void(^)(NSData * imageReturnedAsData))completionHandler;
+(void)saveUserLocation:(CLLocation *)currentLocation forUser:(PFUser *)currentUser;
+(void)getClassmates:(PFObject *)class block:(void (^)(NSArray * parseReturnedClassmates))completionHandler;
+(void)getInbox:(PFUser *)User block:(void (^)(NSArray * parseReturnedClassmates))completionHandler;
+(void)cacheDictForGroups:(PFObject *)class block:(void (^)(NSMutableDictionary * cacheDict))completionHandler;
+(void)getOnlyTheUsersGroups:(NSArray *)cacheDictVals block:(void (^)(NSMutableArray * onlyCurrentUsersGroups))completionHandler;
@end
