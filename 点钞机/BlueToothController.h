//
//  ViewController.h
//  BlueToothCentralTest
//
//  Created by Klar on 15/4/12.
//  Copyright (c) 2015年 WHU. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

@class BlueToothController;

@class BlueToothController;
@protocol BlueToothControllerDelegate

-(void)didRecieveData:(NSData*)data FromBlueToothController:(BlueToothController*)blueToothController;
-(void)didLoadBlueTooth;

@end

@interface BlueToothController : NSObject

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) CBCharacteristic* ch;
@property (nonatomic, strong) CBService* se;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, assign) NSUInteger dataLength;
@property (nonatomic, assign) NSUInteger currentLength;
@property (nonatomic, unsafe_unretained) id<BlueToothControllerDelegate> delegate;
+(BlueToothController *)sharedManager;
-(void)startScan;
-(NSString*)getBlueToothName;
-(void)writeData:(NSData*)data;
@end
