//
//  DFWT_MeetHistoryCell.m
//  DFWTProject
//
//  Created by Administrator on 2022/10/28.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_MeetHistoryCell.h"

@interface DFWT_MeetHistoryCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *typeLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *countLb;

@end
@implementation DFWT_MeetHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLb.text = title;
}

-(void)setTime:(NSString *)time{
    _time = time;
    self.timeLb.text = time;
}

-(void)setCount:(NSString *)count{
    _count = count;
    self.countLb.text = count;
}

-(void)setType:(MeetTypes)type{
    switch (type) {
        case 0:
            self.imgView.image = [UIImage imageNamed:@"state_video_sel"];
            self.typeLb.text = @"【视频】";
            break;
        case 1:
            self.imgView.image = [UIImage imageNamed:@"state_audio_sel"];
            self.typeLb.text = @"【语音】";
            break;
        case 2:
            self.imgView.image = [UIImage imageNamed:@"state_phone_sel"];
            self.typeLb.text = @"【电话】";
            break;
        case 3:
            self.imgView.image = [UIImage imageNamed:@"state_video_nor"];
            self.typeLb.text = @"【视频】";
            break;
        case 4:
            self.imgView.image = [UIImage imageNamed:@"state_audio_nor"];
            self.typeLb.text = @"【语音】";
            break;
        case 5:
            self.imgView.image = [UIImage imageNamed:@"state_phone_nor"];
            self.typeLb.text = @"【电话】";
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
