//
//  ESCSegmentedPageViewController.m
//  MoreTableView
//
//  Created by 刘伟强 on 2020/12/30.
//

// import分组次序：Frameworks、Services、UI
#import "ESCBaseSegmentedPageView.h"
#import "BSTableView.h"
#import "ESCBaseSegmentedSingleViewController.h"
#pragma mark - @class

#pragma mark - 常量

#pragma mark - 枚举

@interface ESCBaseSegmentedPageView ()<UITableViewDelegate,UITableViewDataSource,SegmentedPageViewDelegate>

#pragma mark - 私有属性

@property (nonatomic, strong) UIScrollView *scrollView;
// 将其移动到interface中
@property (nonatomic, strong) BSTableView *tableView;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) CGFloat position;
@property (nonatomic, assign) CGFloat lastContentOffset;
@property (nonatomic, assign) BOOL subCanScroll;

@property (nonatomic, strong) NSArray *viewControllers;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *sectionView;

@end

@implementation ESCBaseSegmentedPageView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame
                   headerView:(UIView *)headerView
                  sectionView:(UIView *)sectionView
                     titleArr:(NSArray*)titleArr
              viewControllers:(NSArray *)viewControllers
{
    self = [super initWithFrame:frame];
    if (self) {
        self.canScroll = YES;
        self.headerView = headerView;
        self.sectionView = sectionView;
        self.viewControllers = viewControllers;
        [self addSubview:self.tableView];
    }
    return self;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.sectionView) {
        return self.sectionView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.sectionView) {
        return self.sectionView.frame.size.height;
    }
    return 1;
}

//设置row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

//设置cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.contentView addSubview:self.scrollView];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self cellHeight];
}

#pragma mark - Getters and Setters

- (void)setViewControllers:(NSArray *)viewControllers {
    _viewControllers = viewControllers;
    [_viewControllers enumerateObjectsUsingBlock:^(ESCBaseSegmentedSingleViewController * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.segmentedDelegate = self;
        obj.view.frame = CGRectMake(self.frame.size.width * idx, 0, self.frame.size.width, [self cellHeight]);
        [self.scrollView addSubview:obj.view];
    }];
}

- (BSTableView *)tableView {
    if (!_tableView) {
        _tableView = [[BSTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor yellowColor];
        //cell分割线的风格
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        if (self.headerView) {
            _tableView.tableHeaderView = self.headerView;
        }
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.tableView.automaticallyAdjustsScrollIndicatorInsets = NO;
        }
        
    }
    return _tableView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [self cellHeight])];
        _scrollView.contentSize = CGSizeMake(self.frame.size.width * self.viewControllers.count, [self cellHeight]);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.directionalLockEnabled = YES;
        _scrollView.backgroundColor = [UIColor grayColor];
    }
    return _scrollView;
}


- (CGFloat)cellHeight {
    if (self.sectionView) {
        return self.frame.size.height - self.sectionView.frame.size.height;
    } else {
        return self.frame.size.height;
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat bottomCellOffset = self.headerView.frame.size.height;
    
    
    if (scrollView == self.tableView) {
        if (self.canScroll) {
            CGFloat y = self.tableView.contentOffset.y;
           
            if (y < 0) {
                scrollView.contentOffset = CGPointMake(0, 0);
                self.subCanScroll = YES;
            } else if (y >= bottomCellOffset) {
                scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
                self.subCanScroll = YES;
            } else {
                self.subCanScroll = NO;
            }
            
        } else {
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
        
    } else {
        CGFloat subY = scrollView.contentOffset.y;
        if (self.subCanScroll) {
            if (subY > 0) {
                self.canScroll = NO;
            }
            if (subY < 0) {
                self.canScroll = YES;
            }
            
        } else {
            if (subY < 0) {
                
                if (self.lastContentOffset > scrollView.contentOffset.y) {
                    scrollView.contentOffset = CGPointMake(0, 0);
                } else if (self.lastContentOffset < scrollView.contentOffset.y) {
                    self.tableView.contentOffset = CGPointMake(0, 0);
                }
            } else {
                scrollView.contentOffset = CGPointMake(0, 0);
            }
        }
        self.lastContentOffset = scrollView.contentOffset.y;
    }
    
}

@end
