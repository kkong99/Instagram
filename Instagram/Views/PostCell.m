//
//  PostCell.m
//  Instagram
//
//  Created by Kimora Kong on 7/10/18.
//  Copyright © 2018 Kimora Kong. All rights reserved.
//

#import "PostCell.h"
#import "PFUser.h"
// #import "UIImageView+AFNetworking.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) layoutCell:(Post *)post {
    self.post = post;
    
    self.topUsername.text = self.post[@"author"][@"username"];
    // self.profilePic.image = self.post.author.;
    self.mainPic.file = self.post[@"image"];
    [self.mainPic loadInBackground];
    NSString *likes = [self.post.likeCount stringValue];
    self.likesLabel.text = [likes stringByAppendingString: @" likes"];
    
    self.username.text = self.post[@"author"][@"username"];
    self.captionLabel.text = self.post[@"caption"];
    
    
}

@end
