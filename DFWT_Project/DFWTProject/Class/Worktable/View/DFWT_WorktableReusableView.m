//
//  DFWT_WorktableReusableView.m
//  DFWTProject
//
//  Created by Administrator on 2022/10/20.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_WorktableReusableView.h"
@interface DFWT_WorktableReusableView()
@property (weak, nonatomic) IBOutlet UILabel *textLb;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIImageView *expandImg;
@end

@implementation DFWT_WorktableReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setText:(NSString *)text{
    _text = text;
    self.textLb.text = text;
}
-(void)setHasMore:(BOOL)hasMore{
    _hasMore = hasMore;
    self.moreBtn.hidden = !hasMore;
}
-(void)setCanExpand:(BOOL)canExpand{
    _canExpand = canExpand;
    self.expandImg.hidden = !canExpand;
}
@end
