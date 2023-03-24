//
//  DFWT_WorktableHeaderView.h
//  DFWTProject
//
//  Created by Administrator on 2022/10/21.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView/SDCycleScrollView.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^LeftBtnBlock)(void);
@interface DFWT_WorktableHeaderView : UICollectionReusableView
@property (nonatomic,copy)LeftBtnBlock leftBtnBlock;
@end

NS_ASSUME_NONNULL_END
