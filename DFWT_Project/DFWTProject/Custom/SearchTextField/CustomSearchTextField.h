//延时搜索框

#import <UIKit/UIKit.h>

@interface CustomSearchTextField : UITextField
@property (nonatomic, copy) void(^inputTextFiledChangeTextHandler)(NSString *text);
@property (nonatomic, assign) CGFloat delayTime;
- (void)startObserverChangeText;
@end

