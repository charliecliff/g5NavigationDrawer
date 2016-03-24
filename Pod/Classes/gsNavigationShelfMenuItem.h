//
//  gsNavigationShelfMenuItem.h
//  gsUIKit
//
//  Created by Charles Cliff on 3/9/16.
//  Copyright © 2016 Charles Cliff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface gsNavigationShelfMenuItem : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *subtitle;
@property (nonatomic, strong, readonly) UIImage *icon;
@property (nonatomic, readonly) NSInteger badgeNumber;

- (gsNavigationShelfMenuItem *)initWithTitle:(NSString *)title withSubtitle:(NSString *)subtitle withIcon:(UIImage *)icon withBadgeNumber:(NSInteger)badgeNumer;

@end
