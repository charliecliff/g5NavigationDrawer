//
//  ProfileTableViewCell.m
//  GSTicket
//
//  Created by Charles Cliff on 11/30/15.
//  Copyright © 2015 Charles Cliff. All rights reserved.
//

#import "gsNavigationShelfTableViewCell.h"

@interface gsNavigationShelfTableViewCell ()

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *badgeLabelWidth;

@end


@implementation gsNavigationShelfTableViewCell

- (void)configureForNavigationMenuItem:(gsNavigationShelfMenuItem *)menuItem {
    [self.titleLabel setText:menuItem.title];
    [self.iconImageView setImage:menuItem.icon];
    [self setBadgeCount:menuItem.badgeNumber withBadgeColor:self.badgeColor];
}

- (void)setBadgeCount:(NSInteger)badgeCount withBadgeColor:(UIColor *)color {
    if (badgeCount == 0) {
        [self.badgeImageView setHidden:YES];
        [self.badgeLabel setHidden:YES];
        self.badgeLabelWidth.constant = 0;
    }
    else {
       [self.badgeImageView setHidden:NO];
        [self.badgeLabel setHidden:NO];
        [self.badgeImageView setImage:[self badgeImageWithColor:color]];
        [self.badgeLabel setText:[NSString stringWithFormat:@"%ld", (long)badgeCount]];
        self.badgeLabelWidth.constant = 30;
    }
}

#pragma mark - Helpers

- (UIImage *)badgeImageWithColor:(UIColor *)color {
    // Create an Ellipse
    [self.badgeImageView setBackgroundColor:color];
    [self.badgeImageView.layer setCornerRadius:self.badgeImageView.frame.size.height / 2];
    
    // Take a Snap-Shot of the UIImageView and convert it to a UIImage
    UIGraphicsBeginImageContextWithOptions(self.badgeImageView.bounds.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.badgeImageView.layer renderInContext:context];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}

@end
