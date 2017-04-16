//
//  EditViewController.h
//  myPersonalAddressBook
//
//  Created by Siyuan Duan on 2017/4/14.
//  Copyright © 2017年 Siyuan Duan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Contact, EditViewController;

@protocol EditViewControllerDelegate <NSObject>

@optional
- (void)editViewController:(EditViewController *)editViewController addContact:(Contact *)contact;

@end

@interface EditViewController : UIViewController

@property (nonatomic, strong) Contact *contact;

@property (nonatomic, strong) id<EditViewControllerDelegate> delegate;

@end
