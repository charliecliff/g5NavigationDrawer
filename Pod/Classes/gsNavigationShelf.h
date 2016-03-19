//
//  GSProfileViewController.h
//  GSTicket
//
//  Created by Charles Cliff on 11/30/15.
//  Copyright © 2015 Charles Cliff. All rights reserved.
//

#import <UIKit/UIKit.h>
@class gsNavigationShelf;
@class gsNavigationShelfMenuItem;

@protocol gsNavigationShelfDelegate <NSObject>

@required
- (void)didSelectMenuOptionAtIndex:(NSInteger)index;
- (void)didSelectFooterOptionAtIndex:(NSInteger)index;

@end

@protocol gsNavigationShelfDataSource <NSObject>

@required
- (UIImage *)headerIcon;
- (UIColor *)badgeColor;
- (NSInteger)numberOfMenuOptions;
- (NSInteger)numberOfFooterOptions;
- (gsNavigationShelfMenuItem *)menuItemForMenuOptionAtIndexPath:(NSIndexPath *)indexPath;
- (gsNavigationShelfMenuItem *)menuItemForFooterOptionAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (UIColor *)textColor;

@end


@interface gsNavigationShelf : UIView

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *footerHeightConstraint;

@property (nonatomic, strong) id<gsNavigationShelfDelegate>delegate;
@property (nonatomic, strong) id<gsNavigationShelfDataSource>dataSource;

- (void)reloadData;

@end
