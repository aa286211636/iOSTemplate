

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^InputBlock)(NSString *inputText);
@interface DFWT_MeetingTFCell : UITableViewCell
@property(nonatomic,copy) NSString *placeHolder;
@property(nonatomic,copy) NSString *inputText;
@property(nonatomic,assign)UIKeyboardType keyboaredType;
@property(nonatomic,copy) InputBlock inputBlock;
@property(nonatomic,strong)UIFont *font;
@property (nonatomic,assign)CGFloat leading;
@property (nonatomic,assign)CGFloat trailing;
@property (nonatomic,assign)NSInteger maxLength;
@end

NS_ASSUME_NONNULL_END
