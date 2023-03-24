//延时搜索框

#import "CustomSearchTextField.h"

typedef void(^Custom_gcdTask)(BOOL cancel);
typedef void(^Custom_gcdBlock)(void);

@interface CustomGCDDelay : NSObject

+ (Custom_gcdTask)gcdDelay:(NSTimeInterval)time task:(Custom_gcdBlock)block;
+ (void)gcdCancel:(Custom_gcdTask)task;
@end


@implementation CustomGCDDelay

+ (void)gcdLater:(NSTimeInterval)time block:(Custom_gcdBlock)block{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

+ (Custom_gcdTask)gcdDelay:(NSTimeInterval)time task:(Custom_gcdBlock)block{
    __block dispatch_block_t closure = block;
    __block Custom_gcdTask result;
    Custom_gcdTask delayedClosure = ^(BOOL cancel){
        if (closure) {
            if (!cancel) {
                dispatch_async(dispatch_get_main_queue(), closure);
            }
        }
        closure = nil;
        result = nil;
    };
    result = delayedClosure;
    [self gcdLater:time block:^{
        if (result)
            result(NO);
    }];
    
    return result;
}

+ (void)gcdCancel:(Custom_gcdTask)task{
    task(YES);
}
@end

@interface CustomSearchTextField ()

@property (nonatomic, copy) Custom_gcdTask task;

@end

#define kDelayTime 0.6f
@implementation CustomSearchTextField

- (instancetype)init {
    if (self = [super init]) {
        self.delayTime = -1;
        [self startObserverChangeText];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delayTime = -1;
        [self startObserverChangeText];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        self.delayTime = -1;
        [self startObserverChangeText];
    }
    return self;
}

- (void)startObserverChangeText {
    [self addTarget:self action:@selector(searchTextChangeAction:) forControlEvents:UIControlEventEditingChanged];
}

- (void)searchTextChangeAction:(UITextField *)textField {
    if (self.task) {
        [CustomGCDDelay gcdCancel:self.task];
    }
    __weak typeof(self) weakSelf = self;
    CGFloat d_time = self.delayTime != -1 ? self.delayTime : kDelayTime;
    self.task = [CustomGCDDelay gcdDelay:d_time task:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.inputTextFiledChangeTextHandler) {
            strongSelf.inputTextFiledChangeTextHandler(strongSelf.text);
        }
    }];
}

@end
