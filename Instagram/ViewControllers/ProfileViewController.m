//
//  ProfileViewController.m
//  Instagram
//
//  Created by Kimora Kong on 7/12/18.
//  Copyright © 2018 Kimora Kong. All rights reserved.
//

#import "ProfileViewController.h"
#import "Post.h"
#import "ProfileCell.h"
#import <Parse/Parse.h>
#import "DetailsViewController.h"


@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

- (IBAction)didTapEdit:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *posts;
@property (strong, nonatomic) Post *post;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self fetchPosts];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*) self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    
    CGFloat postersPerLine = 3;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine-1)) / postersPerLine;
    CGFloat itemHeight = itemWidth * 1;
    layout.itemSize =  CGSizeMake(itemWidth, itemHeight);
}
- (void)fetchPosts {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"]; //how to define a query
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    PFUser *currentUser = [PFUser currentUser];
    [query whereKey:@"author" equalTo:currentUser];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = posts;
            [self.collectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    [cell setView:post];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.posts.count;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ProfileCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
    Post *post = self.posts[indexPath.row];
    UINavigationController *navController = [segue destinationViewController];
    DetailsViewController *detailPage = (DetailsViewController *) navController.topViewController ;
    detailPage.post = post;
}


//- (IBAction)didTapEdit:(id)sender {
//    [self performSegueWithIdentifier:@"edit" sender:nil];
//}
@end
