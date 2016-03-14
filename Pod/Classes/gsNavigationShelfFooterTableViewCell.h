//
//  ProfileFooterTableViewCell.h
//  GSTicket
//
//  Created by Charles Cliff on 11/30/15.
//  Copyright © 2015 Charles Cliff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gsNavigationShelfMenuItem.h"

@interface gsNavigationShelfFooterTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *primaryLabel;
@property (nonatomic, strong) IBOutlet UILabel *secondaryLabel;

///**
// * TODO: Document
// */
//- (void)setSecondaryLabelHidden:(BOOL)hidden;

- (void)configureForNavigationMenuItem:(gsNavigationShelfMenuItem *)menuItem;


@end
