//
//  InfoTableViewController.m
//  点钞机
//
//  Created by Klar on 15/4/10.
//  Copyright (c) 2015年 WHU. All rights reserved.
//

#import "InfoTableViewController.h"
#import "NALLabelsMatrix.h"
#import "IonIcons.h"
#import "SearchViewController.h"

@interface InfoTableViewController()<UIScrollViewDelegate>{
    NALLabelsMatrix* matrix;
    UIScrollView* scrollView;
    UIButton* amountBtn;
    UIButton* versionBtn;
    UIView* amountView;
    UIView* versionView;
}
@end
@implementation InfoTableViewController
-(void)viewDidLoad{
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[IonIcons imageWithIcon:icon_ios7_search size:30.0f color:[UIColor whiteColor]] style:UIBarButtonItemStylePlain target:self action:@selector(searchClicked)];
    self.navigationItem.title=@"冠字号列表";
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.delegate = self;
    scrollView.clipsToBounds = YES;
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, 40);
    
    amountBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    amountBtn.frame=CGRectMake( self.view.frame.size.width*0.4,0, self.view.frame.size.width*0.2, 40);
    amountBtn.backgroundColor = [UIColor clearColor];
    [amountBtn addTarget:self action:@selector(amountBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    amountView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.4-1, 0, self.view.frame.size.width*0.2,280)];
    amountView.backgroundColor = [UIColor whiteColor];
    amountView.layer.borderWidth=0.5;
    amountView.layer.borderColor=[UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:1].CGColor;
    [[amountView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[amountView layer] setShadowRadius:1];
    [[amountView layer] setShadowOpacity:0.1];
    [[amountView layer] setShadowColor:[UIColor blackColor].CGColor];
    amountView.hidden = YES;
    NSString* amountBtnTitle[7] = {@"面额 ▾",@"全部",@"100",@"50",@"20",@"10",@"5"};
    for(int i = 0;i<7;i++){
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 40*i, amountView.frame.size.width, 40);
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];;
        [btn setTitle:amountBtnTitle[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(amountViewBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i!=0) {
            [btn addTarget:self action:@selector(changeBtnColor:) forControlEvents:UIControlEventTouchDown];
        }
        btn.tag = i;
        [amountView addSubview:btn];
    }
    
    
    versionView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.6-1, 0, self.view.frame.size.width*0.2,160)];
    versionView.backgroundColor = [UIColor whiteColor];
    versionView.layer.borderWidth=0.5;
    versionView.layer.borderColor=[UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:1].CGColor;
    [[versionView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[versionView layer] setShadowRadius:1];
    [[versionView layer] setShadowOpacity:0.1];
    [[versionView layer] setShadowColor:[UIColor blackColor].CGColor];
    versionView.hidden = YES;
    NSString* versionBtnTitle[4] = {@"版本号 ▾",@"全部",@"2005",@"1999"};
    for(int i = 0;i<4;i++){
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 40*i, versionView.frame.size.width, 40);
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];;
        [btn setTitle:versionBtnTitle[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(versionViewBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i!=0) {
            [btn addTarget:self action:@selector(changeBtnColor:) forControlEvents:UIControlEventTouchDown];
        }
        btn.tag = i+7;
        [versionView addSubview:btn];
    }
    
    versionBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    versionBtn.frame=CGRectMake( self.view.frame.size.width*0.6,0, self.view.frame.size.width*0.2, 40);
    versionBtn.backgroundColor = [UIColor clearColor];
    [versionBtn addTarget:self action:@selector(versionBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    matrix = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.height-60,self.view.frame.size.width) andColumnsWidths:[[NSArray alloc] initWithObjects:@(self.view.frame.size.width*0.1),@(self.view.frame.size.width*0.3),@(self.view.frame.size.width*0.2),@(self.view.frame.size.width*0.2),@(self.view.frame.size.width*0.2),nil]];
    
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"序号", @"冠字号", @"面额 ▾",@"版本号 ▾",@"错误代码", nil]];
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"1", @"A4B5D6874", @"100",@"2005",@"磁性图像", nil]];
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, scrollView.contentSize.height+40);
    
    [scrollView addSubview:matrix];
    [scrollView addSubview:amountBtn];
    [scrollView addSubview:versionBtn];
    [scrollView addSubview:amountView];
    [scrollView addSubview:versionView];
    [self.view addSubview:scrollView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissMenu)];
    
    [self.view addGestureRecognizer:tap];
}
-(void)dismissMenu{
    amountView.hidden=YES;
    versionView.hidden=YES;
}
-(void)changeBtnColor:(UIButton*)btn{
    for(UIView* view in btn.superview.subviews){
        view.backgroundColor = [UIColor whiteColor];
    }
    btn.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:157.0/255.0 blue:252.0/255.0 alpha:1.0];
}
-(void)versionViewBtnClicked:(UIButton*)btn{
    switch (btn.tag) {
        case 7:
            NSLog(@"7");
            break;
        case 8:
            NSLog(@"8");
            break;
        case 9:
            NSLog(@"9");
            break;
        case 10:
            NSLog(@"10");
            break;
        default:
            break;
    }
    versionView.hidden =YES;
}
-(void)amountViewBtnClicked:(UIButton*)btn{
    switch (btn.tag) {
        case 0:
            NSLog(@"0");
            break;
        case 1:
            NSLog(@"1");
            break;
        case 2:
            NSLog(@"2");
            break;
        case 3:
            NSLog(@"3");
            break;
        case 4:
            NSLog(@"4");
            break;
        case 5:
            NSLog(@"5");
            break;
        case 6:
            NSLog(@"6");
            break;
        default:
            break;
    }
    amountView.hidden =YES;
}
-(void)amountBtnClicked{
    //    [matrix reset];
    versionView.hidden =YES;
    amountView.hidden = NO;
    NSLog(@"clcl");
}
-(void)versionBtnClicked{
    amountView.hidden =YES;
    versionView.hidden =NO;
    NSLog(@"veve");
}
-(void)searchClicked{
    [self performSegueWithIdentifier:@"search" sender:nil];
}
@end
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"search"]) {
//        SearchViewController *lvc = segue.destinationViewController;
//        [lvc setHidesBottomBarWhenPushed:YES];
//        lvc.navigationItem.hidesBackButton = YES;
//    }
//}
//@(self.view.frame.size.width*0.1),@(self.view.frame.size.width*0.3),@(self.view.frame.size.width*0.2),@(self.view.frame.size.width*0.2),@(self.view.frame.size.width*0.2