//
//  CreateAccountViewController.h
//  NSUserDefaults, Segues, & Protocols Challenge Solution
//
//  Created by Joe Lucero on 7/14/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CreateAccountViewControllerDelegate <NSObject>

@required

- (void) userDidSuccessfullyCreateAnAccount : (NSDictionary *) user;
- (void) userDidCancelCreateAnAccount;

@end

@interface CreateAccountViewController : UIViewController

@property (weak, nonatomic) id <CreateAccountViewControllerDelegate> delegate;
@property (strong, nonatomic) NSArray *listOfUsernames;

@end
