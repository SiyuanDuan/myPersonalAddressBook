//
//  AddViewController.h
//  myPersonalAddressBook
//
//  Created by Siyuan Duan on 2017/4/14.
//  Copyright © 2017年 Siyuan Duan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Contact, AddViewController;

@protocol AddViewControllerDelegate <NSObject>

@optional
- (void)addViewController:(AddViewController *)addViewController addContact:(Contact *)contact;

@end

@interface AddViewController : UIViewController

@property (nonatomic, strong) id<AddViewControllerDelegate> delegate;


@end
