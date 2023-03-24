//
//  ZYYL_SearchView.m
//  Test
//
//  Created by Administrator on 2021/4/13.
//  Copyright © 2021 Administrator. All rights reserved.
//

#import "DFWT_SearchView.h"
#import "CustomSearchTextField.h"

@interface DFWT_SearchView()
@property (weak, nonatomic) IBOutlet CustomSearchTextField *textFiled;
@property (nonatomic,copy)NSString *searchText;

@end

@implementation DFWT_SearchView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    DEF_WeakSelf(self);
    self.textFiled.placeholder = @"";
    //输入框改变事件
    self.textFiled.inputTextFiledChangeTextHandler = ^(NSString *text) {
        DEF_StrongSelf(weakSelf);
        if (strongSelf.searchBlock) {
            strongSelf.searchBlock(text);
        }
    };
}


@end
