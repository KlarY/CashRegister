//
//  ViewController.m
//  BlueToothCentralTest
//
//  Created by Klar on 15/4/12.
//  Copyright (c) 2015年 WHU. All rights reserved.
//

#import "BlueToothController.h"

@interface BlueToothController ()<CBCentralManagerDelegate,CBPeripheralDelegate>
@end

@implementation BlueToothController

static NSString * const kServiceUUID = @"FFE0";
static NSString * const kCharacteristicUUID = @"FFE1";

+ (BlueToothController *)sharedManager
{
    static BlueToothController *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}

- (BlueToothController*)init {
    //init
    self = [super init];
    if(self){
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
        NSLog(@"BlueToothController inited\n");
        self.data= [[NSMutableData alloc] init];
        self.dataLength = 0;
    }
    return self;
}


-(void)startScan{
    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID] ] options:nil];
}


- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"Discover peripheral name : %@\n", peripheral.name);
    
    if (self.peripheral != peripheral) {
        self.peripheral = peripheral;
        NSLog(@"Connecting to peripheral %@\n", peripheral);
        // Connects to the discovered peripheral
            [self.centralManager connectPeripheral:peripheral options:nil];
            [self.centralManager stopScan];
    }
    NSLog(@"Scanning stop\n");
}


- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"Peripheral Connected\n");
    
    peripheral.delegate = self;
    [peripheral discoverServices:@[[CBUUID UUIDWithString:kServiceUUID] ]];
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSLog(@"Discover Service\n");
    
    for (CBService *service in peripheral.services)
    {
        NSLog(@"Discovered service %@\n", service);
        self.se = service;
        NSLog(@"Discovering characteristics for service %@\n", service);
        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:kCharacteristicUUID]] forService:service];
    }
    
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"Discover Characteristics\n");
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        self.ch = characteristic;
        NSLog(@"Discovered characteristic %@\n", characteristic);
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    }
}


-(NSString*)getBlueToothName{
    if(self.peripheral){
        return self.peripheral.name;
    }
    return @"";
}


-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    Byte* testByte = (Byte*)[characteristic.value bytes];
    if(*testByte == 'W' && *(testByte+1) =='H' && *(testByte+2) == 'U' && *(testByte+3) =='N' && characteristic.value.length>=20){
        if(self.data.length != 0){
            NSLog(@"包数据丢失或长度错误:%@",self.data);
            self.data = [[NSMutableData alloc] init];
            self.dataLength = 0;
            self.currentLength = 0;
        }
        Byte length[4] = {*(testByte+4), *(testByte+5),*(testByte+6),*(testByte+7)};
        int t=(length[0]<<24)&0xff000000;
        t+=(length[1]<<16)&0xff0000;
        t+=(length[2]<<8)&0xff00;
        t+=length[3]&0xff;
        self.dataLength = (NSUInteger)t;
        [self.data appendData:characteristic.value];
        self.currentLength += characteristic.value.length;
        if(self.currentLength == self.dataLength){
            [self sentData:[NSData dataWithData:self.data]];
            self.data = [[NSMutableData alloc] init];
            self.dataLength = 0;
            self.currentLength = 0;
        }
    }else{
        if (self.data.length == 0) {
            NSLog(@"错误的数据！\n");
            return;
        }
        [self.data appendData:characteristic.value];
        self.currentLength+=characteristic.value.length;
        if(self.currentLength == self.dataLength){
            [self sentData:[NSData dataWithData:self.data]];
            self.data = [[NSMutableData alloc] init];
            self.dataLength = 0;
            self.currentLength = 0;
        }
        if(self.currentLength > self.dataLength){
            NSLog(@"长度错误:%@",self.data);
            self.data = [[NSMutableData alloc] init];
            self.dataLength = 0;
            self.currentLength = 0;
        }
    }
}


-(void)sentData:(NSData *)data{
    [self.delegate didRecieveData:data FromBlueToothController:self];
}


-(void)writeData:(NSData *)data{
    [self.peripheral writeValue:data forCharacteristic:self.ch type:CBCharacteristicWriteWithResponse];
}


- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"Central Update State\n");
    
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            NSLog(@"CBCentralManagerStatePoweredOn\n");
            [self.delegate didLoadBlueTooth];
            break;
            
        case CBCentralManagerStatePoweredOff:
            NSLog(@"CBCentralManagerStatePoweredOff\n");
            break;
            
        case CBCentralManagerStateUnsupported:
            NSLog(@"CBCentralManagerStateUnsupported\n");
            break;
            
        default:
            break;
    }
}


@end
