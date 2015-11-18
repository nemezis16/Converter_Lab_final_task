//
//  ORDataRecieverDelegate.h
//  Converter Lab
//
//  Created by RomanOsadchuk on 13.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ORDataRecieverDelegate <NSObject>
-(void)didRecieveJSON:(NSMutableData *)data;
-(void)didFailJSONWithError:(NSError *)error;
@end
