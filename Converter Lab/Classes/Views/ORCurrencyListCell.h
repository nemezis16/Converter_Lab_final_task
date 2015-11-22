//
//  ORCurrencyListCell.h
//  Converter Lab
//
//  Created by RomanOsadchuk on 16.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ORCurrencyListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *currency;
@property (weak, nonatomic) IBOutlet UILabel *bid;
@property (weak, nonatomic) IBOutlet UILabel *ask;

@end
