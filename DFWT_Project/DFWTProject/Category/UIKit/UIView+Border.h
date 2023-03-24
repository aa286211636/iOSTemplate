

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, UIViewBorderLineType) {
    UIViewBorderLineTypeTop,
    UIViewBorderLineTypeRight,
    UIViewBorderLineTypeBottom,
    UIViewBorderLineTypeLeft,
};


@interface UIView (Border)
+(void)setViewBorder:(UIView *)view color:(UIColor *)color border:(float)border type:(UIViewBorderLineType)borderLineType;
@end

NS_ASSUME_NONNULL_END
