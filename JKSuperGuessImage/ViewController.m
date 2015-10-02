//
//  ViewController.m
//  JKSuperGuessImage
//
//  Created by 弥超 on 15/10/1.
//  Copyright © 2015年 弥超. All rights reserved.
//

#import "ViewController.h"
#import "JKQuestionInfo.h"

CGFloat const imgW = 150;
//#define KScreenW =

@interface ViewController ()
/*
 *顶部索引
 */
@property (weak, nonatomic) IBOutlet UILabel *topIndexLabel;
/*
 *图片类型描述
 */
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
/*
 *得分
 */
@property (weak, nonatomic) IBOutlet UIButton *coinBtn;
/*
 *显示中间图片的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *ImageInsideBtn;
/*
 *下一题按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
/*
 *显示答案按钮的视图
 */
@property (weak, nonatomic) IBOutlet UIView *answerView;
/*
 *显示备选答案按钮的视图
 */
@property (weak, nonatomic) IBOutlet UIView *optionsView;

/*
 *模型数组
 */
@property (nonatomic, weak) NSArray *questions;

/*
 *记录索引
 */
@property (nonatomic,assign) int index;
/*
 *遮盖按钮
 */

@property (nonatomic,strong) UIButton *cover;
@end

@implementation ViewController

/*
 *懒加载
 *@return 模型数组
 */

-(NSArray *)questions
{
    if (nil==_questions) {
        _questions = [JKQuestionInfo questions];
    }
    return _questions;
}

/*
 *懒加载
 *@return 遮盖
 */

-(UIButton *) cover
{
    if (nil == _cover) {
        _cover = [[UIButton alloc]init];
        _cover.frame = self.view.bounds;
        _cover.alpha = 0.0;
        _cover.backgroundColor = [UIColor blackColor];
        [_cover addTarget:self action:@selector(imageBtnChangeOnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_cover];
        
    }
    return _cover;
}




/*
 *提示按钮的点击时间
 */
- (IBAction)TipBtnOnclick:(id)sender {
}

/*
 *帮助按钮的点击事件
 */
- (IBAction)helpBtnOnclick {
}

/*
 *大图/遮盖/中间 3个按钮的点击事件
 */
- (IBAction)imageBtnChangeOnClick {
}
/*
 *下一题点击事件
 */
- (IBAction)nextBtnOnClick {
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
