//
//  Post.h
//  Instagram FBU
//
//  Created by Keng Fontem on 7/7/21.
//

//  Post.h
#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString * _Nonnull postID;
@property (nonatomic, strong) NSString *_Nonnull userID;
@property (nonatomic, strong) PFUser *_Nonnull author;

@property (nonatomic, strong) NSString *_Nonnull caption;
@property (nonatomic, strong) PFFileObject *_Nonnull image;
@property (nonatomic, strong) PFFileObject *_Nonnull video;
@property (nonatomic, strong) NSNumber * _Nonnull commentCount;
@property (nonatomic, strong) NSString * _Nullable profileUrl;
@property (nonatomic, strong) NSDate *_Nonnull creationDate;

@property (nonatomic) CGFloat aspectRatio;
@property (nonatomic, strong) NSArray * _Nullable likedUsers;


+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withAspectRatio:(CGFloat)aspectRatio withVideoIfAvaliable: (NSURL * _Nullable)video withCompletion: (PFBooleanResultBlock  _Nullable)completion;

typedef void(^getPostsBlock)(NSArray<Post*>* _Nullable posts, NSError* _Nullable error);

+ (void) getAllPosts: (getPostsBlock _Nullable)completion;
+ (void) getAllPostsFromUser: (NSString* _Nonnull)userId completionHandler: (getPostsBlock _Nullable)completion;


+ (PFFileObject *_Nonnull)getPFFileFromImage: (UIImage * _Nullable)image;
+ (Post*_Nonnull) likePost:(Post*_Nonnull)post;

@end
