//
//  ZYYL_SearchView.h
//  Test
//
//  Created by Administrator on 2021/4/13.
//  Copyright © 2021 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^SearchBlock)(NSString *searchText);
@interface DFWT_SearchView : UIView
@property(nonatomic,copy)SearchBlock searchBlock;
@end

NS_ASSUME_NONNULL_END
