//
//  ButtonsView.m
//  WanBangTravel
//
//  Created by 沈凡 on 16/4/15.
//  Copyright © 2016年 mmt&sf. All rights reserved.
//

#import "ButtonsView.h"

#define VIEW_WIDTH self.frame.size.width
#define VIEW_HEIGHT self.frame.size.height



//#define ROWS_COUNT (int)VIEW_HEIGHT / (int)ATOMVIEW_HEIGHT
//#define COLUMNS_COUNT (int)VIEW_WIDTH / (int)ATOMVIEW_WIDTH


@interface ButtonsView (){
    CGFloat _margin;
}

@end

@implementation ButtonsView

- (instancetype)initWithFrame:(CGRect)frame andRows:(int)row andColumns:(int)col{
    if (self = [super initWithFrame:frame]) {
        int width = VIEW_WIDTH;
        int atomViewWidth = ATOMVIEW_WIDTH;
        self.columnsCount = col;
        self.rowsCount = row;
        self.imgNameList = @[@"门票",@"自由行",@"大巴租赁",@"酒店客栈",@"户外探险",@"跟团游",@"户外探险",@"酒店客栈"];
        self.btnBackgroundColor = @[[UIColor redColor],[UIColor blueColor],[UIColor greenColor],[UIColor grayColor],[UIColor orangeColor],[UIColor purpleColor],[UIColor redColor],[UIColor blueColor]];
//        self.layer.borderWidth = 1;
//        self.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor grayColor]);
        _margin = (float)(width - (col * atomViewWidth)) / (col + 1);
        [self generateButtonItems];
    }
    return self;
}

//视图大小不变 变动间距的做法
- (void)generateButtonItems{
    int count  = 0;
    for (int i = 0; i < self.rowsCount; i++) {
        for (int j = 0; j< self.columnsCount; j++) {
            CGFloat x = (j + 1) * _margin + j * ATOMVIEW_WIDTH;
            CGFloat y = (i + 1) * _margin * HEIGHT_WIDTH_MARGINSCALE + i * ATOMVIEW_HEIGHT;
            [self addSubview:[self createAtomViewWithFrame:CGRectMake(x, y, ATOMVIEW_WIDTH, ATOMVIEW_HEIGHT) andTitle:self.imgNameList[count] andBackgroundColor:self.btnBackgroundColor[count] withBackgroudImgName:self.imgNameList[count]]];
            count ++;
        }
    }
}

//视图间距不变 通过改变视图大小适应屏幕
//- (void)generateButtonItemsWithSolidMargin{
//
//}

- (UIView *)createAtomViewWithFrame:(CGRect)frame andTitle:(NSString *)title andBackgroundColor:(UIColor *)color withBackgroudImgName:(NSString *)imgName {
    //创建原子视图来包括按钮和文字
    UIView *atomButtonView = [[UIView alloc] initWithFrame:frame];
    //创建按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ATOMVIEW_WIDTH, ATOMVIEW_WIDTH)];
    btn.layer.cornerRadius = ATOMVIEW_WIDTH / 2;
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setBackgroundColor:color];
    [atomButtonView addSubview:btn];
    //文字
    UILabel *btnText = [[UILabel alloc] initWithFrame:CGRectMake(0, ATOMVIEW_WIDTH, ATOMVIEW_WIDTH, ATOMVIEW_HEIGHT-ATOMVIEW_WIDTH)];
    [btnText setText:title];
    [btnText setTextAlignment:NSTextAlignmentCenter];
    [btnText setTextColor:[UIColor grayColor]];
    [btnText setFont:[UIFont systemFontOfSize:12]];
    [atomButtonView addSubview:btnText];
    return atomButtonView;
}
@end
