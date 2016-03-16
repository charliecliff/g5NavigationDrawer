//
//  gsNavigationShelfMenuItem.h
//  gsUIKit
//
//  Created by Charles Cliff on 3/9/16.
//  Copyright © 2016 Charles Cliff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gsNavigationShelfMenuItem : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *subtitle;
@property (nonatomic, strong, readonly) NSString *glyphString;
@property (nonatomic, readonly) NSInteger badgeNumber;

- (gsNavigationShelfMenuItem *)initWithTitle:(NSString *)title withSubtitle:(NSString *)subtitle withGlyph:(NSString *)glyph withBadgeNumber:(NSInteger)badgeNumer;

@end
