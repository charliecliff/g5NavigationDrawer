//
//  gsNavigationShelfMenuItem.m
//  gsUIKit
//
//  Created by Charles Cliff on 3/9/16.
//  Copyright © 2016 Charles Cliff. All rights reserved.
//

#import "gsNavigationShelfMenuItem.h"

@implementation gsNavigationShelfMenuItem

- (gsNavigationShelfMenuItem *)initWithTitle:(NSString *)title withSubtitle:(NSString *)subtitle withGlyph:(NSString *)glyph withBadgeNumber:(NSInteger)badgeNumber {
    self = [super init];
    if (self != nil) {
        _title = title;
        _subtitle = subtitle;
        _glyphString = glyph;
        _badgeNumber = badgeNumber;
    }
    return self;
}

@end
