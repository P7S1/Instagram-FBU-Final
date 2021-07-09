//
//  PostTableViewCell.m
//  Instagram FBU
//
//  Created by Keng Fontem on 7/7/21.
//

#import "PostTableViewCell.h"
#import "Post.h"
#import <SDWebImage/SDWebImage.h>
#import "MediaManager.h"
#import "ProfileViewController.h"
@implementation PostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2;
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(profileButtonPressed)];
    [self.usernameLabel addGestureRecognizer:tapGesture];
    [self.usernameLabel setUserInteractionEnabled:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setUpFromPost: (Post*)post parentViewControlller: (UIViewController*)parentVC{
    self.post = post;
    self.parentVC = parentVC;
    self.captionLabel.text = post.caption;
    self.usernameLabel.text = [@"@" stringByAppendingString:post.author.username];
    self.dateLabel.text = [MediaManager timeAgoStringFromDate:post.createdAt];
    self.user = post.author;
    
    NSURL* url = [[NSURL alloc]initWithString:post.image.url];
    if (url != nil){
        [self.postImageView sd_setImageWithURL:url];
    }
    if (post.profileUrl != nil){
        NSURL* profileUrl = [[NSURL alloc]initWithString:post.profileUrl];
        if (url != nil){
            [self.profileImageView sd_setImageWithURL:profileUrl];
        }
    }
    
    //Sets Up imageview frame
    CGFloat aspectRatio = post.aspectRatio;
    CGFloat heightAnchorConstant = self.postImageView.frame.size.width * aspectRatio;
    self.postImageViewHeightAnchor.constant = heightAnchorConstant;
    
    [self updateLikeButton];
}

-(void) profileButtonPressed{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProfileViewController* profileVC = [storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    profileVC.user = self.user;
    [self.parentVC.navigationController pushViewController:profileVC animated:YES];
}

-(void)updateLikeButton{
    if ([self.post.likedUsers containsObject: PFUser.currentUser.objectId]){
        self.likeButton.tintColor = UIColor.redColor;
        [self.likeButton setImage:[UIImage systemImageNamed:@"heart.fill"] forState:UIControlStateNormal];
    }else{
        self.likeButton.tintColor = UIColor.labelColor;
        [self.likeButton setImage:[UIImage systemImageNamed:@"heart"] forState:UIControlStateNormal];
    }
}
- (IBAction)likeButtonPressed:(id)sender {
    self.post = [Post likePost:self.post];
    [self updateLikeButton];
}

@end
