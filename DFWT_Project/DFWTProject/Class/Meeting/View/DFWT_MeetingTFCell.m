
#import "DFWT_MeetingTFCell.h"

@interface DFWT_MeetingTFCell()
@property (weak, nonatomic) IBOutlet UITextField *intputTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingConstraint;


@end

@implementation DFWT_MeetingTFCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.intputTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

//监听输入
- (void)textFieldDidChange:(UITextField *)textField {
    if (self.inputBlock) {
        self.inputBlock(textField.text);
    }
}

-(void)setLeading:(CGFloat)leading{
    _leading  = leading;
    self.leadingConstraint.constant = leading;
}

-(void)setTrailing:(CGFloat)trailing{
    _trailing = trailing;
    self.trailingConstraint.constant = trailing;
}

-(void)setFont:(UIFont *)font{
    _font = font;
    self.intputTF.font = font;
}

-(void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    self.intputTF.placeholder = placeHolder;
}

-(void)setInputText:(NSString *)inputText{
    _inputText = inputText;
    self.intputTF.text = inputText;
}

-(void)setMaxLength:(NSInteger)maxLength{
    _maxLength = maxLength;
    self.intputTF.maxLength = maxLength;
}

- (void)setKeyboaredType:(UIKeyboardType)keyboaredType{
    _keyboaredType = keyboaredType;
    //重置键盘类型
    [self.intputTF setKeyboardType:keyboaredType];
    [self.intputTF reloadInputViews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
