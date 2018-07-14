//
//  ProfileCell.m
//  Instagram
//
//  Created by Kimora Kong on 7/13/18.
//  Copyright © 2018 Kimora Kong. All rights reserved.
//

#import "ProfileCell.h"

@implementation ProfileCell

- (void)setView:(Post *)post {
    self.post = post;
    
    self.picture.file = self.post[@"image"];
    [self.picture loadInBackground];
}
@end
