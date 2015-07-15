//
//  SignInViewController.m
//  NSUserDefaults, Segues, & Protocols Challenge Solution
//
//  Created by Joe Lucero on 7/14/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.

#import "SignInViewController.h"
#import "CreateAccountViewController.h"
#import "SuccessScreenViewController.h"

@interface SignInViewController () <CreateAccountViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *userArray;
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

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
    BOOL usernamePresentInDataBase = false;
    BOOL passwordDoesMatchUsername = false;
    NSArray *usersAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:USERS_IN_DATABASE_KEY];
    for (NSDictionary *user in usersAsPropertyLists) {
        NSString *username = [user objectForKey:@"username"];
        NSString *passwordForThisUsername = [user objectForKey:@"password"];
        if ([self.usernameTF.text isEqualToString:username]){
            usernamePresentInDataBase = true;
            if ([self.passwordTF.text isEqualToString:passwordForThisUsername]){
                passwordDoesMatchUsername = true;
                [self performSegueWithIdentifier:@"loginWasSuccessful" sender:sender];
            }
            
        }
    }
    
    if (!usernamePresentInDataBase){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[NSString stringWithFormat:@"Username %@ does not exist", self.usernameTF.text]
                                                       delegate:self
                                              cancelButtonTitle:@"Try Again"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
    else if (!passwordDoesMatchUsername) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Username/Password do not match"
                                                       delegate:self
                                              cancelButtonTitle:@"Try Again"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.destinationViewController isKindOfClass:[CreateAccountViewController class]]){
        CreateAccountViewController *nextVC = segue.destinationViewController;
        nextVC.delegate = self;
        NSMutableArray *listOfUsernames = [NSMutableArray array];
        NSArray *usersAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:USERS_IN_DATABASE_KEY];
        for (NSDictionary *user in usersAsPropertyLists) {
            NSString *username = [user objectForKey:@"username"];
            [listOfUsernames addObject:username];
        }
        nextVC.listOfUsernames = [[NSArray alloc] initWithArray:listOfUsernames];
    }
    
    if ([segue.destinationViewController isKindOfClass:[SuccessScreenViewController class]]) [self clearTextFields];
}

# pragma mark - CreateAccountVCDelegate Methods

- (void) userDidSuccessfullyCreateAnAccount:(NSDictionary *)user {
    [self clearTextFields];
    // add the user to our database of users
    NSMutableArray *usersAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:USERS_IN_DATABASE_KEY] mutableCopy];
    if (!usersAsPropertyLists) usersAsPropertyLists = [[NSMutableArray alloc] init];
    
    // add our user to usersAsPropertyLists
    [usersAsPropertyLists addObject:user];

    // set our standard users object for key
    [[NSUserDefaults standardUserDefaults] setObject:usersAsPropertyLists forKey:USERS_IN_DATABASE_KEY];
    
    // synchronize/save
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) userDidCancelCreateAnAccount {
    [self clearTextFields];
}

#pragma mark - Helper Methods

- (void) clearTextFields {
    self.usernameTF.text = @"";
    self.passwordTF.text = @"";
}

@end
