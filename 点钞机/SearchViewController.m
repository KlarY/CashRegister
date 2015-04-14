//
//  SearchViewController.m
//  点钞机
//
//  Created by Klar on 15/4/10.
//  Copyright (c) 2015年 WHU. All rights reserved.
//

#import "SearchViewController.h"
#import "NALLabelsMatrix.h"
@interface SearchViewController()<UIScrollViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>{
    NALLabelsMatrix* matrix;
    UIScrollView* scrollView;
    UISearchBar *searchBar;
}
@end

@implementation SearchViewController

-(void)viewDidLoad{
    searchBar = [UISearchBar new];
    searchBar.showsCancelButton = YES;
    searchBar.delegate=self;
    [searchBar sizeToFit];
    searchBar.placeholder=@"请输入冠字号/面额/版本号等";
    self.navigationItem.titleView = searchBar;
    self.navigationItem.hidesBackButton=YES;
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60,self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.delegate = self;
    scrollView.clipsToBounds = YES;
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, 40);
    
    matrix = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.height-60,self.view.frame.size.width) andColumnsWidths:[[NSArray alloc] initWithObjects:@(self.view.frame.size.width*0.1),@(self.view.frame.size.width*0.3),@(self.view.frame.size.width*0.2),@(self.view.frame.size.width*0.2),@(self.view.frame.size.width*0.2),nil]];
    [scrollView addSubview:matrix];
    
    [self.view addSubview:scrollView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [self enableCancelButton];
}
- (void) dismissKeyboard
{
    [searchBar resignFirstResponder];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)_searchBar{
    [self enableCancelButton];
}
-(void)enableCancelButton{
    for (UIView *subview1 in searchBar.subviews)
    {
        for (UIView *subview2 in subview1.subviews){
            if ([subview2 isKindOfClass:[UIButton class]])
            {
                int64_t delayInSeconds = .001;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    UIButton * cancelButton = (UIButton *)subview2;
                    [cancelButton setEnabled:YES];
                });
                break;
            }
        }
    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)_searchBar{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)_searchBar{
    [_searchBar resignFirstResponder];
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"序号", @"冠字号", @"面额",@"版本号",@"错误代码", nil]];
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
    NSLog(searchBar.text);
}

@end
