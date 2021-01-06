//
//  ESCSegmentedPageViewController.m
//  MoreTableView
//
//  Created by 刘伟强 on 2020/12/30.
//

// import分组次序：Frameworks、Services、UI
#import "LQSegmentedPageView.h"
#import "LQSegmentedTableView.h"
#import "UIViewController+LQSegmented.h"
#import "LQSegmentedCategoryView.h"
#pragma mark - @class

#pragma mark - 常量

#pragma mark - 枚举

@interface LQSegmentedPageView ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

#pragma mark - 私有属性

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) LQSegmentedTableView *tableView;
@property (nonatomic, strong) LQSegmentedCategoryView *segmentedCategoryView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) BOOL subCanScroll;
@property (nonatomic, assign) CGFloat lastContentOffsetY;
@property (nonatomic, assign) CGFloat lastContentOffsetX;
@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) NSMutableArray *scrollviewsArr;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation LQSegmentedPageView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame
                   headerView:(UIView *)headerView
                     titleArr:(NSArray*)titleArr
              viewControllers:(NSArray *)viewControllers
{
    self = [super initWithFrame:frame];
    if (self) {
        self.currentIndex = 0;
        self.scrollviewsArr = [NSMutableArray array];
        self.titleArr = titleArr;
        self.canScroll = YES;
        self.headerView = headerView;
        self.viewControllers = viewControllers;
        [self addSubview:self.tableView];
     
    }
    return self;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.segmentedCategoryView) {
        return self.segmentedCategoryView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.segmentedCategoryView) {
        return self.segmentedCategoryView.frame.size.height;
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
    [_viewControllers enumerateObjectsUsingBlock:^(UIViewController * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __weak typeof(self) weakSelf = self;
        obj.segmentedBlock = ^(UIScrollView * _Nonnull scrollview) {
            if (![self.scrollviewsArr containsObject:scrollview]) {
                [self.scrollviewsArr addObject:scrollview];
            }
            [weakSelf scrollViewDidScroll:scrollview];
        };
        obj.view.frame = CGRectMake(self.frame.size.width * idx, 0, self.frame.size.width, [self cellHeight]);
        [self.scrollView addSubview:obj.view];
    }];
}

- (LQSegmentedTableView *)tableView {
    if (!_tableView) {
        _tableView = [[LQSegmentedTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
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
        _scrollView.delegate = self;
//        [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return _scrollView;
}


- (CGFloat)cellHeight {
    if (self.segmentedCategoryView) {
        return self.frame.size.height - self.segmentedCategoryView.frame.size.height;
    } else {
        return self.frame.size.height;
    }
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGFloat value = [change[@"new"] CGPointValue].x - [change[@"old"] CGPointValue].x;
        CGFloat betweenWidth = [self.segmentedCategoryView getWidthBetweenStartIndex:self.currentIndex endIndex:self.currentIndex + 1];
//        [self.segmentedCategoryView scrollLineView:value * betweenWidth/self.frame.size.width];
    }
}



- (LQSegmentedCategoryView *)segmentedCategoryView {
    if (!_segmentedCategoryView) {
        _segmentedCategoryView = [[LQSegmentedCategoryView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        _segmentedCategoryView.backgroundColor = [UIColor blueColor];
        _segmentedCategoryView.titleArr = self.titleArr;
        _segmentedCategoryView.titleFont = [UIFont systemFontOfSize:14];
        _segmentedCategoryView.selectedTitleFont = [UIFont systemFontOfSize:14];
//        _segmentedCategoryView.itemWidth = self.frame.size.width/self.titleArr.count;
        _segmentedCategoryView.itemSpacing = 0;
        __weak typeof(self) weakSelf = self;
        _segmentedCategoryView.selectedIndex = ^(NSInteger index) {
            [weakSelf.scrollView setContentOffset:CGPointMake(self.frame.size.width * index, 0) animated:YES];
        };
    }
    return _segmentedCategoryView;
}

- (NSInteger)currentIndex {
    return self.scrollView.contentOffset.x/self.frame.size.width;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == self.scrollView) {
        [self.segmentedCategoryView scrollToIndex:self.currentIndex];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != self.scrollView) {
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
                    
                    if (self.lastContentOffsetY > scrollView.contentOffset.y) {
                        scrollView.contentOffset = CGPointMake(0, 0);
                    } else if (self.lastContentOffsetY < scrollView.contentOffset.y) {
                        self.tableView.contentOffset = CGPointMake(0, 0);
                    }
                } else {
                    [self.scrollviewsArr enumerateObjectsUsingBlock:^(UIScrollView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        obj.contentOffset = CGPointMake(0, 0);
                    }];
                }
            }
            self.lastContentOffsetY = scrollView.contentOffset.y;
        }
    } else {
        CGFloat betweenWidth = [self.segmentedCategoryView getWidthBetweenStartIndex:self.currentIndex endIndex:self.currentIndex + 1];
//        CGFloat value = scrollView.contentOffset.x - self.lastContentOffsetX;
        CGFloat value = scrollView.contentOffset.x * betweenWidth/self.frame.size.width;
        [self.segmentedCategoryView scrollLineView:value startIndex:self.currentIndex];
        self.lastContentOffsetX = scrollView.contentOffset.x;
    }
}


@end
