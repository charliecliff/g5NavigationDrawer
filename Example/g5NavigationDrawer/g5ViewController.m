//
//  g5ViewController.m
//  g5NavigationDrawer
//
//  Created by cliffhanger62 on 03/13/2016.
//  Copyright (c) 2016 cliffhanger62. All rights reserved.
//

#import "g5ViewController.h"
#import "ViewController.h"

@interface g5ViewController () <gsNavigationTabDataSource> 

@end

@implementation g5ViewController

- (instancetype)init
{
    self = [super initWithDataSource:self];
    if (self != nil) {
        ViewController *menuVC1 = [[ViewController alloc] init];
        [menuVC1.view setBackgroundColor:[UIColor redColor]];
        
        ViewController *menuVC2 = [[ViewController alloc] init];
        [menuVC2.view setBackgroundColor:[UIColor yellowColor]];
        
        ViewController *menuVC3 = [[ViewController alloc] init];
        [menuVC3.view setBackgroundColor:[UIColor blueColor]];
        
        ViewController *footerVC1 = [[ViewController alloc] init];
        [footerVC1.view setBackgroundColor:[UIColor purpleColor]];
        
        [self setMenuOptionWithTitle:@"Menu Option 1" withSubtitle:nil withIcon:[UIImage imageNamed:@"icon1"] withBadgeNumber:0 withViewController:menuVC1];
        [self setMenuOptionWithTitle:@"Menu Option 2" withSubtitle:@"Menu Option Subtitle" withIcon:[UIImage imageNamed:@"icon2"] withBadgeNumber:0 withViewController:menuVC2];
        [self setMenuOptionWithTitle:@"Menu Option 3" withSubtitle:nil withIcon:[UIImage imageNamed:@"icon3"] withBadgeNumber:3 withViewController:menuVC3];
        [self setFooterOptionWithTitle:@"Footer Option" withSubtitle:@"Footer Subtitle" withViewController:footerVC1];
        
        [self displayMenuViewControlletAtIndex:0];
    }
    return self;
}

#pragma mark - gsNavigationTab Delegate


#pragma mark - gsNavigationTab DataSource

- (UIImage *)navigationHeaderImage {
    return [UIImage imageNamed:@"iconProfile"];
}

- (UIColor *)navigationShelfTextColor {
    return [UIColor colorWithRed:48.0/255.0 green:96.0/255.0 blue:149.0/255.0 alpha:1];
}

- (UIColor *)navigationShelfBadgeColor {
    return [UIColor colorWithRed:213.0/255.0 green:68.0/255.0 blue:28.0/255.0 alpha:1];
}

- (UIColor *)navigationShelfLeftGradientColor {
    return [UIColor whiteColor];
}

- (UIColor *)navigationShelfRightGradientColor {
    return [UIColor colorWithRed:3.0/255.0 green:26.0/255.0 blue:48.0/255.0 alpha:1];
}

#pragma mark - gsNavigationShelfDelegate

- (void)didSelectMenuOptionAtIndex:(NSInteger)index {
    [self displayMenuViewControlletAtIndex:index];
}

- (void)didSelectFooterOptionAtIndex:(NSInteger)index {
    [self displayFooterViewControlletAtIndex:index];
}

@end
