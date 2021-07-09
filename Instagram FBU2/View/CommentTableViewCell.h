//
//  CommentTableViewCell.h
//  Instagram FBU
//
//  Created by Keng Fontem on 7/9/21.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong) Comment* comment;

- (void) setUpCellFromComment: (Comment*)comment;


@end

NS_ASSUME_NONNULL_END
