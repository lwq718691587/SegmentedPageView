//
//  ViewController.m
//  MoreTableView
//
//  Created by 刘伟强 on 2020/12/28.
//

#import "ViewController.h"
#import "UIViewExt.h"
#import "LQSegmentedPageView.h"
#import "FirstTableViewController.h"
@interface ViewController ()

@property (nonatomic, strong) LQSegmentedPageView *segmentedPageView;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *sectionView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    float i = 4.f/2.f;
    NSLog(@"%f",i);
    NSLog(@"%d",(int)i);
    
    [self.view addSubview:self.segmentedPageView];
    
    // Do any additional setup after loading the view.
}





#pragma mark - UITableViewDataSource

- (LQSegmentedPageView *)segmentedPageView {
    if (!_segmentedPageView) {
        
        NSMutableArray *arr = [NSMutableArray array];
        FirstTableViewController *vc1 = [[FirstTableViewController alloc] init];
        FirstTableViewController *vc2 = [[FirstTableViewController alloc] init];
        [arr addObject:vc1];
        [arr addObject:vc2];
        
        _segmentedPageView = [[LQSegmentedPageView alloc] initWithFrame:CGRectMake(0, 40, 414, 700) headerView:self.headerView sectionView:self.sectionView titleArr:@[@"全部",@"特惠"] viewControllers:arr];
        
    }
    return _segmentedPageView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 200)];
        _headerView.backgroundColor = [UIColor yellowColor];
    }
    return _headerView;
}

- (UIView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 50)];
        _sectionView.backgroundColor = [UIColor blueColor];
    }
    return _sectionView;
}

@end
