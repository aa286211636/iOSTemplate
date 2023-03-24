//
//  DFWT_AttendanceCell.m
//  DFWTProject
//
//  Created by Administrator on 2022/11/1.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_AttendanceCell.h"
@interface DFWT_AttendanceCell()
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *onTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *attenceTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UIImageView *addressImg;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
@implementation DFWT_AttendanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.circleView.layer.cornerRadius= 5;
    self.circleView.layer.masksToBounds = YES;
}

-(void)setIsDone:(BOOL)isDone{
    _isDone = isDone;
    self.attenceTimeLb.hidden = self.addressLb.hidden = self.addressImg.hidden = self.lineView.hidden = !isDone;
}

-(void)setIsHideLine:(BOOL)isHideLine{
    _isHideLine = isHideLine;
    self.lineView.hidden = isHideLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
