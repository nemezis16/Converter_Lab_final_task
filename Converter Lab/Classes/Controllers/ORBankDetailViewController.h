//
//  ORBankDetailViewController.h
//  Converter Lab
//
//  Created by RomanOsadchuk on 16.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORBank.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "ORFloatingButton.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface ORBankDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate,floatMenuDelegate >


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)ORBank * bankSelected;

@end
