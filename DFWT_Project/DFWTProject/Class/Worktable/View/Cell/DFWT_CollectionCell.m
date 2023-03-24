//
//  DFWT_WorktableCell.m
//  DFWTProject
//
//  Created by Administrator on 2022/10/19.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_CollectionCell.h"

@interface DFWT_CollectionCell()
@property (weak, nonatomic) IBOutlet UILabel *textLb;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation DFWT_CollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setText:(NSString *)text{
    _text = text;
    self.textLb.text = text;
}

-(void)setImgName:(NSString *)imgName{
    _imgName = imgName;
    self.imgV.image = [UIImage imageNamed:imgName];
}
@end
