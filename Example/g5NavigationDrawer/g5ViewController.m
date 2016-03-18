//
//  g5ViewController.m
//  g5NavigationDrawer
//
//  Created by cliffhanger62 on 03/13/2016.
//  Copyright (c) 2016 cliffhanger62. All rights reserved.
//

#import "g5ViewController.h"

@interface g5ViewController () <gsNavigationTabDataSource> 

@end

@implementation g5ViewController

- (instancetype)init
{
    self = [super initWithDataSource:self];
    if (self != nil) {
//        UIViewController *menuVC1 = [[UIViewController alloc] init];
//        [menuVC1.view setBackgroundColor:[UIColor redColor]];
//        
//        UIViewController *menuVC2 = [[UIViewController alloc] init];
//        [menuVC2.view setBackgroundColor:[UIColor yellowColor]];
//        
//        UIViewController *menuVC3 = [[UIViewController alloc] init];
//        [menuVC3.view setBackgroundColor:[UIColor blueColor]];
//        
//        UIViewController *footerVC1 = [[UIViewController alloc] init];
//        [footerVC1.view setBackgroundColor:[UIColor purpleColor]];
//        
//        [self setMenuOptionWithTitle:@"Menu Option 1" withSubtitle:nil withIconGlyph:nil withBadgeNumber:0 withViewController:menuVC1];
//        [self setMenuOptionWithTitle:@"Menu Option 2" withSubtitle:@"Menu Option Subtitle" withIconGlyph:nil withBadgeNumber:0 withViewController:menuVC2];
//        [self setMenuOptionWithTitle:@"Menu Option 3" withSubtitle:nil withIconGlyph:nil withBadgeNumber:3 withViewController:menuVC3];
//        
//        [self setFooterOptionWithTitle:@"Footer Option" withSubtitle:@"Footer Subtitle" withViewController:footerVC1];
//        
//        [self displayMenuViewControlletAtIndex:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - gsNavigationTabDataSource

- (UIImage *)navigationHeaderImage {
    return [UIImage imageNamed:@"LogoImage"];
}

@end
