//
//  FirstTableViewController.m
//  MoreTableView
//
//  Created by 刘伟强 on 2020/12/30.
//

// import分组次序：Frameworks、Services、UI
#import "FirstTableViewController.h"
#import <MJRefresh/MJRefresh.h>
#pragma mark - @class

#pragma mark - 常量

#pragma mark - 枚举

@interface FirstTableViewController ()

#pragma mark - 私有属性

@end

@implementation FirstTableViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.delegate  = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = [UIColor redColor];
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.tableView.mj_header endRefreshing];
//        });
//        NSLog(@"1");
//    }];
//    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
//        NSLog(@"1");
//    }];
//    
}


- (void)dealloc {
    NSLog(@"%@ - dealloc", NSStringFromClass([self class]));
}

#pragma mark - Events

#pragma mark - UITextFieldDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}



#pragma mark - UIOtherComponentDelegate

#pragma mark - Custom Delegates

#pragma mark - Public Methods

#pragma mark - Private Methods


// 添加子视图
- (void)createSubViews {
    
}

// 添加约束
- (void)createSubViewsConstraints {
    
}

#pragma mark - Getters and Setters

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.segmentedDelegate scrollViewDidScroll:scrollView];
}

@end
