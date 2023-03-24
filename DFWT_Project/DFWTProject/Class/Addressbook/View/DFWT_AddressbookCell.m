

#import "DFWT_AddressbookCell.h"
#import "UIImageView+Letters.h"

@interface DFWT_AddressbookCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *textLb;

@end
@implementation DFWT_AddressbookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgView.layer.masksToBounds = YES;
    self.imgView.layer.cornerRadius = 18;
}

-(void)setImgStr:(NSString *)imgStr{
    _imgStr = imgStr;
    [self.imgView setImageWithString:imgStr color:DEF_RandomColor];
}

-(void)setText:(NSString *)text{
    _text = text;
    self.textLb.text = text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
