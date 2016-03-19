
#import <UIKit/UIKit.h>
#import "gsNavigationShelf.h"

@protocol gsNavigationTabDataSource <NSObject>

@required
- (UIImage *)navigationHeaderImage;

@optional
- (UIColor *)navigationShelfTextColor;
- (UIColor *)navigationShelfBadgeColor;
- (UIColor *)navigationShelfLeftGradientColor;
- (UIColor *)navigationShelfRightGradientColor;

@end

@interface gsNavigationTabViewController : UIViewController

@property (nonatomic, strong) id<gsNavigationTabDataSource>dataSource;

@property (nonatomic, strong) gsNavigationShelf *navigationShelf;

- (gsNavigationTabViewController *)initWithDataSource:(id<gsNavigationTabDataSource>)dataSource;

- (void)setMenuOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withIconGlyph:(NSString *)glyph withBadgeNumber:(NSInteger)badgeNumber withViewController:(UIViewController *)vc;
- (void)setFooterOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withViewController:(UIViewController *)vc;

- (void)setMenuOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withIconGlyph:(NSString *)glyph withBadgeNumber:(NSInteger)badgeNumber;
- (void)setFooterOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle;

- (void)updateMenuOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withIconGlyph:(NSString *)glyph withBadgeNumber:(NSInteger)badgeNumber;
- (void)updateFooterOptionWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle;

- (void)displayMenuViewControlletAtIndex:(NSInteger)index;
- (void)displayFooterViewControlletAtIndex:(NSInteger)index;
- (void)hideNavigationShelfWithCompletion:(void (^)(BOOL finished))completion;

@end
