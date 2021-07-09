//
//  SceneDelegate.m
//  Instagram FBU
//
//  Created by Keng Fontem on 7/6/21.
//

#import "SceneDelegate.h"
#import <Parse/Parse.h>
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIApplication.sharedApplication.delegate.self.window = self.window;
    
    if (PFUser.currentUser) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    }
    self.window.tintColor = UIColor.labelColor;
    
}

@end
