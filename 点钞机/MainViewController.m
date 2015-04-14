//
//  MainViewController.m
//  点钞机
//
//  Created by Klar on 15/4/9.
//  Copyright (c) 2015年 WHU. All rights reserved.
//

#import "MainViewController.h"
#import "JSDropDownMenu.h"
#import "BlueToothController.h"

@interface MainViewController ()<JSDropDownMenuDataSource,JSDropDownMenuDelegate,BlueToothControllerDelegate>{
    
    NSMutableArray *_data1;
    NSMutableArray *_data2;
    NSMutableArray *_data3;
    
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
    
    BlueToothController* blueToothController;
    
    UILabel* smLabel;
    UILabel* bgLabel;
    UILabel* midLabel;
}


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    blueToothController = [BlueToothController sharedManager];
    blueToothController.delegate = self;
    self.view.backgroundColor=[UIColor colorWithRed:(26.0/255.0) green:(155.0/255.0) blue:(252.0/255.0) alpha:1.0];
    _data1 = [NSMutableArray arrayWithObjects:@"智能", @"分版", @"合计", @"计数", nil];
    _data2 = [NSMutableArray arrayWithObjects:@"单次", @"预置", @"累加", nil];
    _data3 = [NSMutableArray arrayWithObjects:@"人民币", nil];
    
    JSDropDownMenu *menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 63) andHeight:(self.view.frame.size.height-63)*0.08];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
    
    
    
    _statusView.frame = CGRectMake(0, (self.view.frame.size.height-63)*0.62+63, self.view.frame.size.width, (self.view.frame.size.height-63)*0.08);
    _statusView.backgroundColor=[UIColor colorWithRed:(59.0/255.0) green:(174.0/255.0) blue:(252.0/255.0) alpha:1.0];
    smLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height-63)*0.08)];
    smLabel.textAlignment = NSTextAlignmentCenter;
    smLabel.textColor = [UIColor whiteColor];
    smLabel.text = @"合计：298张    29800元";
    [_statusView addSubview:smLabel];
    [self.view addSubview:_statusView];
    
    
    
    _bgStatusView.frame=CGRectMake(0, (self.view.frame.size.height-63)*0.08+63, self.view.frame.size.width, (self.view.frame.size.height-63)*0.54);
    _bgStatusView.backgroundColor = [UIColor clearColor];
    UIImageView* imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_icon"]];
    imgView.backgroundColor = [UIColor clearColor];
    
    float y = MIN(_bgStatusView.frame.size.height, _bgStatusView.frame.size.width)*0.8;
    float x = 1.14*y;
    imgView.frame = CGRectMake((self.view.frame.size.width-x)/2, ((self.view.frame.size.height-63)*0.54-y)/2, x, y);
    
    
    UILabel* unitLabelA = [[UILabel alloc] initWithFrame:CGRectMake(imgView.frame.size.width*0.8, imgView.frame.size.height*0.5, imgView.frame.size.width*0.1, imgView.frame.size.height*0.1)];
    unitLabelA.textAlignment = NSTextAlignmentCenter;
    unitLabelA.textColor = [UIColor whiteColor];
    unitLabelA.text = @"元";
    [imgView addSubview:unitLabelA];
    
    UILabel* unitLabelB = [[UILabel alloc] initWithFrame:CGRectMake(imgView.frame.size.width*0.7, imgView.frame.size.height*0.8, imgView.frame.size.width*0.1, imgView.frame.size.height*0.1)];
    unitLabelB.textAlignment = NSTextAlignmentCenter;
    unitLabelB.textColor = [UIColor whiteColor];
    unitLabelB.text = @"张";
    [imgView addSubview:unitLabelB];
    
    bgLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgView.frame.size.width*0.1, imgView.frame.size.height*0.3, imgView.frame.size.width*0.7, imgView.frame.size.height*0.4)];
    NSLog(@"%f",imgView.frame.size.width);
    bgLabel.font = [UIFont systemFontOfSize: imgView.frame.size.width/4];
    bgLabel.textAlignment = NSTextAlignmentCenter;
    bgLabel.textColor = [UIColor whiteColor];
    bgLabel.text = @"28900";
    [imgView addSubview:bgLabel];
    
    midLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgView.frame.size.width*0.4, imgView.frame.size.height*0.7, imgView.frame.size.width*0.3, imgView.frame.size.height*0.25)];
    midLabel.font = [UIFont systemFontOfSize: imgView.frame.size.width/6];
    midLabel.textAlignment = NSTextAlignmentCenter;
    midLabel.textColor = [UIColor whiteColor];
    midLabel.text = @"289";
    [imgView addSubview:midLabel];
    [_bgStatusView addSubview:imgView];
    
    [self.view addSubview:_bgStatusView];
    
    
    
    _numBtn.frame=CGRectMake(0, (self.view.frame.size.height-63)*0.7+63, self.view.frame.size.width/2, (self.view.frame.size.height-63)*0.15);
    _numBtn.backgroundColor=[UIColor whiteColor];
    _numBtn.layer.borderWidth=0.5;
    _numBtn.layer.borderColor=[UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:1].CGColor;
    [_numBtn setTitle: @"冠字号" forState: UIControlStateNormal];
    [_numBtn setImage: [UIImage imageNamed:@"ico_make"] forState:UIControlStateNormal];
    _numBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [_numBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_numBtn addTarget:self action:@selector(NumBtnClicked)forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:_numBtn];
    
    
    
    _stcBtn.frame=CGRectMake(self.view.frame.size.width/2, (self.view.frame.size.height-63)*0.7+63, self.view.frame.size.width/2, (self.view.frame.size.height-63)*0.15);
    _stcBtn.backgroundColor=[UIColor whiteColor];
    _stcBtn.layer.borderWidth=0.5;
    _stcBtn.layer.borderColor=[UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:1].CGColor;
    [_stcBtn setTitle: @"统计信息" forState: UIControlStateNormal];
    [_stcBtn setImage: [UIImage imageNamed:@"ico_make"] forState:UIControlStateNormal];
    _stcBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [_stcBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_stcBtn addTarget:self action:@selector(StcBtnClicked)forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:_stcBtn];
    
    
    
    _setBtn.frame=CGRectMake(0, (self.view.frame.size.height-63)*0.85+63, self.view.frame.size.width/2, (self.view.frame.size.height-63)*0.15);
    _setBtn.backgroundColor=[UIColor whiteColor];
    _setBtn.layer.borderWidth=0.5;
    _setBtn.layer.borderColor=[UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:1].CGColor;
    [_setBtn setTitle: @"设置" forState: UIControlStateNormal];
    [_setBtn setImage: [UIImage imageNamed:@"ico_make"] forState:UIControlStateNormal];
    _setBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [_setBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_setBtn addTarget:self action:@selector(SetBtnClicked)forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:_setBtn];
    
    
    _moreBtn.frame=CGRectMake(self.view.frame.size.width/2, (self.view.frame.size.height-63)*0.85+63, self.view.frame.size.width/2, (self.view.frame.size.height-63)*0.15);
    _moreBtn.backgroundColor=[UIColor whiteColor];
    _moreBtn.layer.borderWidth=0.5;
    _moreBtn.layer.borderColor=[UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:1].CGColor;
    [_moreBtn setTitle: @"更多..." forState: UIControlStateNormal];
    [_moreBtn setImage: [UIImage imageNamed:@"ico_make"] forState:UIControlStateNormal];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [_moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(MoreBtnClicked)forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:_moreBtn];
    
}
-(void)NumBtnClicked{
    NSLog(@"num");
}
-(void)StcBtnClicked{
    NSLog(@"stc");
}
-(void)SetBtnClicked{
    NSLog(@"set");
}
-(void)MoreBtnClicked{
    NSLog(@"more");
}
-(void)didLoadBlueTooth{
    [blueToothController startScan];
}
-(void)didRecieveData:(NSData *)data FromBlueToothController:(BlueToothController *)blueToothController{
    NSLog(@"Data Received:\n %@",data);
    Byte a[4] = {'W','H','U','N'};
    NSData* da = [NSData dataWithBytes:a length:4];
    [blueToothController writeData:da];
}
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 3;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==0) {
        
        return _currentData1Index;
        
    }
    if (column==1) {
        
        return _currentData2Index;
    }
    
    return _currentData3Index;
}
- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==0) {
        
        return _data1.count;
            
    } else if (column==1){
        
        return _data2.count;
        
    } else if (column==2){
        
        return _data3.count;
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0: return _data1[0];
            break;
        case 1: return _data2[0];
            break;
        case 2: return _data3[0];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column==0) {
        
        return _data1[indexPath.row];
        
    } else if (indexPath.column==1) {
        
        return _data2[indexPath.row];
        
    } else {
        
        return _data3[indexPath.row];
    }
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        switch (indexPath.row) {
            case 0:
                break;
            case 1:
                break;
            case 2:
                break;
            case 3:
                break;
            default:
                break;
        }
        _currentData1Index = indexPath.row;
        
    } else if(indexPath.column == 1){
        switch (indexPath.row) {
            case 0:
                break;
            case 1:
                break;
            case 2:
                break;
            default:
                break;
        }
        _currentData2Index = indexPath.row;
        
    } else{
        
        _currentData3Index = indexPath.row;
    }
}


@end