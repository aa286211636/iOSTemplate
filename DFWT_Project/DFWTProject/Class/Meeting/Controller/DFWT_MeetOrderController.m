
#import "DFWT_MeetOrderController.h"
#import "DFWT_MeetingSwitchCell.h"
#import "DFWT_MeetingTFCell.h"
#import "BRDatePickerView.h"

@interface DFWT_MeetOrderController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UILabel *tipLb;
@property (nonatomic,strong) BRDatePickerView *dateView;
@end

@implementation DFWT_MeetOrderController{
    NSArray *_titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setLayout];
}

//初始化
- (void)setUI{
    self.view.backgroundColor = DEF_TABLEBGCOLOR;
    self.navigationItem.title = @"预约会议";
    _titleArr = @[@[@"会议名称"],@[@"开始时间",@"结束时间",@"周期性会议",@"周期性结束时间"],@[@"日历提醒"],@[@"会议人数上限"],@[@"会议密码"],@[@"上传文档",@"允许成员上传文档"],@[@"投票"],@[@"开启等候室",@"允许成员在出主持人进会前加入会议"],@[@"成员入会时静音"]];
    [self.view addSubview:self.table];
}

//布局
- (void)setLayout{
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-DEF_SafeBotoomH);
    }];
}

//UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArr.count;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = _titleArr[section];
    return arr.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   //普通cell
    if ((indexPath.section == 1 && indexPath.row != 2) || indexPath.section == 3 || (indexPath.section == 5 && indexPath.row == 0) || indexPath.section == 6 || indexPath.section == 8) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = _titleArr[indexPath.section][indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        if (indexPath.section == 5 || indexPath.section == 6 || indexPath.section == 8) {
            cell.detailTextLabel.textColor = DEF_APPCOLOR;
            cell.detailTextLabel.text = indexPath.section == 8 ? @"超过6人后自动开启":@"点击添加";
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.detailTextLabel.text = nil;
            cell.detailTextLabel.textColor = DEF_HEXColor(0x40404B);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    //输入框cell
    }else if(indexPath.section == 0){
        DFWT_MeetingTFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DFWT_MeetingTFCell"];
        cell.font = [UIFont systemFontOfSize:15];
        cell.inputText = _titleArr[indexPath.section][indexPath.row];
        cell.leading = 20;
        cell.trailing = 20;
        return cell;
    //开关cell
    }else{
        DFWT_MeetingSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DFWT_MeetingSwitchCell"];
        cell.customFont = [UIFont systemFontOfSize:16];
        cell.leadingSpace = 20;
        cell.trailingSpace = 20;
        cell.name = _titleArr[indexPath.section][indexPath.row];
        return  cell;
    }

}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 3 ? 40:10;
};

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"header"];
        header.contentView.backgroundColor = DEF_TABLEBGCOLOR;
    }
    if(section == 3){
        [header addSubview:self.tipLb];
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  0.01;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row != 2) {
        [self.dateView show];
        self.dateView.resultBlock = ^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
            
        };
    }
   
}

//懒加载控件
- (UITableView *)table{
if (!_table) {
    _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _table.showsVerticalScrollIndicator = NO;
    _table.backgroundColor = DEF_TABLEBGCOLOR;
    _table.delegate = self;
    _table.dataSource = self;
    _table.estimatedRowHeight = 0;
    _table.estimatedSectionHeaderHeight = 0;
    _table.estimatedSectionFooterHeight = 0;
    _table.tableFooterView = [UIView new];
    [_table registerNib:[UINib nibWithNibName:@"DFWT_MeetingTFCell" bundle:nil] forCellReuseIdentifier:@"DFWT_MeetingTFCell"];
    [_table registerNib:[UINib nibWithNibName:@"DFWT_MeetingSwitchCell" bundle:nil] forCellReuseIdentifier:@"DFWT_MeetingSwitchCell"];
}
return _table;
}

-(UILabel *)tipLb{
    if (!_tipLb) {
        _tipLb = [UILabel new];
        _tipLb.frame = CGRectMake(20, 0, DEF_SCREEN_WIDTH - 20, 40);
        _tipLb.font = [UIFont systemFontOfSize:14];
        _tipLb.textColor = DEF_HEXColor(0xC4C4C4);
        _tipLb.text = @"开启后将收到系统日历提醒";

    }
    return _tipLb;
}

-(BRDatePickerView *)dateView{
    if (!_dateView) {
        _dateView = [[BRDatePickerView alloc]init];
        _dateView.pickerStyle.cancelTextColor = DEF_APPCOLOR;
        _dateView.pickerStyle.doneTextColor = DEF_APPCOLOR;
        // 2.设置属性
        _dateView.pickerMode = BRDatePickerModeDateAndTime;
        _dateView.minDate = [NSDate date];
    }
    return _dateView;
}
@end
