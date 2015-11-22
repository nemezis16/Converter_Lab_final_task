//
//  ORDataManager.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 13.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORDataManager.h"
#import "ORDataReciever.h"
#import "ORDataBuilder.h"

@interface ORDataManager ()
@property(nonatomic , strong) ORDataReciever *dataReciever;
@end

@implementation ORDataManager

-(void)fetchData{
    self.dataReciever=[[ORDataReciever alloc]init];
    self.dataReciever.delegate=self;
    [self.dataReciever makeRequest];
}

-(void)didRecieveJSON:(NSMutableData *)data{
    
    [self.delegate dataDidUpdate];
    
    ORDataBuilder* dataBuilder=[ORDataBuilder new];
    [dataBuilder clearDatabase];
    [dataBuilder updateManagedObjectContextWithData:data];
    
    
}

-(void)didFailJSONWithError:(NSError *)error{
    
    //show error
    [self.delegate dataDidFailWithError:error];
}



@end
