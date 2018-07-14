//
//  PostCell.h
//  Instagram
//
//  Created by Kimora Kong on 7/10/18.
//  Copyright © 2018 Kimora Kong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Post.h"
#import <ParseUI/ParseUI.h>

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *topUsername;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet PFImageView *mainPic;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@property (strong, nonatomic) Post *post;

-(void) layoutCell:(Post *)post;
@end
