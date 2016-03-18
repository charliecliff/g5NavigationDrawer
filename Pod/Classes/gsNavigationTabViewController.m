
#import "gsNavigationTabViewController.h"
#import "gsNavigationShelf.h"
#import "gsNavigationShelfMenuItem.h"

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface gsNavigationTabViewController () <gsNavigationShelfDataSource> {
    BOOL joseBoolean;
    
    CGFloat navigationShelfWidth;
    BOOL navigationShelfIsDisplayed;
}

@property (nonatomic, strong, readwrite) NSMutableOrderedSet *menuNavigationMenuItemTitles;
@property (nonatomic, strong, readwrite) NSMutableOrderedSet *footerNavigationMenuItemTitles;
@property (nonatomic, strong, readwrite) NSMutableDictionary *menuNavigationMenuItems;
@property (nonatomic, strong, readwrite) NSMutableDictionary *footerNavigationMenuItems;
@property (nonatomic, strong, readwrite) NSMutableDictionary *menuViewControllers;
@property (nonatomic, strong, readwrite) NSMutableDictionary *footerViewControllers;
@property (nonatomic, strong, readwrite) NSMutableDictionary *childViewControllers;

//@property (nonatomic, strong, readwrite) NSMutableDictionary *navigationViewControllers;

@property (nonatomic, strong) UITabBarController *tabBarController;

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UIView *navigationShelfContainerView;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *leftContentLayoutConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *rightContentLayoutConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *navigationShelfWidthConstraint;

@end

@implementation gsNavigationTabViewController

#pragma mark - Init

- (gsNavigationTabViewController *)initWithDataSource:(id<gsNavigationTabDataSource>)dataSource
{
    
//    NSArray *bundles = [[NSBundle mainBundle] pathsForResourcesOfType:@"bundle" inDirectory:nil];
//    
//    
//
//    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"g5NavigationDrawer" ofType:@"bundle"];
//    
//    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
//    self = [super initWithNibName:@"gsNavigationTabViewController" bundle:bundle];

    NSString *bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:nil ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    NSBundle *bundle2 = [NSBundle bundleForClass:[self class]];
    
    
    NSArray *bundles = [bundle pathsForResourcesOfType:@"xib" inDirectory:nil];

    
    self = [super initWithNibName:@"gsNavigationTabViewController" bundle:bundle];
    
    if (self != nil) {
        
        self.menuNavigationMenuItemTitles   = [[NSMutableOrderedSet alloc] init];
        self.footerNavigationMenuItemTitles = [[NSMutableOrderedSet alloc] init];
        
        self.menuNavigationMenuItems   = [[NSMutableDictionary alloc] init];
        self.footerNavigationMenuItems = [[NSMutableDictionary alloc] init];
        
        self.menuViewControllers       = [[NSMutableDictionary alloc] init];
        self.footerViewControllers     = [[NSMutableDictionary alloc] init];
        self.childViewControllers      = [[NSMutableDictionary alloc] init];
        
        self.tabBarController = [[UITabBarController alloc] init];
        [self.tabBarController.tabBar setHidden:YES];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self setupGestureRecognizersForMenuViewControllers];
//    [self setupGestureRecognizersForFooterViewControllers];
//    [self setupNavigationShelf];
//    [self setupNavigationShelfConstraints];
}

- (void)viewDidLayoutSubviews {
//    if (!joseBoolean) {
//        [self setUpContentView];
//        joseBoolean = YES;
//    }
//    navigationShelfWidth = self.navigationShelfWidthConstraint.constant;
//    [self setUpColorGradient];
}

#pragma mark - Setup

- (void)setUpContentView {
    [self.tabBarController.view setFrame:self.contentView.frame];
    [self.contentView addSubview:self.tabBarController.view];
    [self addChildViewController:self.tabBarController];
}

- (void)setupGestureRecognizersForMenuViewControllers {
    
    for (UIViewController *currentVC in self.menuViewControllers.allValues) {
        
        UISwipeGestureRecognizer *newSwipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipRightGesture:)];
        [newSwipeRightGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
        
        UISwipeGestureRecognizer *newSwipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipLeftGesture:)];
        [newSwipeLeftGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
        
        [currentVC.view addGestureRecognizer:newSwipeRightGestureRecognizer];
        [currentVC.view addGestureRecognizer:newSwipeLeftGestureRecognizer];
    }
}

- (void)setupGestureRecognizersForFooterViewControllers {
    
    for (UIViewController *currentVC in self.footerViewControllers.allValues) {
        
        UISwipeGestureRecognizer *newSwipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipRightGesture:)];
        [newSwipeRightGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
        
        UISwipeGestureRecognizer *newSwipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipLeftGesture:)];
        [newSwipeLeftGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
        
        [currentVC.view addGestureRecognizer:newSwipeRightGestureRecognizer];
        [currentVC.view addGestureRecognizer:newSwipeLeftGestureRecognizer];
    }
}

//- (void)configureNavigationBarForNavigationController:(UINavigationController *)navVC withTitle:(NSString *)navVCTitle {
//    [navVC.navigationBar setBarStyle:UIBarStyleBlackOpaque];
//    [navVC.navigationBar setBarTintColor:[UIColor purpleColor]];
//    [navVC setNavigationBarHidden:YES];
//    
//    UIBarButtonItem *navBarItem = [[UIBarButtonItem alloc] initWithTitle:@"\ue607" style:UIBarButtonItemStylePlain target:self action:@selector(leftButton)];
//    
////    UIFont *glyphFont = [gsUIKitUtilities loadUIFontWithName:@"gs-fonts" withSize:30];
////    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:glyphFont, NSFontAttributeName, nil];
////    [navBarItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
//    
//    [navVC.navigationBar.topItem setLeftBarButtonItem:navBarItem];
//}

- (void)setupNavigationShelf {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gsUIKitResources" ofType:@"bundle"];
    NSBundle *resourcesBundle = [NSBundle bundleWithPath:path];
    NSArray *views = [resourcesBundle loadNibNamed:@"gsNavigationShelf" owner:nil options:nil];
    self.navigationShelf = views[0];
    self.navigationShelf.dataSource = self;
    [self.navigationShelf reloadData];
}

- (void)setupNavigationShelfConstraints {
    [self.navigationShelfContainerView addSubview:self.navigationShelf];
    [self.navigationShelf setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.navigationShelfContainerView addConstraint:[NSLayoutConstraint constraintWithItem:self.navigationShelf
                                                                                  attribute:NSLayoutAttributeTop
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.navigationShelfContainerView
                                                                                  attribute:NSLayoutAttributeTop
                                                                                 multiplier:1.0
                                                                                   constant:0.0]];
    
    [self.navigationShelfContainerView addConstraint:[NSLayoutConstraint constraintWithItem:self.navigationShelf
                                                                                  attribute:NSLayoutAttributeLeading
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.navigationShelfContainerView
                                                                                  attribute:NSLayoutAttributeLeading
                                                                                 multiplier:1.0
                                                                                   constant:0.0]];
    
    [self.navigationShelfContainerView addConstraint:[NSLayoutConstraint constraintWithItem:self.navigationShelf
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.navigationShelfContainerView
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                 multiplier:1.0
                                                                                   constant:0.0]];
    
    [self.navigationShelfContainerView addConstraint:[NSLayoutConstraint constraintWithItem:self.navigationShelf
                                                                                  attribute:NSLayoutAttributeTrailing
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.navigationShelfContainerView
                                                                                  attribute:NSLayoutAttributeTrailing
                                                                                 multiplier:1.0
                                                                                   constant:0.0]];
}

- (void)setUpColorGradient {
    if ([self.dataSource respondsToSelector:@selector(navigationShelfLeftGradientColor)] && [self.dataSource respondsToSelector:@selector(navigationShelfRightGradientColor)]) {

        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.navigationShelf.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[self.dataSource.navigationShelfRightGradientColor CGColor], (id)[self.dataSource.navigationShelfLeftGradientColor CGColor], nil];
        gradient.locations = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.0f],
                              [NSNumber numberWithFloat:1.0],
                              nil];
        [gradient setStartPoint:CGPointMake(0.0, 0.5)];
        [gradient setEndPoint:CGPointMake(1.0, 0.5)];
        [self.navigationShelf.layer insertSublayer:gradient atIndex:0];
    
    }
}

#pragma mark - Reload

- (void)reload {
    [self.navigationShelf reloadData];
}

#pragma mark - Setters

- (void)setMenuOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withIconGlyph:(NSString *)glyph withBadgeNumber:(NSInteger)badgeNumber withViewController:(UIViewController *)vc {
    gsNavigationShelfMenuItem *newMenuItem = [[gsNavigationShelfMenuItem alloc] initWithTitle:title withSubtitle:subTitle withGlyph:glyph withBadgeNumber:badgeNumber];
    [self.menuViewControllers setObject:vc forKey:newMenuItem.title];
    [self.menuNavigationMenuItems setObject:newMenuItem forKey:newMenuItem.title];
    if (![self.menuNavigationMenuItemTitles containsObject:newMenuItem.title]) {
        [self.menuNavigationMenuItemTitles addObject:newMenuItem.title];
    }
    [self addViewToTabBar:vc withTitle:title];
    [self reload];
}

- (void)setFooterOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withViewController:(UIViewController *)vc {
    gsNavigationShelfMenuItem *newMenuItem = [[gsNavigationShelfMenuItem alloc] initWithTitle:title withSubtitle:subTitle withGlyph:nil withBadgeNumber:0];
    [self.footerViewControllers setObject:vc forKey:newMenuItem.title];
    [self.footerNavigationMenuItems setObject:newMenuItem forKey:newMenuItem.title];
    if (![self.footerNavigationMenuItemTitles containsObject:newMenuItem.title]) {
        [self.footerNavigationMenuItemTitles addObject:newMenuItem.title];
    }
    [self addViewToTabBar:vc withTitle:title];
    [self reload];
}

- (void)setMenuOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withIconGlyph:(NSString *)glyph withBadgeNumber:(NSInteger)badgeNumber {
    gsNavigationShelfMenuItem *newMenuItem = [[gsNavigationShelfMenuItem alloc] initWithTitle:title withSubtitle:subTitle withGlyph:glyph withBadgeNumber:badgeNumber];
    [self.menuNavigationMenuItems setObject:newMenuItem forKey:newMenuItem.title];
    if (![self.menuNavigationMenuItemTitles containsObject:newMenuItem.title]) {
        [self.menuNavigationMenuItemTitles addObject:newMenuItem.title];
    }
    [self.menuViewControllers removeObjectForKey:newMenuItem.title];
    [self reload];
}

- (void)setFooterOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle{
    gsNavigationShelfMenuItem *newMenuItem = [[gsNavigationShelfMenuItem alloc] initWithTitle:title withSubtitle:subTitle withGlyph:nil withBadgeNumber:0];
    [self.footerNavigationMenuItems setObject:newMenuItem forKey:newMenuItem.title];
    if (![self.footerNavigationMenuItemTitles containsObject:newMenuItem.title]) {
        [self.footerNavigationMenuItemTitles addObject:newMenuItem.title];
    }
    [self.footerViewControllers removeObjectForKey:newMenuItem.title];
    [self reload];
}

- (void)addViewToTabBar:(UIViewController *)vc withTitle:(NSString *)vcTitle {
    [self.childViewControllers setObject:vc forKey:vcTitle];
    [self.tabBarController addChildViewController:vc];
    [self.tabBarController setSelectedViewController:vc];
}

#pragma mark - Updaters

- (void)updateMenuOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withIconGlyph:(NSString *)glyph withBadgeNumber:(NSInteger)badgeNumber {
    gsNavigationShelfMenuItem *newMenuItem = [[gsNavigationShelfMenuItem alloc] initWithTitle:title withSubtitle:subTitle withGlyph:glyph withBadgeNumber:badgeNumber];
    [self.menuNavigationMenuItems setObject:newMenuItem forKey:newMenuItem.title];
    if (![self.menuNavigationMenuItemTitles containsObject:newMenuItem.title]) {
        [self.menuNavigationMenuItemTitles addObject:newMenuItem.title];
    }
    [self reload];
}

- (void)updateFooterOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle {
    gsNavigationShelfMenuItem *newMenuItem = [[gsNavigationShelfMenuItem alloc] initWithTitle:title withSubtitle:subTitle withGlyph:nil withBadgeNumber:0];
    [self.footerNavigationMenuItems setObject:newMenuItem forKey:newMenuItem.title];
    if (![self.footerNavigationMenuItemTitles containsObject:newMenuItem.title]) {
        [self.footerNavigationMenuItemTitles addObject:newMenuItem.title];
    }
    [self reload];
}

#pragma mark - Display

- (void)displayMenuViewControlletAtIndex:(NSInteger)index {
    NSString *menuItemTitle = [self.menuNavigationMenuItemTitles objectAtIndex:index];
    gsNavigationShelfMenuItem *menuItem = [self.menuNavigationMenuItems objectForKey:menuItemTitle];
    if ([self.menuViewControllers.allKeys containsObject:menuItem.title]) {
        UIViewController *navVC = [self.childViewControllers objectForKey:menuItem.title];
        [self.tabBarController setSelectedViewController:navVC];
        [self hideNavigationShelfWithCompletion:nil];
    }
}

- (void)displayFooterViewControlletAtIndex:(NSInteger)index {
    NSString *menuItemTitle = [self.footerNavigationMenuItemTitles objectAtIndex:index];
    gsNavigationShelfMenuItem *menuItem = [self.footerNavigationMenuItems objectForKey:menuItemTitle];
    if ([self.footerViewControllers.allKeys containsObject:menuItem.title]) {
        UIViewController *navVC = [self.childViewControllers objectForKey:menuItem.title];
        [self.tabBarController setSelectedViewController:navVC];
        [self hideNavigationShelfWithCompletion:nil];
    }
}

#pragma mark - IBActions

- (void)leftButton {
    if (navigationShelfIsDisplayed) {
        [self hideNavigationShelfWithCompletion:nil];
    }
    else {
        [self displayLeftViewControllerWithCompletion:nil];
    }
}

- (void)handleSwipLeftGesture:(UISwipeGestureRecognizer *)recognizer {
    [self hideNavigationShelfWithCompletion:nil];
}

- (void)handleSwipRightGesture:(UISwipeGestureRecognizer *)recognizer {
    [self displayLeftViewControllerWithCompletion:nil];
}

#pragma mark - Presenting the Left-Hand View

- (void)displayLeftViewControllerWithCompletion:(void (^)(BOOL finished))completion {
    self.leftContentLayoutConstraint.constant = 0;
    self.rightContentLayoutConstraint.constant = -navigationShelfWidth;
    
    __block __typeof(self)blockSelf = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [blockSelf.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        navigationShelfIsDisplayed = YES;
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)hideNavigationShelfWithCompletion:(void (^)(BOOL finished))completion {
    self.leftContentLayoutConstraint.constant = -navigationShelfWidth;
    self.rightContentLayoutConstraint.constant = 0;
    
    __block __typeof(self)blockSelf = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [blockSelf.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        navigationShelfIsDisplayed = NO;
        if (completion) {
            completion(finished);
        }
    }];
}

#pragma mark - gsNavigationShelfDataSource

- (NSInteger)numberOfMenuOptions {
    return self.menuNavigationMenuItems.count;
}

- (NSInteger)numberOfFooterOptions {
    return self.footerNavigationMenuItems.count;
}

- (gsNavigationShelfMenuItem *)menuItemForMenuOptionAtIndexPath:(NSIndexPath *)indexPath {
    NSString *menuItemTitle = [self.menuNavigationMenuItemTitles objectAtIndex:indexPath.row];
    return [self.menuNavigationMenuItems objectForKey:menuItemTitle];}

- (gsNavigationShelfMenuItem *)menuItemForFooterOptionAtIndexPath:(NSIndexPath *)indexPath {
    NSString *menuItemTitle = [self.footerNavigationMenuItemTitles objectAtIndex:indexPath.row];
    return [self.footerNavigationMenuItems objectForKey:menuItemTitle];
}

- (UIImage *)headerIcon {
    return [self.dataSource navigationHeaderImage];
}

- (UIColor *)badgeColor {
    return [self.dataSource navigationShelfBadgeColor];
}

- (UIColor *)navigationShelfLeftGradientColor {
    return self.dataSource.navigationShelfLeftGradientColor;
}

- (UIColor *)navigationShelfRightGradientColor {
    return self.dataSource.navigationShelfRightGradientColor;
}

- (UIColor *)textColor {
    return [self.dataSource navigationShelfTextColor];
}

@end
