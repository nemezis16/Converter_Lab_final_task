//
//  ORDataManagerDelegate.h
//  Converter Lab
//
//  Created by RomanOsadchuk on 13.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ORDataManagerDelegate <NSObject>

-(void)dataDidUpdate;

-(void)dataDidFailWithError:(NSError *)error;

@end
