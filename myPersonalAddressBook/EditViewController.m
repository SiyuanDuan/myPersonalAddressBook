//
//  EditViewController.m
//  myPersonalAddressBook
//
//  Created by Siyuan Duan on 2017/4/14.
//  Copyright © 2017年 Siyuan Duan. All rights reserved.
//

#import "EditViewController.h"
#import "Contact.h"

@interface EditViewController ()

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *numberTextField;
@property (nonatomic, strong) UIButton *saveButton;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigation];
    [self drawLabel];
    [self addTarget];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:YES];
//
//    // 让文本框成为第一响应者
//    [self.nameTextField becomeFirstResponder];
//}

- (void)setNavigation
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"查看联系人";
    //    [self.navigationItem.leftBarButtonItem setTitle:@"返回"];
    
    // 设置右上角的按钮
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editContact)];
    [self.navigationItem setRightBarButtonItem:rightBar];
}

#pragma mark - 右上角编辑按钮的响应方法

- (void)editContact
{
    if (self.nameTextField.enabled) { // 点击的是“取消”
        self.nameTextField.enabled = NO;
        self.numberTextField.enabled = NO;
        self.nameTextField.text = self.contact.name;
        self.numberTextField.text = self.contact.number;
        [self.saveButton setHidden:YES];
        self.navigationItem.rightBarButtonItem.title = @"编辑";
    } else { // 点击的是 "编辑"
        self.nameTextField.enabled = YES;
        self.numberTextField.enabled = YES;
        
        // 让文本框成为第一响应者
        [self.numberTextField becomeFirstResponder];
        [self.saveButton setHidden:NO];
        self.navigationItem.rightBarButtonItem.title = @"取消";
    }
    
}

#pragma mark - 添加label和button

- (void)drawLabel
{
    CGFloat nameLabelX = self.view.bounds.size.width / 10.0;
    CGFloat nameLabelY = 64 + self.view.bounds.size.width / 10.0;
    CGFloat nameLabelW = nameLabelX;
    CGFloat nameLabelH = 25;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH)];
    nameLabel.text = @"姓名";
    nameLabel.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:nameLabel];
    
    CGFloat numberLabelX = nameLabelX;
    CGFloat numberLabelY = nameLabelY + nameLabelH + 20;
    CGFloat numberLabelW = nameLabelW;
    CGFloat numberLabelH = nameLabelH;
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH)];
    numberLabel.text = @"电话";
    numberLabel.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:numberLabel];
    
    CGFloat nameTextFieldX = nameLabelX + nameLabelW + 40;
    CGFloat nameTextFieldY = nameLabelY;
    CGFloat nameTextFieldW = self.view.bounds.size.width / 2.0;
    CGFloat nameTextFieldH = nameLabelH;
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(nameTextFieldX, nameTextFieldY, nameTextFieldW, nameTextFieldH)];
    nameTextField.placeholder = @"请输入姓名(*)";
    nameTextField.text = self.contact.name;
    nameTextField.borderStyle=UITextBorderStyleBezel;
    nameTextField.font=[UIFont systemFontOfSize:20];
    nameTextField.enabled = NO;
    [self.view addSubview:nameTextField];
    self.nameTextField = nameTextField;
    
    CGFloat numberTextFieldX = nameTextFieldX;
    CGFloat numberTextFieldY = numberLabelY;
    CGFloat numberTextFieldW = nameTextFieldW;
    CGFloat numberTextFieldH = nameLabelH;
    UITextField *numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(numberTextFieldX, numberTextFieldY, numberTextFieldW, numberTextFieldH)];
    numberTextField.placeholder = @"请输入电话(*)";
    numberTextField.text = self.contact.number;
    numberTextField.borderStyle=UITextBorderStyleBezel;
    numberTextField.font=[UIFont systemFontOfSize:20];
    numberTextField.enabled = NO;
    numberTextField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:numberTextField];
    self.numberTextField = numberTextField;
    
    CGFloat saveButtonX = self.view.bounds.size.width / 2.0 - 60;
    CGFloat saveButtonY = numberTextFieldY + 40;
    CGFloat saveButtonW = 120;
    CGFloat saveButtonH = nameLabelH;
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(saveButtonX, saveButtonY, saveButtonW, saveButtonH)];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [saveButton setEnabled:NO];
    [saveButton setHidden:YES];
    [self.view addSubview:saveButton];
    self.saveButton = saveButton;
}

#pragma mark - 添加响应事件

- (void)addTarget
{
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.numberTextField];
    
    // 登录按钮添加响应事件
    [self.saveButton addTarget:self action:@selector(saveContact) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 调用 AddViewControllerDelegate 代理方法
- (void)saveContact
{
    // 回传数据
    if ([self.delegate respondsToSelector:@selector(editViewController:addContact:)]) {
        self.contact.name = self.nameTextField.text;
        self.contact.number = self.numberTextField.text;
        [self.delegate editViewController:self addContact:self.contact];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * 文本框的文字发生改变的时候调用
 */
- (void)textChange
{
    self.saveButton.enabled = (self.nameTextField.text.length && self.numberTextField.text.length);
}







/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
