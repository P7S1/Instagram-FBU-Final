//
//  CommentTableViewCell.m
//  Instagram FBU
//
//  Created by Keng Fontem on 7/9/21.
//

#import "CommentTableViewCell.h"
#import "Comment.h"
#import <SDWebImage/SDWebImage.h>
#import "MediaManager.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpCellFromComment:(Comment *)comment{
    self.comment = comment;
    
    NSURL* url = [[NSURL alloc]initWithString:comment.profileUrl];
    if (url){
        [self.profileImageView sd_setImageWithURL:url];
    }else{
        self.profileImageView.image = nil;
    }
    
    self.usernameLabel.text = comment.author.username;
    self.captionLabel.text = comment.text;
    self.dateLabel.text = [MediaManager timeAgoStringFromDate:comment.creationDate];
}

- (IBAction)playButton:(id)sender {
}
@end
