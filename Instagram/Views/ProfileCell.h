//
//  ProfileCell.h
//  Instagram
//
//  Created by Kimora Kong on 7/13/18.
//  Copyright © 2018 Kimora Kong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <ParseUI/ParseUI.h>

@interface ProfileCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *picture;
@property (strong, nonatomic) Post *post;

- (void)setView:(Post *)post; 
@end
