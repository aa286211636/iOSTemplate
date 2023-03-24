

#import "UITextField+MaxLength.h"
#import <objc/runtime.h>
@implementation UITextField (MaxLength)

static char kMaxLengthKey;

+ (void)load {
    //使用Xib，StoryBoard创建的UITextField
    Method  method1 = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method  method2 = class_getInstanceMethod([self class], @selector(AdapterinitWithCoder:));
    
    //使用initWithFrame创建的UITextField
    Method method3 = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method method4 = class_getInstanceMethod([self class], @selector(AdapterinitWithFrame:));
    method_exchangeImplementations(method1, method2);
    
    method_exchangeImplementations(method3, method4);
    
}

- (instancetype)AdapterinitWithFrame:(CGRect)frame {
    [self AdapterinitWithFrame:frame];
    if (self) {
        //注册观察UITextField输入变化的方法。
        [self addLengthObserverEvent];
    }
    return self;
}


- (instancetype)AdapterinitWithCoder:(NSCoder *)aDecoder {
    [self AdapterinitWithCoder:aDecoder];
    if (self) {
        [self addLengthObserverEvent];
    }
    return self;
}

- (void)setMaxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, &kMaxLengthKey, @(maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSInteger)maxLength {
    NSNumber * number = objc_getAssociatedObject(self, &kMaxLengthKey);
    return  [number integerValue];
}

- (void)addLengthObserverEvent {
    [self addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)valueChange {
    if (self.maxLength > 0 && self.text.length > self.maxLength) {
        self.text = [self.text substringToIndex:self.maxLength];
    }
}
@end
