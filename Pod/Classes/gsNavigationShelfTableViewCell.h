//
//  ProfileTableViewCell.h
//  GSTicket
//
//  Created by Charles Cliff on 11/30/15.
//  Copyright © 2015 Charles Cliff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gsNavigationShelfMenuItem.h"

@interface gsNavigationShelfTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *badgeImageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *badgeLabel;
@property (nonatomic, strong) IBOutlet UILabel *iconGlyphLabel;

@property (nonatomic, strong) UIColor *badgeColor;

/**
 * This is the count that is displayed in the Badge Icon. If it is 0, then the Badge Icon will be hidden
 */
- (void)setBadgeCount:(NSInteger)badgeCount withBadgeColor:(UIColor *)color;

- (void)configureForNavigationMenuItem:(gsNavigationShelfMenuItem *)menuItem;

@end
