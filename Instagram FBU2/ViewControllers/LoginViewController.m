//
//  LoginViewController.m
//  Instagram FBU
//
//  Created by Keng Fontem on 7/6/21.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "TabBarController.h"
@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.usernameTextField.layer.cornerRadius = 25;
    self.passwordTextField.layer.cornerRadius = 25;
    self.loginButton.layer.cornerRadius = 25;
    self.signUpButton.layer.cornerRadius = 25;
}

- (IBAction)loginButtonPressed:(id)sender {
    if (self.usernameTextField.text != nil && self.passwordTextField != nil){
        [self loginUser];
    }
}

- (IBAction)signUpButtonPressed:(id)sender {
    if (self.usernameTextField.text != nil && self.passwordTextField != nil){
        [self registerUser];
    }
}

-(void)presentAuthenticatedVC{
    UIStoryboard * storybard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TabBarController *tabBar = [storybard instantiateViewControllerWithIdentifier:@"TabBarController"];
    tabBar.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:tabBar animated:YES completion:nil];
}

- (void)loginUser {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            [self presentAuthenticatedVC];
        }
    }];
}

- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            [self presentAuthenticatedVC];
        }
    }];
}


@end
