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
#define KScreenW [UIScreen mainScreen].bounds.size.width

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
        CGFloat scaleX = KScreenW/imgW;
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
    [self setupBaseInfo];
    //4.创建答案按钮
    [self createAnswerBtns:question];
    //5.创建备选答案按钮
    [self createOptionBtns:question];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有方法
/*
 *设置基本信息
 */

-(void)setupBaseInfo:(JKQuestionInfo *)question
{
    //顶部图片索引改变
    self.topIndexLabel.text = [NSString stringWithFormat:@"%d/%zd",self.index+1, self.questions.count];
    //图片种类描述改变
    self.descLabel.text = question.title;
    //图片改变
    [self.ImageInsideBtn setImage:question forState:UIControlStateNormal];
    //下一题按钮状态改变
    self.nextBtn.enabled = (self.index != self.questions.count - 1);
    
}












@end
