//
//  Comment.m
//  Instagram FBU
//
//  Created by Keng Fontem on 7/9/21.
//

#import <Foundation/Foundation.h>
#import "Comment.h"
#import <Parse/Parse.h>
#import  "UserProfile.h"
#import "MediaManager.h"
@implementation Comment

@dynamic author;
@dynamic text;
@dynamic creationDate;
@dynamic postId;
@dynamic profileUrl;

+ (nonnull NSString *)parseClassName {
    return @"Comment";
}

+ (Comment*)postCommentWithCaption:(NSString *)caption withPostId:(NSString *)postId{
    
    Comment* newComment = [Comment new];
    newComment.text = caption;
    newComment.author = PFUser.currentUser;
    newComment.creationDate = [[NSDate alloc]init];
    newComment.postId = postId;
    
    [MediaManager getCurrentUserProfileURL:^(NSURL * _Nullable url, NSError * _Nullable error) {
            if (url != nil){
                newComment.profileUrl = url.absoluteString;
            }
    }];
    
    [newComment saveInBackground];
    
    return newComment;
}

+ (void)getAllCommentsInPost:(NSString *)postId completionHandler:(getCommentsBlock)completion{
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    [query whereKey:@"postId" equalTo:postId];
    query.limit = 20;
    [query includeKey:@"author"];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error) {
        completion(comments,error);
    }];
}


@end
