//
//  SignInViewController.m
//  NSUserDefaults, Segues, & Protocols Challenge Solution
//
//  Created by Joe Lucero on 7/14/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//






// 4:45pm on July 14
/* Nice work! Next up I need to allow the delegate method below to put the user information (in the form of a dictionary with user, password keys) into the NSUser Defaults, save, and then use that information to keep track of who should be allowed in and who shouldn't*/







#import "SignInViewController.h"
#import "CreateAccountViewController.h"

@interface SignInViewController () <CreateAccountViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *userArray;

@end

@implementation SignInViewController

#define USERS_IN_DATABASE_KEY @"Users In Database"

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPushed:(UIButton *)sender {
    //if login is correct
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[CreateAccountViewController class]]){
        CreateAccountViewController *nextVC = segue.destinationViewController;
        nextVC.delegate = self;
    }
}

# pragma mark - CreateAccountVCDelegate Methods

- (void) userDidSuccessfullyCreateAnAccount:(NSDictionary *)user {
    // add the user to our database of users
    NSLog(@"%@", user);
    
    NSMutableArray *usersAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:USERS_IN_DATABASE_KEY] mutableCopy];
    if (!usersAsPropertyLists) usersAsPropertyLists = [[NSMutableArray alloc] init];
    
    // add our user to usersAsPropertyLists
    
    // set our standard users object for key
    
    // synchronize/save
    
//    [spaceObjectsAsPropertyLists addObject:[self spaceObjectAsAPropertyList:spaceObject]];
//    [[NSUserDefaults standardUserDefaults] setObject:spaceObjectsAsPropertyLists forKey:ADDED_SPACE_OBJECTS_KEY];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Helper Methods



@end
