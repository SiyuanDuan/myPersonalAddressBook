//
//  AddViewController.m
//  myPersonalAddressBook
//
//  Created by Siyuan Duan on 2017/4/14.
//  Copyright © 2017年 Siyuan Duan. All rights reserved.
//

#import "AddViewController.h"
#import "Contact.h"

@interface AddViewController ()

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *numberTextField;
@property (nonatomic, strong) UIButton *addButton;


@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    [self drawLabel];
    [self addTarget];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    // 让文本框成为第一响应者
    [self.nameTextField becomeFirstResponder];
}

- (void)setNavigation
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加联系人";
    //    [self.navigationItem.leftBarButtonItem setTitle:@"返回"];
}

- (void)drawLabel
{
    CGFloat nameLabelX = self.view.bounds.size.width / 10.0;
    CGFloat nameLabelY = 64 + self.view.bounds.size.width / 10.0;
    CGFloat nameLabelW = nameLabelX;
    CGFloat nameLabelH = 20;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH)];
    nameLabel.text = @"姓名";
    [self.view addSubview:nameLabel];
    
    CGFloat numberLabelX = nameLabelX;
    CGFloat numberLabelY = nameLabelY + nameLabelH + 20;
    CGFloat numberLabelW = nameLabelW;
    CGFloat numberLabelH = nameLabelH;
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH)];
    numberLabel.text = @"电话";
    [self.view addSubview:numberLabel];
    
    CGFloat nameTextFieldX = nameLabelX + nameLabelW + 40;
    CGFloat nameTextFieldY = nameLabelY;
    CGFloat nameTextFieldW = self.view.bounds.size.width / 2.0;
    CGFloat nameTextFieldH = nameLabelH;
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(nameTextFieldX, nameTextFieldY, nameTextFieldW, nameTextFieldH)];
    nameTextField.placeholder = @"请输入姓名(*)";
    [self.view addSubview:nameTextField];
    self.nameTextField = nameTextField;
    
    CGFloat numberTextFieldX = nameTextFieldX;
    CGFloat numberTextFieldY = numberLabelY;
    CGFloat numberTextFieldW = nameTextFieldW;
    CGFloat numberTextFieldH = nameLabelH;
    UITextField *numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(numberTextFieldX, numberTextFieldY, numberTextFieldW, numberTextFieldH)];
    numberTextField.placeholder = @"请输入电话(*)";
    numberTextField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:numberTextField];
    self.numberTextField = numberTextField;
    
    CGFloat addButtonX = self.view.bounds.size.width / 2.0 - 60;
    CGFloat addButtonY = numberTextFieldY + 40;
    CGFloat addButtonW = 120;
    CGFloat addButtonH = nameLabelH;
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(addButtonX, addButtonY, addButtonW, addButtonH)];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addButton setEnabled:NO];
    [self.view addSubview:addButton];
    self.addButton = addButton;
}

#pragma mark - 添加响应事件

- (void)addTarget
{
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.numberTextField];
    
    // 登录按钮添加响应事件
    [self.addButton addTarget:self action:@selector(addContacts) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 实现响应方法

/**
 * 文本框的文字发生改变的时候调用
 */
- (void)textChange
{
    self.addButton.enabled = (self.nameTextField.text.length && self.numberTextField.text.length);
}

#pragma mark - 调用 AddViewControllerDelegate 代理方法
- (void)addContacts
{
    // 回传数据
    if ([self.delegate respondsToSelector:@selector(addViewController:addContact:)]) {
        Contact *contact = [[Contact alloc] init];
        contact.name = self.nameTextField.text;
        contact.number = self.numberTextField.text;
        [self.delegate addViewController:self addContact:contact];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
