//
//  ORDataReciever.h
//  Converter Lab
//
//  Created by RomanOsadchuk on 12.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ORDataRecieverDelegate.h"

@interface ORDataReciever : NSObject

@property (weak ,nonatomic) id<ORDataRecieverDelegate> delegate;

+(id)getClassInstance;
-(void)makeFetchRequest;

@end
