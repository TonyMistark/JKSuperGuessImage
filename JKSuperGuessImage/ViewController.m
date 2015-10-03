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
#define ingW self.ImageInsideBtn.bounds.size.width
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kAnswerBtnTitleColor [UIColor blackColor]
/*
 *常量
 */
CGFloat const kBtnW = 35;
CGFloat const kBtnH = 35;
CGFloat const kMarginBtweenBtns = 10;
NSInteger const kOptionViewTotal = 7;

NSInteger const kTrueAddScore = 200;
NSInteger const kFalseDecreaseScore = -200;
NSInteger const kTipDecreaseScore = -200;


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
#warning noCode
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
    if (0==self.cover.alpha){
        //图片放大
        CGFloat scaleX = kScreenW/imgW;
        CGFloat scaleY = scaleX;
        
        CGFloat translateY = self.ImageInsideBtn.frame.origin.y/scaleX;
        
        [UIView animateWithDuration:1.0 animations:^{self.ImageInsideBtn.transform = CGAffineTransformMakeScale(scaleX, scaleY);
            self.ImageInsideBtn.transform = CGAffineTransformTranslate(self.ImageInsideBtn.transform, 0, translateY);
            //遮盖显现
            self.cover.alpha = 0.5;
        }];
    }else
    {
        //图片还原
        [UIView animateWithDuration:1.0 animations:^{
            self.ImageInsideBtn.transform = CGAffineTransformIdentity;
            self.cover.alpha = 0.0;
            
        }];
                                   }
}
/*
 *下一题点击事件
 */
- (IBAction)nextBtnOnClick {
    //1.索引自增，并判断是否越界
    self.index ++;
    if (self.index >= self.questions.count) {
        
        NSLog(@"恭喜通关");
#warning NoCode
        self.index--;
    }
    //2.取出模型
    JKQuestionInfo *question = self.questions[self.index];
    //3.设计基本信息（参考图片浏览器）
    [self setupBaseInfo:question];
    //4.创建答案按钮
    [self createAnswerBtns:question];
    //5.创建备选答案按钮
    [self createOptionBtns:question];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.index = -1;
    [self nextBtnOnClick];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有方法
/*
 *3.设置基本信息
 */

-(void)setupBaseInfo:(JKQuestionInfo *)question
{
    //顶部图片索引改变
    self.topIndexLabel.text = [NSString stringWithFormat:@"%d/%zd",self.index+1, self.questions.count];
    //图片种类描述改变
    self.descLabel.text = question.title;
    //图片改变
    [self.ImageInsideBtn setImage:question.image forState:UIControlStateNormal];
    //下一题按钮状态改变
    self.nextBtn.enabled = (self.index != self.questions.count - 1);
    
}

/*
 *4.创建答案按钮
 */
-(void)createAnswerBtns:(JKQuestionInfo *)question
{
    //清空answerView
    for (UIButton *btn in self.answerView.subviews) {
        [btn removeFromSuperview];
    }
    //获取答案按钮的个数
    NSInteger answerBtnCount = question.answer.length;
    CGFloat answerW = self.answerView.bounds.size.width;
    CGFloat answerEdgeInset = (answerW - answerBtnCount*kBtnW - (answerBtnCount-1)*kMarginBtweenBtns)*0.5;
    for(int i=0;i<answerBtnCount;i++){
        UIButton *btn = [[UIButton alloc]init];
        CGFloat btnX = answerEdgeInset+i*(kBtnW+kMarginBtweenBtns);
        btn.frame = CGRectMake(btnX, 0, kBtnW, kBtnH);
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        [btn setTitleColor:kAnswerBtnTitleColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(answerBtnOnClick:) forControlEvents:UIControlEventTouchUpOutside];
        [self.answerView addSubview:btn];
    }
}

/*
 *5.创建备选答案按钮
 */
-(void)createOptionBtns:(JKQuestionInfo *)question
{
    int optionCount = question.options.count;
    if (self.answerView.subviews.count != optionCount) {
        //若没有按钮就创建按钮
        CGFloat optionW = self.optionsView.bounds.size.width;
        CGFloat optionEdgeInset = (optionW - kOptionViewTotal*kBtnW - (kOptionViewTotal-1)*kMarginBtweenBtns)*0.5;
        for (int i=0; i<optionCount; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            int col = i%kOptionViewTotal;
            int row = i/kOptionViewTotal;
            CGFloat btnX = optionEdgeInset + (kBtnW + kMarginBtweenBtns)*col;
            CGFloat btnY = kMarginBtweenBtns + (kBtnW +kMarginBtweenBtns)*row;
            btn.frame = CGRectMake(btnX, btnY, kBtnW, kBtnH);
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
            [btn setTitleColor:kAnswerBtnTitleColor forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(optionBtnOnClick:) forControlEvents:UIControlEventTouchUpOutside];
            [self.optionsView addSubview:btn];
            
        }
        
    }
    for (int i=0; i<optionCount; i++) {
        UIButton *optionBtn = self.optionsView.subviews[i];
        [optionBtn setTitle:question.options[i] forState:UIControlStateNormal];
        optionBtn.hidden = NO;
    }
}

#pragma 下面按钮的点击方法
/*
 *答案按钮点击方法
 */
-(void)answerBtnOnClick:(UIButton *)answerBtn
{   NSString *anserStr = answerBtn.currentTitle;
    //若按钮为空，直接返回
    if (nil == answerBtn.currentTitle) {
        return;
    }
    //若不为空
    //1.去掉按钮内容
    [answerBtn setTitle:nil forState:UIControlStateNormal];
    //2.恢复optionView 中隐藏的按钮
    for (UIButton *optionBtn in self.optionsView.subviews) {
        if ([anserStr isEqualToString:optionBtn.currentTitle] && optionBtn.isHidden) {
            optionBtn.hidden = NO;
            break;
        }
    }
    
    //3.若字体颜色不对，则统统恢复黑色
    if (answerBtn.currentTitleColor != kAnswerBtnTitleColor) {
        for (UIButton *answerBtn in self.answerView.subviews) {
            [answerBtn setTitleColor:kAnswerBtnTitleColor forState:UIControlStateNormal];
        }
        
        //恢复optionView的用户交互
        self.optionsView.userInteractionEnabled = YES;
    }
}

/*
 *备选答案按钮点击方法
 */
-(void)optionBtnOnClick:(UIButton *)optionBtn
{
#warning codeMe
}






@end
