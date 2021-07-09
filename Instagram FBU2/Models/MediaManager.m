//
//  MediaManager.m
//  Instagram FBU
//
//  Created by Keng Fontem on 7/7/21.
//

#import <UIKit/UIKit.h>
#import "MediaManager.h"
#import <Parse/Parse.h>
#import "UserProfile.h"
@implementation MediaManager : NSObject


+(CGFloat) getImageAspectRatio: (CGSize) size{
    CGFloat aspectRatio = size.height / size.width;
    if (aspectRatio < 0.5){
        return 0.5;
    }else if (aspectRatio > 1.5){
        return 1.5;
    }else{
        return aspectRatio;
    }
}

+ (NSString *)timeAgoStringFromDate:(NSDate *)date {
    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;

    NSDate *now = [NSDate date];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond)
                                               fromDate:date
                                                 toDate:now
                                                options:0];

    if (components.year > 0) {
        formatter.allowedUnits = NSCalendarUnitYear;
    } else if (components.month > 0) {
        formatter.allowedUnits = NSCalendarUnitMonth;
    } else if (components.weekOfMonth > 0) {
        formatter.allowedUnits = NSCalendarUnitWeekOfMonth;
    } else if (components.day > 0) {
        formatter.allowedUnits = NSCalendarUnitDay;
    } else if (components.hour > 0) {
        formatter.allowedUnits = NSCalendarUnitHour;
    } else if (components.minute > 0) {
        formatter.allowedUnits = NSCalendarUnitMinute;
    } else {
        formatter.allowedUnits = NSCalendarUnitSecond;
    }

    NSString *formatString = NSLocalizedString(@"%@ ago", @"Used to say how much time has passed. e.g. '2 hours ago'");

    return [NSString stringWithFormat:formatString, [formatter stringFromDateComponents:components]];
}

+ (void)getCurrentUserProfileURL:(getCurrentUserProfilePictureBlock)completion{
    
    //Checks in user defualts for profile URL
    NSUserDefaults* userDefaults = NSUserDefaults.standardUserDefaults;
    
    NSString* key = [PFUser.currentUser.objectId stringByAppendingString:@"_profileURL"];
    
    NSString* urlString = [userDefaults valueForKey:key];
    if (urlString){
        NSURL *url = [[NSURL alloc]initWithString:urlString];
        
        if (url){
            completion(url,nil);
            return;
        }
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserProfile"];
    query.limit = 1;
    [query whereKey:@"userId" equalTo:PFUser.currentUser.objectId];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (objects.count > 0){
                UserProfile* profile = objects[0];
                
                NSURL* url = [[NSURL alloc]initWithString:profile.profileImage.url];
                
                [userDefaults setValue:url.absoluteString forKey:key];
                [userDefaults synchronize];
                
                completion(url,error);
            }else{
                completion(nil,error);
            }
    }];
    
}
@end
