//
//  ORBankCellButton.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 20.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORBankCellButton.h"

@implementation ORBankCellButton

-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    
    if (!self.shadowButton) {
        CGRect frameButton=self.frame;
        CGRect buttonShadow=CGRectMake(0,CGRectGetHeight(frameButton)-3 , CGRectGetWidth(frameButton), 3);
        self.shadowButton =[[UIView alloc]initWithFrame:buttonShadow];
        self.shadowButton.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:0.0f/255.0f blue:127.0f/255.0f alpha:1.0f];
        self.shadowButton.hidden=YES;
        self.shadowButton.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.shadowButton];
    }
    
    if (highlighted) {
        self.shadowButton.hidden=NO;
    }else{
        self.shadowButton.hidden=YES;
    }
}


@end
