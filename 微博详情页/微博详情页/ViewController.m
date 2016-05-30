//
//  ViewController.m
//  微博详情页
//
//  Created by 码农界四爷__King on 16/5/30.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//


//顶部图片在修改面板中设置了裁剪和Aspect Fill
#import "ViewController.h"
#import "UIImage+Image.h"
static NSString *const ID = @"cell";
static CGFloat const SYHeaderViewH = 180;
static CGFloat const SYTabBarH = 44;
static CGFloat const SYHeaderMinViewH = 64;
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//记录开始的偏移量
@property (nonatomic,assign) CGFloat startOffsetY;
//图片顶部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topContain;
@property (nonatomic,strong) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设代理和数据源
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //设置导航栏背景透明
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    //设置导航栏文字
    UILabel *label = [[UILabel alloc]init];
    label.text = @"码农界四爷";
    [label setTextColor:[UIColor colorWithWhite:1 alpha:0]];
    [label sizeToFit];
    _label = label;
    [self.navigationItem setTitleView:label];
    //设置默认偏移量
   _startOffsetY = - (SYHeaderViewH + SYTabBarH);
    //修改导航栏的默认尺寸
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //修改tableView顶部间距
    self.tableView.contentInset = UIEdgeInsetsMake(SYHeaderViewH + SYTabBarH, 0, 0, 0);
    NSLog(@"%f",_startOffsetY);
    

}

#pragma mark - UITableViewDelegate

//滚动时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //记录当前Y值
    CGFloat curOffsetY = scrollView.contentOffset.y;
    // 计算偏移量的差值 == tableView滚动了多少
    // 获取当前滚动偏移量 - 最开始的偏移量(-244)
    CGFloat delta  = curOffsetY - _startOffsetY;
     // 计算下头部视图的高度
    CGFloat h = SYHeaderViewH - delta;
 
    if (h < SYHeaderMinViewH) {
        h = SYHeaderMinViewH;
    }
    
    // 修改头部视图高度,有视觉差效果
    _topContain.constant = h;
    
    //根据距离计算透明度
    CGFloat alpha = delta / (SYHeaderViewH - SYHeaderMinViewH);
    
    if (alpha > 1) {
        alpha = 0.99;
    }
    //设置导航条背景图片
    //根据当前的alpha值生成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //设置导航栏标题颜色
    _label.textColor = [UIColor colorWithWhite:0 alpha:alpha];
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID
                ];
        cell.backgroundColor = [UIColor redColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}
@end
