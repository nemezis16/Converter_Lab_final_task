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
    [self.dataReciever makeFetchRequest];
}

-(void)didRecieveJSON:(NSMutableData *)data{
    
    ORDataBuilder* dataBuilder=[ORDataBuilder new];
    [dataBuilder clearDatabase];
    [dataBuilder updateManagedObjectContextWithData:data];
    [self.delegate dataDidUpdate];
    
}

-(void)didFailJSONWithError:(NSError *)error{
    
    //show error
    [self.delegate dataDidFailWithError:error];
}



@end
