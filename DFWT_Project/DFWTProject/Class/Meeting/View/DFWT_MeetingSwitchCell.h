
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SwitchBlock)(BOOL on);

@interface DFWT_MeetingSwitchCell : UITableViewCell
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) SwitchBlock switchBlock;
@property (nonatomic,strong) UIColor *customColor;
@property (nonatomic,strong) UIFont *customFont;
@property (nonatomic,assign) CGFloat leadingSpace;
@property (nonatomic,assign) CGFloat trailingSpace;
@property (nonatomic,assign) BOOL on;
@end

NS_ASSUME_NONNULL_END
