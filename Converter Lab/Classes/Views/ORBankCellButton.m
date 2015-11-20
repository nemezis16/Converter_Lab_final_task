//
//  ORBankCellButton.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 20.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORBankCellButton.h"

@implementation ORBankCellButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setHighlighted:(BOOL)highlighted{
    if (!self.shadowButton) {
        CGRect frameButton=self.frame;
        CGRect buttonShadow=CGRectMake(0,CGRectGetHeight(frameButton)-3 , CGRectGetWidth(frameButton), 3);
        self.shadowButton =[[UIView alloc]initWithFrame:buttonShadow];
        self.shadowButton.backgroundColor=[UIColor purpleColor];
        self.shadowButton.hidden=YES;
        [self addSubview:self.shadowButton];
        
    }
    
    if (highlighted) {
        self.shadowButton.hidden=NO;
         NSLog(@"highlighted +%@",self.shadowButton);
    }else{
        self.shadowButton.hidden=YES;
         NSLog(@" not highlighted");
    }
}

@end
