//
//  FeedViewController.m
//  Instagram
//
//  Created by Kimora Kong on 7/9/18.
//  Copyright © 2018 Kimora Kong. All rights reserved.
//

#import "FeedViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "PostCell.h"
#import "Post.h"
#import "DetailsViewController.h"

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource>
- (IBAction)didLogOut:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *postTable;
@property (strong, nonatomic) NSArray *posts;
- (IBAction)didTapCamera:(id)sender;
// - (IBAction)didTapPic:(id)sender;
@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.postTable.dataSource = self;
    self.postTable.delegate = self;
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.postTable insertSubview:refreshControl atIndex:0];
    
    [self fetchPosts];
}

- (void)viewDidAppear:(BOOL)animated {
    [self fetchPosts];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self fetchPosts];
    [refreshControl endRefreshing];
}
- (void)fetchPosts {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"]; //how to define a query
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20; 
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = posts;
            [self.postTable reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [self.postTable dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    [cell layoutCell:post];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didLogOut:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate logout];
}
- (IBAction)didTapCamera:(id)sender {
    [self performSegueWithIdentifier:@"ComposeSegue" sender:nil];
}
//- (IBAction)didTapPic:(id)sender {
//    [self performSegueWithIdentifier:@"DetailsSegue" sender:nil];
//
//}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    PostCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.postTable indexPathForCell:tappedCell];
    Post *post = self.posts[indexPath.row];
    UINavigationController *navController = [segue destinationViewController];
    DetailsViewController * detailPage = (DetailsViewController *) navController.topViewController ;
    detailPage.post = post;
}



@end
