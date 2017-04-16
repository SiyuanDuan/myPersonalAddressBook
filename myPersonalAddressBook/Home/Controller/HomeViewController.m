//
//  HomeViewController.m
//  myPersonalAddressBook
//
//  Created by Siyuan Duan on 2017/4/14.
//  Copyright © 2017年 Siyuan Duan. All rights reserved.
//

#import "HomeViewController.h"
#import "ContactsViewController.h"
#import <SVProgressHUD.h>
#import <AVOSCloud/AVOSCloud.h>
#import "Person.h"

@interface HomeViewController ()

@property(nonatomic, weak) UIButton *logButton;
@property(nonatomic, weak) UITextField *accountTextField;
@property(nonatomic, weak) UITextField *passwordTextField;
@property(nonatomic, weak) UISwitch *remeberPasswordSwitch;
@property(nonatomic, weak) UISwitch *automaticLogonSwitch;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //在数据库中记录
    AVObject *testObject = [AVObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"bar" forKey:@"foo"];
    [testObject save];
    
    [self setNavigationBar];
    [self drawLabelAndText];
    
    [self addTarget];
    
    // 测试沙盒
    [self save];
}

#pragma mark - 设置导航栏

- (void)setNavigationBar
{
    self.navigationItem.title = @"私人通讯录";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:1.00 green:0.40 blue:0.15 alpha:1.00]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
}

#pragma mark - 绘制登录界面

- (void)drawLabelAndText
{
    CGFloat accountLabelX = self.view.bounds.size.width / 10.0;
    CGFloat accountLabelY = 64 + self.view.bounds.size.width / 10.0;
    CGFloat accountLabelW = accountLabelX;
    CGFloat accountLabelH = 20;
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(accountLabelX, accountLabelY, accountLabelW, accountLabelH)];
    accountLabel.text = @"账号";
    [self.view addSubview:accountLabel];
    
    CGFloat passwordLabelX = accountLabelX;
    CGFloat passwordLabelY = accountLabelY + accountLabelH + 20;
    CGFloat passwordLabelW = accountLabelW;
    CGFloat passwordLabelH = accountLabelH;
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(passwordLabelX, passwordLabelY, passwordLabelW, passwordLabelH)];
    passwordLabel.text = @"密码";
    [self.view addSubview:passwordLabel];
    
    CGFloat accountTextFieldX = accountLabelX + accountLabelW + 40;
    CGFloat accountTextFieldY = accountLabelY;
    CGFloat accountTextFieldW = self.view.bounds.size.width / 2.0;
    CGFloat accountTextFieldH = accountLabelH;
    UITextField *accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(accountTextFieldX, accountTextFieldY, accountTextFieldW, accountTextFieldH)];
    accountTextField.placeholder = @"请输入账号(*)";
    accountTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    [self.view addSubview:accountTextField];
    self.accountTextField = accountTextField;
    
    CGFloat passwordTextFieldX = accountTextFieldX;
    CGFloat passwordTextFieldY = passwordLabelY;
    CGFloat passwordTextFieldW = accountTextFieldW;
    CGFloat passwordTextFieldH = accountLabelH;
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(passwordTextFieldX, passwordTextFieldY, passwordTextFieldW, passwordTextFieldH)];
    passwordTextField.placeholder = @"请输入密码(*)";
    passwordTextField.secureTextEntry = YES;
    [self.view addSubview:passwordTextField];
    self.passwordTextField = passwordTextField;
    
    CGFloat remeberPasswordLabelX = accountLabelX;
    CGFloat remeberPasswordLabelY = passwordLabelY + passwordLabelH + 25;
    CGFloat remeberPasswordLabelW = passwordLabelW + 40;
    CGFloat remeberPasswordLabelH = accountLabelH;
    UILabel *remeberPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(remeberPasswordLabelX, remeberPasswordLabelY, remeberPasswordLabelW, remeberPasswordLabelH)];
    remeberPasswordLabel.text = @"记住密码";
    [self.view addSubview:remeberPasswordLabel];
    
    CGFloat remeberPasswordSwitchX = remeberPasswordLabelX + remeberPasswordLabelW;
    CGFloat remeberPasswordSwitchY = passwordLabelY + passwordLabelH + 20;
    CGFloat remeberPasswordSwitchW = remeberPasswordLabelW;
    CGFloat remeberPasswordSwitchH = accountLabelH;
    UISwitch *remeberPasswordSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(remeberPasswordSwitchX, remeberPasswordSwitchY, remeberPasswordSwitchW, remeberPasswordSwitchH)];
    [self.view addSubview:remeberPasswordSwitch];
    self.remeberPasswordSwitch = remeberPasswordSwitch;
    
    CGFloat automaticLogonLabelX = remeberPasswordSwitchX + remeberPasswordSwitchW;
    CGFloat automaticLogonLabelY = passwordLabelY + passwordLabelH + 25;
    CGFloat automaticLogonLabelW = passwordLabelW + 40;
    CGFloat automaticLogonLabelH = accountLabelH;
    UILabel *automaticLogonLabel = [[UILabel alloc] initWithFrame:CGRectMake(automaticLogonLabelX, automaticLogonLabelY, automaticLogonLabelW, automaticLogonLabelH)];
    automaticLogonLabel.text = @"自动登录";
    [self.view addSubview:automaticLogonLabel];
    
    CGFloat automaticLogonSwitchX = automaticLogonLabelX + automaticLogonLabelW;
    CGFloat automaticLogonSwitchY = passwordLabelY + passwordLabelH + 20;
    CGFloat automaticLogonSwitchW = remeberPasswordLabelW;
    CGFloat automaticLogonSwitchH = accountLabelH;
    UISwitch *automaticLogonSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(automaticLogonSwitchX, automaticLogonSwitchY, automaticLogonSwitchW, automaticLogonSwitchH)];
    [self.view addSubview:automaticLogonSwitch];
    self.automaticLogonSwitch = automaticLogonSwitch;
    
    CGFloat logButtonX = self.view.bounds.size.width / 2.0 - 40;
    CGFloat logButtonY = remeberPasswordLabelY + 40;
    CGFloat logButtonW = 80;
    CGFloat logButtonH = accountLabelH;
    UIButton *logButton = [[UIButton alloc] initWithFrame:CGRectMake(logButtonX, logButtonY, logButtonW, logButtonH)];
    [logButton setTitle:@"登录" forState:UIControlStateNormal];
    [logButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //[logButton setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[logButton setTintColor:[UIColor grayColor]];
    [logButton setEnabled:NO];
    //[logButton setAdjustsImageWhenHighlighted:NO];
    //[logButton setAdjustsImageWhenDisabled:NO];
    [self.view addSubview:logButton];
    self.logButton = logButton;
}

#pragma mark - 添加文本框和按钮的响应事件，或者通知

- (void)addTarget
{
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.accountTextField];
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
    
    // 登录按钮添加响应事件
    [self.logButton addTarget:self action:@selector(pushToContactsViewController) forControlEvents:UIControlEventTouchUpInside];
    
    // 给开关添加响应方法
    [self.remeberPasswordSwitch addTarget:self action:@selector(remeberPasswordChange) forControlEvents:UIControlEventValueChanged];
    [self.automaticLogonSwitch addTarget:self action:@selector(automaticLogonChange) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - 登录按钮响应事件方法

- (void)pushToContactsViewController
{
    //测试AVOS登陆
    AVUser *user = [AVUser user];
    user.username = @"siyuanduan";
    user.password = @"123";
    //user.email = email;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self performSegueWithIdentifier:@"fromSignUpToProducts" sender:nil];
        } else {
            NSLog(@"注册失败 %@", error);
        }
    }];
    //本地检验
    if (![self.accountTextField.text isEqualToString:@"siyuanduan"]) {
        // 账号不存在
        [SVProgressHUD showErrorWithStatus:@"账号不存在"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    if (![self.passwordTextField.text isEqualToString:@"123"]) {
        // 密码错误
        [SVProgressHUD showErrorWithStatus:@"密码错误"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    //leancloud登陆
         //LeanCloud - 登录
         //https://leancloud.cn/docs/leanstorage_guide-objc.html#登录
        [AVUser logInWithUsernameInBackground:user.username password:user.password block:^(AVUser *user, NSError *error) {
            if (error) {
                NSLog(@"登录失败 %@", error);
            } else {
                [self performSegueWithIdentifier:@"fromLoginToProducts" sender:nil];
            }
        }];
    
    
    [SVProgressHUD showWithStatus:@"正在加载..."]; // 这是转菊花的样式
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        ContactsViewController *contactsViewController = [[ContactsViewController alloc] init];
        contactsViewController.title = [NSString stringWithFormat:@"%@的联系人列表", self.accountTextField.text];
        [self.navigationController pushViewController:contactsViewController animated:YES];
    });
}

/**
 * 文本框的文字发生改变的时候调用
 */
- (void)textChange
{
    self.logButton.enabled = (self.accountTextField.text.length && self.passwordTextField.text.length);
}


- (void)remeberPasswordChange
{
    if (self.remeberPasswordSwitch.isOn == NO) {
        //        self.automaticLogonSwitch.on = NO;
        [self.automaticLogonSwitch setOn:NO animated:YES];
    }
}

- (void)automaticLogonChange
{
    if (self.automaticLogonSwitch.isOn) {
        //        self.remeberPasswordSwitch.on = YES;
        [self.remeberPasswordSwitch setOn:YES animated:YES];
    }
}

#pragma mark - 销毁方法

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)save
{
    //    NSString *home = NSHomeDirectory();
    
    //    NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
    
    //    NSArray *data = @[@"jack", @10, @"yoferzhang"];
    //    NSString *filePath = [docPath stringByAppendingPathComponent:@"data.plist"];
    //    [data writeToFile:filePath atomically:YES];
    
    //    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documents = [array objectAtIndex:0];
    //
    //    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //    [dict setObject:@"小明" forKey:@"name"];
    //    [dict setObject:@"15013141314" forKey:@"phone"];
    //    [dict setObject:@"27" forKey:@"age"];
    //    // 将字典持久化到Documents/stu.plist文件中
    //    NSString *filePath = [documents stringByAppendingPathComponent:@"data.plist"];
    //    [dict writeToFile:filePath atomically:YES];
    //
    //    // 读取Documents/stu.plist的内容，实例化NSDictionary
    //    NSDictionary *dictread = [NSDictionary dictionaryWithContentsOfFile:filePath];
    //    NSLog(@"name:%@", [dictread objectForKey:@"name"]);
    //    NSLog(@"phone:%@", [dictread objectForKey:@"phone"]);
    //    NSLog(@"age:%@", [dictread objectForKey:@"age"]);
    
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults setObject:@"yoferzhang" forKey:@"username"];
    //    [defaults setFloat:18.0f forKey:@"text_size"];
    //    [defaults setBool:YES forKey:@"auto_login"];
    //
    ////    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSString *username = [defaults stringForKey:@"username"];
    //    float textSize = [defaults floatForKey:@"text_size"];
    //    BOOL autoLogin = [defaults boolForKey:@"auto_login"];
    //    NSLog(@"%@, %f, %d", username, textSize, autoLogin);
    //
    //    NSArray *array = [NSArray arrayWithObjects:@"a",@"b",nil];
    //    [NSKeyedArchiver archiveRootObject:array toFile:path];
    //
    //    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documents = [array objectAtIndex:0];
    //    NSString *filePath = [documents stringByAppendingPathComponent:@"data.plist"];
    //    Person *person = [[Person alloc] init];
    //    person.name = @"yoferzhang";
    //    person.age = 27;
    //    person.height = 1.83f;
    //    [NSKeyedArchiver archiveRootObject:person toFile:filePath];
    //    
    //    Person *person02 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    
    //    NSLog(@"%@", documents);
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
