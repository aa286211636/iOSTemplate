

#import "DFWT_MeetingSwitchCell.h"
@interface DFWT_MeetingSwitchCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UISwitch *swtBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailing;

@end
@implementation DFWT_MeetingSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setName:(NSString *)name{
    _name = name;
    self.nameLb.text = name;
}

-(void)setLeadingSpace:(CGFloat)leadingSpace{
    _leadingSpace = leadingSpace;
    self.leading.constant = leadingSpace;
}

-(void)setTrailingSpace:(CGFloat)trailingSpace{
    _trailingSpace = trailingSpace;
    self.trailing.constant = trailingSpace;
}

- (void)setCustomFont:(UIFont *)customFont{
    _customFont = customFont;
    self.nameLb.font = customFont;
}

-(void)setCustomColor:(UIColor *)customColor{
    _customColor = customColor;
    self.nameLb.textColor = customColor;
}

- (IBAction)swtChange:(UISwitch *)sender {
    if (self.switchBlock) {
        self.switchBlock(sender.isOn);
    }
}

-(void)setOn:(BOOL)on{
    _on = on;
    self.swtBtn.on = on;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
