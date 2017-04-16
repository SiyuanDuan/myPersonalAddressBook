//
//  ContactCell.h
//  myPersonalAddressBook
//
//  Created by Siyuan Duan on 2017/4/14.
//  Copyright © 2017年 Siyuan Duan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface ContactCell : UITableViewCell

@property (nonatomic, strong) Contact *contact;

+ (instancetype)cellWithTalbeView:(UITableView *)tableView;
@end
