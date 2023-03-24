//
//  DFWT_OutsideHeaderView.h
//  DFWTProject
//
//  Created by Administrator on 2022/10/26.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^AddContactcBlock)(void);
@interface DFWT_OutsideHeaderView : UIView
@property(nonatomic,copy)AddContactcBlock addContactcBlock;
@end

NS_ASSUME_NONNULL_END
