

#import "DFWT_CodeController.h"

@interface DFWT_CodeController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
//拼音首字母数组
@property(nonatomic,strong)NSMutableArray *firstLetterArray;
@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation DFWT_CodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadCitysData];
    [self setUI];
}

- (void)setUI{
    self.view.backgroundColor = DEF_TABLEBGCOLOR;
    self.navigationItem.title = @"国家和地区代码";
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-DEF_SafeBotoomH);
    }];
}

//加载本地plist
- (void)loadCitysData {
    self.firstLetterArray = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Code" ofType:@"plist"];
    self.dataArr = [NSArray arrayWithContentsOfFile:path];
    for (NSArray *arr in self.dataArr) {
        //获取当前字母数组的首个国家(国家结构为数组,下标0为名字，下标1为代码)
        NSArray *country = arr.firstObject;
        //获取首个国家的名字
        NSString *name = country.firstObject;
        //首个国家名字的首个汉字
        name = [name substringToIndex:1];
        //首个汉字转拼音
        [self.firstLetterArray addObject:[self FirstCharactor:name]];
    }
}

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)FirstCharactor:(NSString *)pString{
    //转成了可变字符串
    NSMutableString *pStr = [NSMutableString stringWithString:pString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)pStr,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)pStr,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pPinYin = [pStr capitalizedString];
    //获取并返回首字母
    return [pPinYin substringToIndex:1];
}

//UITableViewDelegate
//section行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataArr count];
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.firstLetterArray;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"header"];
        header.contentView.backgroundColor = DEF_TABLEBGCOLOR;
    }
    return header;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.firstLetterArray[section];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}



//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *item = self.dataArr[indexPath.section][indexPath.row];
    cell.textLabel.text = item.firstObject;
    cell.detailTextLabel.text = item.lastObject;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *item = self.dataArr[indexPath.section][indexPath.row];
    if (self.countryCodeBlock) {
        self.countryCodeBlock(item.lastObject);
        DEF_WeakSelf(self)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            DEF_StrongSelf(weakSelf)
            [strongSelf.navigationController popViewControllerAnimated:NO];
        });
    }
}

//懒加载
- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.showsVerticalScrollIndicator = NO;
        _table.delegate = self;
        _table.dataSource = self;
        _table.estimatedRowHeight = 0;
        _table.estimatedSectionHeaderHeight = 0;
        _table.estimatedSectionFooterHeight = 0;
        _table.tableFooterView = [UIView new];
        //更改索引颜色
        _table.sectionIndexBackgroundColor = [UIColor clearColor];
        _table.sectionIndexColor = DEF_APPCOLOR;
     }
    return _table;
}
@end
