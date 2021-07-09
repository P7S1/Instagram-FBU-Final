//
//  FeedViewController.h
//  Instagram FBU
//
//  Created by Keng Fontem on 7/7/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN

@interface FeedViewController : UIViewController

@property (nonatomic, strong) NSArray<Post*>* posts;
@property (nonatomic, strong) NSIndexPath* scrollToIndexPath;

@end

NS_ASSUME_NONNULL_END
