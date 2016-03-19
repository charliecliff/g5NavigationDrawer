//
//  GSProfileViewController.m
//  GSTicket
//
//  Created by Charles Cliff on 11/30/15.
//  Copyright © 2015 Charles Cliff. All rights reserved.
//

#import "gsNavigationShelf.h"
#import "gsNavigationShelfTableViewCell.h"
#import "gsNavigationShelfFooterTableViewCell.h"
#import "gsNavigationShelfMenuItem.h"

@interface gsNavigationShelf () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *profileOptionsTableView;
@property (nonatomic, strong) IBOutlet UITableView *footerOptionsTableView;
@property (nonatomic, strong) IBOutlet UIImageView *profileImageView;
@property (nonatomic, strong) IBOutlet UIImageView *backgroundImageView;

@end

@implementation gsNavigationShelf

#pragma mark - Refreshing

- (void)reloadData {
    [self reloadStyles];
    [self.profileOptionsTableView reloadData];
    [self.footerOptionsTableView reloadData];
}

- (void)reloadStyles {
    [self.profileImageView setImage:[self.dataSource headerIcon]];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( tableView == self.profileOptionsTableView ) {
        [self.delegate didSelectMenuOptionAtIndex:indexPath.row];
    }
    else if ( tableView == self.footerOptionsTableView) {
        [self.delegate didSelectFooterOptionAtIndex:indexPath.row];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ( tableView == self.profileOptionsTableView ) {
        return [self.dataSource numberOfMenuOptions];
    }
    else if ( tableView == self.footerOptionsTableView) {
        return [self.dataSource numberOfFooterOptions];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( tableView == self.profileOptionsTableView ) {
        return [self menuOptionCellForTableView:tableView atIndexPath:indexPath];
    }
    else if ( tableView == self.footerOptionsTableView) {
        return [self footerOptionCellForTableView:tableView AtIndexPath:indexPath];
    }
    return nil;
}

- (gsNavigationShelfTableViewCell *)menuOptionCellForTableView:(UITableView *)tableView  atIndexPath:(NSIndexPath *)indexPath
{
    NSString *bundlePath = [[NSBundle bundleForClass:[gsNavigationShelf class]] pathForResource:nil ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    gsNavigationShelfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gsNavigationShelfTableViewCell"];
    
    if (!cell) {
        UINib *tableCell = [UINib nibWithNibName:@"gsNavigationShelfTableViewCell" bundle:bundle] ;
        [tableView registerNib:tableCell forCellReuseIdentifier:@"gsNavigationShelfTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"gsNavigationShelfTableViewCell"];
    }
    cell.badgeColor = [self.dataSource badgeColor];
    
    gsNavigationShelfMenuItem *menuItem = [self.dataSource menuItemForMenuOptionAtIndexPath:indexPath];
    [cell configureForNavigationMenuItem:menuItem];
    if ([self.delegate respondsToSelector:@selector(textColor)]) {
        [cell.iconGlyphLabel setTextColor:[self.dataSource textColor]];
        [cell.titleLabel setTextColor:[self.dataSource textColor]];
    }
    return cell;
}

- (gsNavigationShelfFooterTableViewCell *)footerOptionCellForTableView:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath
{
    NSString *bundlePath = [[NSBundle bundleForClass:[gsNavigationShelf class]] pathForResource:nil ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    gsNavigationShelfFooterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gsNavigationShelfFooterTableViewCell"];
    
    if (!cell) {
        UINib *tableCell = [UINib nibWithNibName:@"gsNavigationShelfFooterTableViewCell" bundle:bundle] ;
        [tableView registerNib:tableCell forCellReuseIdentifier:@"gsNavigationShelfFooterTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"gsNavigationShelfFooterTableViewCell"];
    }
    
    gsNavigationShelfMenuItem *menuItem = [self.dataSource menuItemForFooterOptionAtIndexPath:indexPath];
    [cell configureForNavigationMenuItem:menuItem];
    
    return cell;
}

@end
