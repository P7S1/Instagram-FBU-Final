//
//  DetailViewController.m
//  Instagram FBU
//
//  Created by Keng Fontem on 7/8/21.
//

#import "DetailViewController.h"
#import <SDWebImage/SDWebImage.h>
#import "Comment.h"
#import "CommentTableViewCell.h"
#import "MediaManager.h"

@interface DetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong) NSArray<Comment*>* comments;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpHeader];
    self.navigationItem.title = @"Post Details";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self getComments];
}

-(void)setUpHeader{
    self.usernameLabel.text = [@"@" stringByAppendingString:self.post.author.username];
    self.captionLabel.text = self.post.caption;
    self.dateLabel.text = [MediaManager timeAgoStringFromDate:self.post.creationDate];
    if (self.post.likedUsers ==  nil){
        self.post.likedUsers = [[NSArray alloc]init];
    }
    
    NSString* likeLabelText = self.post.likedUsers.count == 1 ? @" like" : @" likes";
    self.likesButton.text = [[NSString stringWithFormat: @"%ld", (long)self.post.likedUsers.count] stringByAppendingString:likeLabelText];
    
    NSURL* url = [[NSURL alloc]initWithString:self.post.image.url];
    [self.postImageView sd_setImageWithURL:url];
    
}

-(void) getComments{
    
    [Comment getAllCommentsInPost:self.post.objectId completionHandler:^(NSArray<Comment *> * _Nullable comments, NSError * _Nullable error) {
            if (error == nil){
                self.comments = comments;
                [self.tableView reloadData];
            }else{
                NSLog(@"Error getting all comments");
                NSLog(@"%@", [error localizedDescription]);
            }
    }];
}

- (IBAction)sendButtonPressed:(id)sender {
    NSString* text = self.textField.text;
    self.textField.text = @"";
    Comment* comment = [Comment postCommentWithCaption:text withPostId:self.post.objectId];
    self.comments = [self.comments arrayByAddingObject:comment];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell"];
    [cell setUpCellFromComment:self.comments[indexPath.row]];
    return cell;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.comments.count;
}
@end
