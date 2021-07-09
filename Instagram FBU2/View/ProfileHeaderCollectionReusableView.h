//
//  ProfileHeaderCollectionReusableView.h
//  Instagram FBU
//
//  Created by Keng Fontem on 7/8/21.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
NS_ASSUME_NONNULL_BEGIN

@interface ProfileHeaderCollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (nonatomic, strong) PFUser * _Nullable user;
@property (nonatomic, strong) UIViewController* parentVC;

- (void) setUpView: (PFUser* _Nullable) user withParentViewController: (UIViewController*) parentVC;

@end

NS_ASSUME_NONNULL_END
