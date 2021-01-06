//
//  LQSegmentedCategoryView.m
//  MoreTableView
//
//  Created by 刘伟强 on 2021/1/6.
//

#import "LQSegmentedCategoryView.h"
#import "LQSectionTitleCollectionViewCell.h"
#import "UIViewExt.h"
@interface LQSegmentedCategoryView()<UICollectionViewDelegate,UICollectionViewDataSource>

// 将其移动到interface中
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIImageView *lineView;

@end


@implementation LQSegmentedCategoryView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemSpacing = 20;
        self.currentIndex = 0;
        [self addSubview:self.collectionView];
        [self.collectionView addSubview:self.lineView];
        
        
    }
    return self;
}

-(void)setTitleArr:(NSArray *)titleArr {
    _titleArr = titleArr;
    [self.collectionView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.lineView.centerX = [self getCell:0].centerX;
    });
    
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [self getWidthWithContent:self.titleArr[indexPath.item]];
    CGFloat height = self.height;
    return CGSizeMake(self.itemWidth > 0 ? self.itemWidth : width, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.itemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.itemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, self.leftMargin, 0, self.rightMargin);
}

#pragma mark - UICollectionView DataSource and Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LQSectionTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.title = self.titleArr[indexPath.row];
    cell.font = self.titleFont;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.currentIndex = indexPath.row;
    [self scrollToIndex:indexPath.row];
    if (self.selectedIndex) {
        self.selectedIndex(indexPath.row);
    }
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

static NSString *const identify = @"LQSectionTitleCollectionViewCell";
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[LQSectionTitleCollectionViewCell class] forCellWithReuseIdentifier:identify];
    }
    return _collectionView;
}


- (UIImageView *)lineView {
    if (!_lineView) {
        _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 4, 20, 4)];
        _lineView.backgroundColor = [UIColor grayColor];
        
    }
    return _lineView;
}

- (void)scrollLineView:(CGFloat)position startIndex:(NSInteger)startIndex {
    
    self.lineView.centerX = [self getCell:0].centerX + position;
}

- (void)scrollToIndex:(NSInteger)index {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (UICollectionViewCell *)getCell:(NSUInteger)index {
    return (UICollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
}

- (CGFloat)getWidthBetweenStartIndex:(NSInteger )startIndex
                            endIndex:(NSInteger)endIndex {
    UICollectionViewCell *startCell = [self getCell:startIndex];
    UICollectionViewCell *endCell = [self getCell:endIndex];
    return endCell.centerX - startCell.centerX;
    
}

- (UIFont *)selectedTitleFont {
    if (_selectedTitleFont) {
        return  _selectedTitleFont;
    } else {
        return self.titleFont;
    }
}


- (CGFloat)getWidthWithContent:(NSString *)content {
    CGRect rect = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, self.height)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:@{NSFontAttributeName:self.selectedTitleFont}
                                        context:nil];
    return ceilf(rect.size.width);
}

@end
