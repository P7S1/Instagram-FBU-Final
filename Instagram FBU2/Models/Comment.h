//
//  Comment.h
//  Instagram FBU
//
//  Created by Keng Fontem on 7/9/21.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

@interface Comment : PFObject<PFSubclassing>

@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) NSString* postId;
@property (nonatomic, strong) NSString* profileUrl;

+ (Comment*)postCommentWithCaption:(NSString *)caption withPostId:(NSString *)postId;

typedef void(^getCommentsBlock)(NSArray<Comment*>* _Nullable posts, NSError* _Nullable error);
+ (void)getAllCommentsInPost:(NSString * _Nonnull)postId completionHandler:(getCommentsBlock _Nullable )completion;


@end
