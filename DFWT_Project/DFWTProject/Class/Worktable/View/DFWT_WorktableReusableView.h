//
//  DFWT_WorktableReusableView.h
//  DFWTProject
//
//  Created by Administrator on 2022/10/20.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFWT_WorktableReusableView : UICollectionReusableView
@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign)BOOL hasMore;
@property(nonatomic,assign)BOOL canExpand;
@end

NS_ASSUME_NONNULL_END
