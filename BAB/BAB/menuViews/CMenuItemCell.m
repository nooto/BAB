//
//  CMenuItemCell.m
//  BAB
//
//  Created by GaoAng on 2020/1/31.
//  Copyright © 2020 selfcom. All rights reserved.
//

#import "CMenuItemCell.h"
#import "CThemeManager.h"

@interface CMenuItemCell()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *label;
@end

@implementation CMenuItemCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.label];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(23);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(23);
            make.centerY.equalTo(self.iconView.mas_centerY);
            make.height.mas_equalTo(30);
        }];
    }
    
    return self;
}

- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    [self.label setText:dict[@""]];
    [self.label setText:dict[@"itemName"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (UILabel*)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(MarginW(20), MarginH(10), SCREEN_W- MarginW(20)*4, 25)];
        [_label setFont:Font13];
        [_label setTextColor:[ThemeManager mainTextColor]];
        [_label setTextColor:[UIColor blackColor]];
    }
    return _label;
}

-(UIImageView*)iconView{
    if ((!_iconView)) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

@end
