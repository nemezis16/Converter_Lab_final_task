//
//  ORDataManager.h
//  Converter Lab
//
//  Created by RomanOsadchuk on 13.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ORDataRecieverDelegate.h"
#import "ORDataManagerDelegate.h"

@class ORDataReciever;

@interface ORDataManager : NSObject <ORDataRecieverDelegate>

@property (nonatomic, weak) id<ORDataManagerDelegate> delegate;


-(void)fetchData;
@end
