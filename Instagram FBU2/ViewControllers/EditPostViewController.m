//
//  EditPostViewController.m
//  Instagram FBU
//
//  Created by Keng Fontem on 7/7/21.
//

#import "EditPostViewController.h"
#import "Post.h"
#import "MediaManager.h"
@protocol EditPostViewControllerDelegate

- (void)didPost:(Post *)post;

@end

@interface EditPostViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) NSURL * _Nullable videoUrl;

@end

@implementation EditPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.image;
    [self setUpNavigationController];
    //[self setUpImageViewFrame];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    IQKeyboardManager.sharedManager.enable = NO;
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:YES];
//    IQKeyboardManager.sharedManager.enable = YES;
//}



- (void) setUpNavigationController{
    self.navigationItem.title = @"New Post";
    UIBarButtonItem* postButton = [[UIBarButtonItem alloc]initWithTitle:@"Post" style:UIBarButtonItemStyleDone target:self action:@selector(postButtonPressed)];
    self.navigationItem.rightBarButtonItem = postButton;
    
//    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonPressed)];
//    self.navigationItem.leftBarButtonItem = cancelButton;
}

//- (void) setUpImageViewFrame{
//    CGFloat aspectRatio = [MediaManager getImageAspectRatio:self.image.size];;
//    CGFloat heightAnchorConstant = self.textView.frame.size.width * aspectRatio;
//    self.imageViewHeightAnchor.constant = heightAnchorConstant;
//}


- (void) postButtonPressed{
    CGFloat aspectRatio = [MediaManager getImageAspectRatio:self.image.size];
    [Post postUserImage:self.image withCaption:self.textView.text withAspectRatio:aspectRatio withVideoIfAvaliable:self.videoUrl withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        if (succeeded){
            NSLog(@"Post posted successfully");
        }else{
            NSLog(@"Post posted failed");
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}
@end
