//
//  DFWT_AttendanceFooter.m
//  DFWTProject
//
//  Created by Administrator on 2022/11/1.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_AttendanceFooter.h"
@interface DFWT_AttendanceFooter()
@property (weak, nonatomic) IBOutlet UILabel *dakaLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;

@end
@implementation DFWT_AttendanceFooter

-(void)setTime:(NSString *)time{
    _time = time;
    self.timeLb.text = time;
}

@end
