//
//  ProfileViewController.m
//  Instagram FBU
//
//  Created by Keng Fontem on 7/7/21.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "UserProfile.h"
#import "MediaManager.h"
#import <SDWebImage/SDWebImage.h>
#import "ProfileHeaderCollectionReusableView.h"
#import "PostCollectionViewCell.h"
#import "FeedViewController.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray<Post*>* posts;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.user == nil){
        self.user = PFUser.currentUser;
    }
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView setUserInteractionEnabled:YES];
    
    [self getPosts];
}

-(void) getPosts{
    [Post getAllPostsFromUser:self.user.objectId completionHandler:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (error == nil){
            NSLog(@"No errors getting profile posts");
            self.posts = posts;
            
            [self.collectionView reloadData];
        }else{
            NSLog(@"Getting Profile posts error");
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}




//MARK:- UICollectionView Deleagte + DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.posts.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PostCollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionViewCell" forIndexPath:indexPath];
    Post* post = self.posts[indexPath.row];
    
    NSURL* url = [[NSURL alloc]initWithString:post.image.url];
    
    if (url){
        [cell.postImageView sd_setImageWithURL:url];
    }else{
        cell.postImageView.image = nil;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FeedViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"];
    vc.posts = self.posts;
    vc.scrollToIndexPath = indexPath;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        ProfileHeaderCollectionReusableView* header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ProfileHeaderCollectionReusableView" forIndexPath:indexPath];
        
        [header setUpView:self.user withParentViewController:self];
        
        return header;
    }else{
        return [[UICollectionReusableView alloc]init];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat size = UIScreen.mainScreen.bounds.size.width/3 - (0.7 * 3);
    return CGSizeMake(size, size);;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.view.frame.size.width, 190);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.7;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.7;
}


@end
