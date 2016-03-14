//
//  ProfileFooterTableViewCell.m
//  GSTicket
//
//  Created by Charles Cliff on 11/30/15.
//  Copyright © 2015 Charles Cliff. All rights reserved.
//

#import "gsNavigationShelfFooterTableViewCell.h"

@interface gsNavigationShelfFooterTableViewCell ()

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *primaryLabelBottomConstraint;

@end

@implementation gsNavigationShelfFooterTableViewCell


- (void)configureForNavigationMenuItem:(gsNavigationShelfMenuItem *)menuItem {
    [self.primaryLabel setText:menuItem.title];
    
    if (menuItem.subtitle != nil) {
        [self.secondaryLabel setText:menuItem.subtitle];
        [self setSecondaryLabelHidden:NO];
    }
    else {
        [self setSecondaryLabelHidden:YES];
    }
}

- (void)setSecondaryLabelHidden:(BOOL)hidden {
    [self.secondaryLabel setHidden:hidden];
    if (hidden) {
        self.primaryLabelBottomConstraint.constant = 10;
    }
    else {
        self.primaryLabelBottomConstraint.constant = 15;
    }
}

@end
