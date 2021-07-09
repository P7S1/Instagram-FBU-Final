//
//  UserProfile.m
//  Instagram FBU
//
//  Created by Keng Fontem on 7/8/21.
//

#import <Foundation/Foundation.h>
#import "UserProfile.h"
#import <Parse/Parse.h>

@implementation UserProfile

@dynamic userId;
@dynamic profileImage;

+ (nonnull NSString *)parseClassName {
    return @"UserProfile";
}

@end
