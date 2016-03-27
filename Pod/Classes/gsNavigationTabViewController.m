
#import "gsNavigationTabViewController.h"
#import "gsNavigationShelf.h"
#import "gsNavigationShelfMenuItem.h"

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface gsNavigationTabViewController () <gsNavigationShelfDataSource, gsNavigationShelfDelegate> {
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
@property (nonatomic, strong, readwrite) NSMutableDictionary *viewControllers;

@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UIView *navigationShelfContainerView;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *leftContentLayoutConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *rightContentLayoutConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *navigationShelfWidthConstraint;

@end

@implementation gsNavigationTabViewController

#pragma mark - Init

- (instancetype)init
{
    assert(false);
}

- (gsNavigationTabViewController *)initWithDataSource:(id<gsNavigationTabDataSource>)dataSource
{
    NSString *bundlePath = [[NSBundle bundleForClass:[gsNavigationTabViewController class]] pathForResource:nil ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    self = [super initWithNibName:@"gsNavigationTabViewController" bundle:bundle];
    if (self != nil) {
        
        self.menuNavigationMenuItemTitles   = [[NSMutableOrderedSet alloc] init];
        self.footerNavigationMenuItemTitles = [[NSMutableOrderedSet alloc] init];
        
        self.menuNavigationMenuItems   = [[NSMutableDictionary alloc] init];
        self.footerNavigationMenuItems = [[NSMutableDictionary alloc] init];
        
        self.viewControllers           = [[NSMutableDictionary alloc] init];
        
        self.tabBarController = [[UITabBarController alloc] init];
        [self.tabBarController.tabBar setHidden:YES];
        
        self.dataSource = dataSource;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationShelf];
    [self setupNavigationShelfConstraints];
}

- (void)viewDidLayoutSubviews {
    if (!joseBoolean) {
        [self setUpContentView];
        joseBoolean = YES;
    }
    navigationShelfWidth = self.navigationShelfWidthConstraint.constant;
    [self setUpColorGradient];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Setup

- (void)setUpContentView {
    [self.tabBarController.view setFrame:self.contentView.frame];
    [self.contentView addSubview:self.tabBarController.view];
    [self addChildViewController:self.tabBarController];
}

- (void)setupGestureRecognizersForViewController:(UIViewController *)vc
{
    UISwipeGestureRecognizer *newSwipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipRightGesture:)];
    [newSwipeRightGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    
    UISwipeGestureRecognizer *newSwipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipLeftGesture:)];
    [newSwipeLeftGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [vc.view addGestureRecognizer:newSwipeRightGestureRecognizer];
    [vc.view addGestureRecognizer:newSwipeLeftGestureRecognizer];
}

- (void)setupNavigationShelf {
    NSString *bundlePath = [[NSBundle bundleForClass:[gsNavigationShelf class]] pathForResource:nil ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSArray *views = [bundle loadNibNamed:@"gsNavigationShelf" owner:nil options:nil];
    self.navigationShelf = views[0];
    self.navigationShelf.dataSource = self;
    self.navigationShelf.delegate = self;
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
        
        if (self.gradientLayer != nil) {
            [self.gradientLayer removeFromSuperlayer];
        }
        
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.frame = self.navigationShelf.bounds;
        self.gradientLayer.colors = [NSArray arrayWithObjects:(id)[self.dataSource.navigationShelfRightGradientColor CGColor], (id)[self.dataSource.navigationShelfLeftGradientColor CGColor], nil];
        self.gradientLayer.locations = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.0f],
                              [NSNumber numberWithFloat:1.0],
                              nil];
        [self.gradientLayer setStartPoint:CGPointMake(1.0, 0.5)];
        [self.gradientLayer setEndPoint:CGPointMake(0.0, 0.5)];
        [self.navigationShelf.layer insertSublayer:self.gradientLayer atIndex:0];
        
    }
}

#pragma mark - Reload

- (void)reloadNavigationShelf
{
    self.navigationShelf.footerHeightConstraint.constant = 44*self.footerNavigationMenuItems.count;
    [self.view setNeedsLayout];
    [self.navigationShelf reloadData];
}

#pragma mark - Setters

- (void)setMenuOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withIcon:(UIImage *)icon withBadgeNumber:(NSInteger)badgeNumber withViewController:(UIViewController *)vc {
    gsNavigationShelfMenuItem *newMenuItem = [[gsNavigationShelfMenuItem alloc] initWithTitle:title withSubtitle:subTitle withIcon:icon withBadgeNumber:badgeNumber];
    [self.menuNavigationMenuItems setObject:newMenuItem forKey:newMenuItem.title];
    [self.menuNavigationMenuItemTitles addObject:newMenuItem.title];
    [self.viewControllers setObject:vc forKey:newMenuItem.title];
    [self setupGestureRecognizersForViewController:vc];
    [self addViewToTabBar:vc withTitle:title];
    [self reloadNavigationShelf];
}

- (void)setFooterOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withViewController:(UIViewController *)vc {
    gsNavigationShelfMenuItem *newMenuItem = [[gsNavigationShelfMenuItem alloc] initWithTitle:title withSubtitle:subTitle withIcon:nil withBadgeNumber:0];
    [self.footerNavigationMenuItems setObject:newMenuItem forKey:newMenuItem.title];
    [self.footerNavigationMenuItemTitles addObject:newMenuItem.title];
    [self.viewControllers setObject:vc forKey:newMenuItem.title];
    [self setupGestureRecognizersForViewController:vc];
    [self addViewToTabBar:vc withTitle:title];
    [self reloadNavigationShelf];
}

- (void)setMenuOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withIcon:(UIImage *)icon withBadgeNumber:(NSInteger)badgeNumber {
    gsNavigationShelfMenuItem *newMenuItem = [[gsNavigationShelfMenuItem alloc] initWithTitle:title withSubtitle:subTitle withIcon:icon withBadgeNumber:badgeNumber];
    [self.menuNavigationMenuItems setObject:newMenuItem forKey:newMenuItem.title];
    [self.menuNavigationMenuItemTitles addObject:newMenuItem.title];
    [self.menuViewControllers removeObjectForKey:newMenuItem.title];
    [self reloadNavigationShelf];
}

- (void)setFooterOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle{
    gsNavigationShelfMenuItem *newMenuItem = [[gsNavigationShelfMenuItem alloc] initWithTitle:title withSubtitle:subTitle withIcon:nil withBadgeNumber:0];
    [self.footerNavigationMenuItems setObject:newMenuItem forKey:newMenuItem.title];
    [self.footerNavigationMenuItemTitles addObject:newMenuItem.title];
    [self.footerViewControllers removeObjectForKey:newMenuItem.title];
    [self reloadNavigationShelf];
}

- (void)addViewToTabBar:(UIViewController *)vc withTitle:(NSString *)vcTitle {
    [self.tabBarController addChildViewController:vc];
    [self.tabBarController setSelectedViewController:vc];
}

#pragma mark - Updaters

- (void)updateMenuOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withIcon:(UIImage *)icon withBadgeNumber:(NSInteger)badgeNumber {
    gsNavigationShelfMenuItem *newMenuItem = [[gsNavigationShelfMenuItem alloc] initWithTitle:title withSubtitle:subTitle withIcon:icon withBadgeNumber:badgeNumber];
    [self.menuNavigationMenuItems setObject:newMenuItem forKey:newMenuItem.title];
    [self.menuNavigationMenuItemTitles addObject:newMenuItem.title];
    [self reloadNavigationShelf];
}

- (void)updateFooterOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle {
    gsNavigationShelfMenuItem *newMenuItem = [[gsNavigationShelfMenuItem alloc] initWithTitle:title withSubtitle:subTitle withIcon:nil withBadgeNumber:0];
    [self.footerNavigationMenuItems setObject:newMenuItem forKey:newMenuItem.title];
    [self.footerNavigationMenuItemTitles addObject:newMenuItem.title];
    [self reloadNavigationShelf];
}

#pragma mark - Display

- (void)displayMenuViewControlletAtIndex:(NSInteger)index {
    NSString *menuItemTitle = [self.menuNavigationMenuItemTitles objectAtIndex:index];
    gsNavigationShelfMenuItem *menuItem = [self.menuNavigationMenuItems objectForKey:menuItemTitle];
    if ([self.menuViewControllers.allKeys containsObject:menuItem.title]) {
        UIViewController *navVC = [self.viewControllers objectForKey:menuItem.title];
        [self.tabBarController setSelectedViewController:navVC];
        [self hideNavigationShelfWithCompletion:nil];
    }
}

- (void)displayFooterViewControlletAtIndex:(NSInteger)index {
    NSString *menuItemTitle = [self.footerNavigationMenuItemTitles objectAtIndex:index];
    gsNavigationShelfMenuItem *menuItem = [self.footerNavigationMenuItems objectForKey:menuItemTitle];
    if ([self.footerViewControllers.allKeys containsObject:menuItem.title]) {
        UIViewController *navVC = [self.viewControllers objectForKey:menuItem.title];
        [self.tabBarController setSelectedViewController:navVC];
        [self hideNavigationShelfWithCompletion:nil];
    }
}

#pragma mark - IBActions

- (void)handleSwipLeftGesture:(UISwipeGestureRecognizer *)recognizer
{
    [self hideNavigationShelfWithCompletion:nil];
}

- (void)handleSwipRightGesture:(UISwipeGestureRecognizer *)recognizer
{
    [self displayLeftViewControllerWithCompletion:nil];
}

#pragma mark - Presenting the Left-Hand View

- (void)displayLeftViewControllerWithCompletion:(void (^)(BOOL finished))completion
{
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

- (void)hideNavigationShelfWithCompletion:(void (^)(BOOL finished))completion
{
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

- (NSInteger)numberOfMenuOptions
{
    NSInteger output = self.menuNavigationMenuItems.count;
    return output;
}

- (NSInteger)numberOfFooterOptions
{
    return self.footerNavigationMenuItems.count;
}

- (gsNavigationShelfMenuItem *)menuItemForMenuOptionAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *menuItemTitle = [self.menuNavigationMenuItemTitles objectAtIndex:indexPath.row];
    return [self.menuNavigationMenuItems objectForKey:menuItemTitle];
}

- (gsNavigationShelfMenuItem *)menuItemForFooterOptionAtIndexPath:(NSIndexPath *)indexPath
{
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

- (UIColor *)textColor
{
    return [self.dataSource navigationShelfTextColor];
}

#pragma mark - gsNavigationShelfDelegate

- (void)didSelectMenuOptionAtIndex:(NSInteger)index {
    assert(false);
}

- (void)didSelectFooterOptionAtIndex:(NSInteger)index {
    assert(false);
}

@end
