//
//  Post.m
//  Instagram FBU
//
//  Created by Keng Fontem on 7/7/21.
//

#import <Foundation/Foundation.h>
#import "Post.h"
#import <Parse/Parse.h>
#import "MediaManager.h"
@implementation Post
    
@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic commentCount;
@dynamic aspectRatio;
@dynamic profileUrl;
@dynamic likedUsers;
@dynamic creationDate;
@dynamic video;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withAspectRatio:(CGFloat)aspectRatio withVideoIfAvaliable: (NSURL * _Nullable)video withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.commentCount = @(0);
    newPost.creationDate = [[NSDate alloc]init];
    newPost.aspectRatio = aspectRatio;
    newPost.userID = PFUser.currentUser.objectId;
    newPost.likedUsers = [[NSArray alloc]init];
    if (video != nil){
        newPost.video = [self getPFFileFromVideo:video];
    }
    
    [MediaManager getCurrentUserProfileURL:^(NSURL * _Nullable url, NSError * _Nullable error) {
        if (url){
            newPost.profileUrl = url.absoluteString;
        }
    }];
    
    
    [newPost saveInBackgroundWithBlock: completion];
}

+ (PFFileObject*) getPFFileFromVideo: (NSURL*) videoUrl{
    NSData* videoData = [[NSData alloc]initWithContentsOfFile:videoUrl.relativePath];
    
    PFFileObject* videoFile = [PFFileObject fileObjectWithName:@"video.mp4" data:videoData];
    
    return videoFile;
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.2);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.jpg" data:imageData];
}

+ (void) getAllPosts: (getPostsBlock _Nullable)completion;{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = 20;
    [query includeKey:@"author"];
    [query orderByDescending:@"creationDate"];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        completion(posts,error);
    }];
}

+ (void)getAllPostsFromUser:(NSString *)userId completionHandler:(getPostsBlock)completion{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"creationDate"];
    [query whereKey:@"userID" equalTo:userId];
    query.limit = 20;
    [query includeKey:@"author"];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        completion(posts,error);
    }];
}

+ (Post*) likePost:(Post*)post{
    if (post.likedUsers == nil){
        post.likedUsers = [[NSArray alloc]init];
    }
    post.likedUsers = [post.likedUsers arrayByAddingObject:PFUser.currentUser.objectId];
    
    [post saveInBackground];
    
    return post;
}


@end
