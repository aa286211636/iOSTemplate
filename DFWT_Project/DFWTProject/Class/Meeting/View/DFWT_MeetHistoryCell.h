//
//  DFWT_MeetHistoryCell.h
//  DFWTProject
//
//  Created by Administrator on 2022/10/28.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum: NSUInteger {
    MeetVideoConnectType,
    MeetAudioConnectType,
    MeetPhoneConnectType,
    MeetVideoDisconnectType,
    MeetAudioDisconnectType,
    MeetPhoneDisconnectType,
} MeetTypes;

NS_ASSUME_NONNULL_BEGIN

@interface DFWT_MeetHistoryCell : UITableViewCell
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *time;
@property (nonatomic, copy)NSString *count;
@property (nonatomic, assign)MeetTypes type;

@end

NS_ASSUME_NONNULL_END
