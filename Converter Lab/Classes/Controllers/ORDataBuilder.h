//
//  ORORDataBuilder.h
//  Converter Lab
//
//  Created by RomanOsadchuk on 13.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//




#import <Foundation/Foundation.h>

@interface ORDataBuilder : NSObject

-(void)updateManagedObjectContextWithData:(NSData *)data;

-(void)clearDatabase;

@end