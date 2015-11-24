//
//  Currency.h
//  Converter Lab
//
//  Created by RomanOsadchuk on 14.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ORBank;

@interface ORCurrency : NSManagedObject

@property (nonatomic, retain) NSString * ask;
@property (nonatomic, retain) NSString * bid;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * currencyDescription;
@property (nonatomic, retain) ORBank *relationship;

@end
