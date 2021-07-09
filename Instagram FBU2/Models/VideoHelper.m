//
//  VideoHelper.m
//  Instagram FBU2
//
//  Created by Keng Fontem on 7/9/21.
//

#import <Foundation/Foundation.h>
#import "VideoHelper.h"
@implementation VideoHelper

@dynamic sharedPlayer;

+ (void)stopPlaying{
    if (VideoHelper.sharedPlayer == nil){
        return;
    }else{
        [VideoHelper.sharedPlayer.player pause];
        [VideoHelper.sharedPlayer removeFromSuperlayer];
        VideoHelper.sharedPlayer.player  = nil;
    }
}

+ (void)startPlayingAtVideoUrl:(NSURL *)videoUrl{
    if (VideoHelper.sharedPlayer != nil) { [VideoHelper stopPlaying]; }
    AVPlayer *player = [AVPlayer playerWithURL:videoUrl];
    
    VideoHelper.sharedPlayer = [[AVPlayerLayer alloc]init];
    
    VideoHelper.sharedPlayer.player = player;
    [VideoHelper.sharedPlayer.player play];
}

@end
