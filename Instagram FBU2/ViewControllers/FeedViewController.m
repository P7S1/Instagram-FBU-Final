//
//  FeedViewController.m
//  Instagram FBU
//
//  Created by Keng Fontem on 7/7/21.
//

#import "FeedViewController.h"
#import <Parse/Parse.h>
#import "LoginViewController.h"
#import "Post.h"
#import "PostTableViewCell.h"
#import "DetailViewController.h"

@interface FeedViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl* refreshControl;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if (self.posts.count > 0){
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:self.scrollToIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        self.navigationItem.title = @"Posts";
    }else{
        [self configureRefreshControl];
        [self getPosts];
        UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@
                                  "instagram"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.navigationItem.titleView = imageView;
    }
}

-(void) configureRefreshControl{
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(getPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

-(void) getPosts{
    NSLog(@"Getting posts...");
    [Post getAllPosts:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (error == nil){
            NSLog(@"Getting posts was successful");
            self.posts = posts;
            [self.tableView reloadData];
            
            if (self.refreshControl.isRefreshing){
                [self.refreshControl endRefreshing];
            }
            
        }else{
            NSLog(@"Getting Posts Failed");
            NSLog(@"%@", [error localizedDescription]);
        }
        
    }];
}

//MARK:- UITableViewDeleagte + Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostTableViewCell"];
    [cell setUpFromPost:self.posts[indexPath.row] parentViewControlller:self];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    vc.post = self.posts[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
