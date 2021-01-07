//
//  LQSectionTitleCollectionViewCell.m
//  MoreTableView
//
//  Created by 刘伟强 on 2021/1/5.
//

#import "LQSectionTitleCollectionViewCell.h"

@interface LQSectionTitleCollectionViewCell()

@property (nonatomic, strong) UILabel *cusTitleLabel;

@end

@implementation LQSectionTitleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.cusTitleLabel];
    }
    return self;
}


- (UILabel *)cusTitleLabel {
    if (!_cusTitleLabel) {
        _cusTitleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _cusTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _cusTitleLabel;
}

- (void)setNormalFont:(UIFont *)normalFont {
    _normalFont = normalFont;
    self.cusTitleLabel.font = _normalFont;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.cusTitleLabel.text = _title;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.cusTitleLabel.font = self.selectedFont;
        self.cusTitleLabel.textColor = self.selectedtTextColor;
    } else {
        self.cusTitleLabel.font = self.normalFont;
        self.cusTitleLabel.textColor = self.normalTextColor;
    }
}


@end
