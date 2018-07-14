//
//  DetailsViewController.m
//  Instagram
//
//  Created by Kimora Kong on 7/11/18.
//  Copyright © 2018 Kimora Kong. All rights reserved.
//

#import "DetailsViewController.h"
#import "Post.h"
#import <ParseUI/ParseUI.h>

@interface DetailsViewController ()
- (IBAction)didTapBack:(id)sender;

// @property (strong, nonatomic) Post *post;

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *topUsername;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet PFImageView *mainPic;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.username.text = self.post.author.username;
    // self.profileImage.image =
    self.topUsername.text = self.post.author.username;
    self.mainPic.file = self.post[@"image"];
    [self.mainPic loadInBackground];
    NSString *likes = [self.post.likeCount stringValue];
    self.likesLabel.text = [likes stringByAppendingString: @" likes"];
    self.caption.text = self.post[@"caption"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    self.dateLabel.text = [formatter stringFromDate:self.post.createdAt];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)setPost:(Post *)post{
//    _post = post;
//
//    self.username.text = self.post.author.username;
//    // self.profileImage.image =
//    self.topUsername.text = self.post.author.username;
//    // self.mainPic.file = self.post[@"image"];
//    // [self.mainPic loadInBackground];
//    self.likesLabel.text = [@"self.post.likeCount" stringByAppendingString: @" likes"];
//    self.caption.text = self.post[@"caption"];
//}
//
//- (void)formatPage:(Post *)post {
//    self.post = post;
//
//    self.username.text = self.post.author.username;
//    // self.profileImage.image =
//    self.usernameBottom.text = self.post.author.username;
//    self.mainPic.file = self.post[@"image"];
//    [self.mainPic loadInBackground];
//    self.likesLabel.text = [@"self.post.likeCount" stringByAppendingString: @" likes"];
//    self.caption.text = self.post[@"caption"];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
