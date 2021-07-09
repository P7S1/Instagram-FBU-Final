//
//  SettingsViewController.m
//  Instagram FBU
//
//  Created by Keng Fontem on 7/7/21.
//

#import "SettingsViewController.h"
#import <Parse/Parse.h>
#import "LoginViewController.h"
@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Settings";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 && indexPath.row == 1){
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
        
        
        [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        
        }];
    }
}

@end
