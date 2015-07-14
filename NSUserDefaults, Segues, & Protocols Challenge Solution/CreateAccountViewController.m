//
//  CreateAccountViewController.m
//  NSUserDefaults, Segues, & Protocols Challenge Solution
//
//  Created by Joe Lucero on 7/14/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "CreateAccountViewController.h"

@interface CreateAccountViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;

@end

@implementation CreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)registerButtonPushed:(UIBarButtonItem *)sender {
    //NSLog(@" %s", [self isThereTextInAllThreeTextFields] ? "true" : "false");
    
    if ([self areBothPasswordsEnteredTheSame] && [self isThereTextInAllThreeTextFields]){
        [self.delegate userDidSuccessfullyCreateAnAccount:[self usersInformationAsDictionary:self.usernameTF.text :self.passwordTF.text]];
        [self dismissViewControllerAnimated:true completion:nil];
    }
    
    else if (![self isThereTextInAllThreeTextFields]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                        message:@"Please Enter Username & Password"
                                                       delegate:self
                                              cancelButtonTitle:@"Try Again"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                       message:@"Password & Confirm Password Don't Match"
                                                      delegate:self
                                             cancelButtonTitle:@"Try Again"
                                             otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)cancelButtonPushed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - Helper Methods

- (BOOL) areBothPasswordsEnteredTheSame {
    return ([self.passwordTF.text isEqualToString:self.confirmPasswordTF.text]);
}

- (BOOL) isThereTextInAllThreeTextFields {
    return (self.usernameTF.text.length > 0 && self.passwordTF.text.length > 0 && self.confirmPasswordTF.text.length > 0);
}

- (NSDictionary *) usersInformationAsDictionary : (NSString *) username : (NSString *) password {
    NSDictionary *user = [[NSDictionary alloc] initWithObjectsAndKeys: @{username : @"username"}, @{password : @"password"}, nil];
    return user;
}

// later we need to also check to make sure there is not more than one person for a username

@end
