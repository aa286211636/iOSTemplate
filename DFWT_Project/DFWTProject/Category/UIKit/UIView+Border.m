

#import "UIView+Border.h"

@implementation UIView (Border)
+(void)setViewBorder:(UIView *)view color:(UIColor *)color border:(float)border type:(UIViewBorderLineType)borderLineType{
    CALayer *lineLayer = [CALayer layer];
    lineLayer.backgroundColor = color.CGColor;
    switch (borderLineType) {
        case UIViewBorderLineTypeTop:{
            lineLayer.frame = CGRectMake(0, 0, view.frame.size.width, border);
            break;
        }
        case UIViewBorderLineTypeRight:{
            lineLayer.frame = CGRectMake(view.frame.size.width, 0, border, view.frame.size.height);
            break;
        }
        case UIViewBorderLineTypeBottom:{
            lineLayer.frame = CGRectMake(0, view.frame.size.height, view.frame.size.width,border);
            break;
        }
        case UIViewBorderLineTypeLeft:{
            lineLayer.frame = CGRectMake(0, 0, border, view.frame.size.height);
            break;
        }
            
        default:{
            lineLayer.frame = CGRectMake(0, 0, view.frame.size.width-42, border);
            break;
        }
    }
    
    [view.layer addSublayer:lineLayer];
}

@end
