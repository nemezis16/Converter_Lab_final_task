//
//  ORBank.h
//  Converter Lab
//
//  Created by RomanOsadchuk on 13.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

//extern NSString *const ORBankIDKey;
//
//extern NSString *const ORBankAdressKey;
//extern NSString *const ORBankCityKey;
//extern NSString *const ORBankRegionKey;
//
//extern NSString *const ORBankLinkKey;
//extern NSString *const ORBankOrgTypeKey;
//extern NSString *const ORBankPhoneKey;
//extern NSString *const ORBankTitleKey;


@class ORCurrency;

@interface ORBank : NSManagedObject

@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * link;
@property (nonatomic, strong) NSString * orgType;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * region;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, retain) NSSet *currency;
@end

@interface ORBank (CoreDataGeneratedAccessors)

- (void)addCurrencyObject:(ORCurrency *)value;
- (void)removeCurrencyObject:(ORCurrency *)value;
- (void)addCurrency:(NSSet *)values;
- (void)removeCurrency:(NSSet *)values;


@end
