//
//  ORShareDialogView.h
//  Converter Lab
//
//  Created by RomanOsadchuk on 23.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORCurrency.h"
#import "ORBank.h"

typedef void(^CompletionBlock)(void);
typedef void(^CompletionBlockWithEmail)(void);

@interface ORShareDialogView : UIView <UITableViewDataSource,UITableViewDelegate>


-(void)configureWindow;

@property (copy,nonatomic) CompletionBlock completionBlock;
@property (copy,nonatomic) CompletionBlockWithEmail completionBlockWithEmail;

@property (strong,nonatomic) ORBank *bank;


@end
