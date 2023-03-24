//
//  DFWT_AddressbookHeader.h
//  DFWTProject
//
//  Created by Administrator on 2022/10/25.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class  DFWT_AddressbookHeader;
@protocol DFWT_AddressbookHeaderDelegate <NSObject>

- (void)addressbookHeaderWithUserAccess:(DFWT_AddressbookHeader *)header;
- (void)addressbookHeaderWithOrganization:(DFWT_AddressbookHeader *)header;
- (void)addressbookHeaderWithOutside:(DFWT_AddressbookHeader *)header;
- (void)addressbookHeaderWithFriends:(DFWT_AddressbookHeader *)header;
- (void)addressbookHeaderWithApply:(DFWT_AddressbookHeader *)header;
- (void)addressbookHeaderWithGroup:(DFWT_AddressbookHeader *)header;

@end

@interface DFWT_AddressbookHeader : UIView
@property (nonatomic, weak)id <DFWT_AddressbookHeaderDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
