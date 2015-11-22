//
//  ORBankDetailViewController.h
//  Converter Lab
//
//  Created by RomanOsadchuk on 16.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORBank.h"
#import "VCFloatingActionButton.h"

@interface ORBankDetailViewController : UITableViewController<floatMenuDelegate>

@property (nonatomic, strong)ORBank * bankSelected;

@end
