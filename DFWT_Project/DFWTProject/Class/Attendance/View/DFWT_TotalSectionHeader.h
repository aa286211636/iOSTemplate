//
//  DFWT_TotalSectionHeader.h
//  DFWTProject
//
//  Created by Administrator on 2022/11/2.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^HeaderBlock)(void);

@interface DFWT_TotalSectionHeader : UITableViewHeaderFooterView
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *count;
@property (nonatomic,copy) HeaderBlock headerBlock;
@end

NS_ASSUME_NONNULL_END
