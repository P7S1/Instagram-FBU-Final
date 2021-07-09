//
//  UserProfile.h
//  Instagram FBU
//
//  Created by Keng Fontem on 7/8/21.
//
#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

@interface UserProfile : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString* userId;
@property (nonatomic, strong) PFFileObject* profileImage;

@end
