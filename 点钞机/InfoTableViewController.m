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
    [amountBtn addTarget:self action:@selector(AmountBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    versionBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    versionBtn.frame=CGRectMake( self.view.frame.size.width*0.6,0, self.view.frame.size.width*0.2, 40);
    versionBtn.backgroundColor = [UIColor clearColor];
    [versionBtn addTarget:self action:@selector(VersionBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
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
    [self.view addSubview:scrollView];
}
-(void)AmountBtnClicked{
    [matrix removeFromSuperview];
    NSLog(@"clcl");
}
-(void)VersionBtnClicked{
    [scrollView addSubview:matrix];
    [scrollView sendSubviewToBack:matrix];
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