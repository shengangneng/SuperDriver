//
//  ViewController.m
//  SuperDriver
//
//  Created by shengangneng on 2017/11/13.
//  Copyright © 2017年 com.shen.superdriver. All rights reserved.
//

#import "SDLoginViewController.h"
#import "SDHomeTabBarViewController.h"
#import "AppDelegate.h"

@interface SDLoginViewController () <UITextFieldDelegate>

/** 顶部logo */
@property (nonatomic, strong) UIImageView *headerLogoView;
/** 中间输入部分 */
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;
/** 底部buttom */
@property (nonatomic, strong) UIButton *contactUSButton;
@property (nonatomic, strong) UIButton *otherLoginButton;

@end

@implementation SDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self p_createUI];
}

- (void)p_createUI {
    _headerLogoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    _headerLogoView.hidden = YES;
    _usernameTextField = [self p_createTextFieldWithPlaceholder:@"请输入用户名" color:RGBA(246,249,244,1)];
    _passwordTextField = [self p_createTextFieldWithPlaceholder:@"请输入密码" color:RGBA(246,249,244,1)];
    _loginButton = [self p_createButtonWithTitle:@"登录" color:[UIColor colorWithRed:92/255.0 green:167/255.0 blue:186/255.0 alpha:1.0] radius:5];
    [_loginButton addTarget:self action:@selector(p_login:) forControlEvents:UIControlEventTouchUpInside];
    _registerButton = [self p_createButtonWithTitle:@"注册" color:[UIColor colorWithRed:92/255.0 green:167/255.0 blue:186/255.0 alpha:1.0] radius:5];
    _contactUSButton = [self p_createButtonWithTitle:@"联系我们" color:[UIColor colorWithRed:92/255.0 green:167/255.0 blue:186/255.0 alpha:1.0] radius:5];
    _otherLoginButton = [self p_createButtonWithTitle:@"其他登录方式" color:[UIColor colorWithRed:92/255.0 green:167/255.0 blue:186/255.0 alpha:1.0] radius:5];
    
    _headerLogoView.translatesAutoresizingMaskIntoConstraints =
    _usernameTextField.translatesAutoresizingMaskIntoConstraints =
    _passwordTextField.translatesAutoresizingMaskIntoConstraints =
    _loginButton.translatesAutoresizingMaskIntoConstraints =
    _registerButton.translatesAutoresizingMaskIntoConstraints =
    _contactUSButton.translatesAutoresizingMaskIntoConstraints =
    _otherLoginButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    _usernameTextField.delegate = _passwordTextField.delegate = self;
    
    [self.view addSubview:_headerLogoView];
    [self.view addSubview:_usernameTextField];
    [self.view addSubview:_passwordTextField];
    [self.view addSubview:_loginButton];
    [self.view addSubview:_registerButton];
    [self.view addSubview:_contactUSButton];
    [self.view addSubview:_otherLoginButton];
    
    NSLayoutConstraint *headerLeft   = [NSLayoutConstraint constraintWithItem:_headerLogoView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:35];
    NSLayoutConstraint *headerTop    = [NSLayoutConstraint constraintWithItem:_headerLogoView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:10];
    NSLayoutConstraint *headerRight  = [NSLayoutConstraint constraintWithItem:_headerLogoView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-30];
    NSLayoutConstraint *headerHeight = [NSLayoutConstraint constraintWithItem:_headerLogoView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:0 attribute:0 multiplier:1 constant:200];
    [self.view addConstraint:headerLeft];
    [self.view addConstraint:headerTop];
    [self.view addConstraint:headerRight];
    [self.view addConstraint:headerHeight];
    
    NSLayoutConstraint *usernameLeft   = [NSLayoutConstraint constraintWithItem:_usernameTextField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:30];
    NSLayoutConstraint *usernameRight  = [NSLayoutConstraint constraintWithItem:_usernameTextField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-30];
    NSLayoutConstraint *usernameTop    = [NSLayoutConstraint constraintWithItem:_usernameTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_headerLogoView attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    NSLayoutConstraint *usernameHeight = [NSLayoutConstraint constraintWithItem:_usernameTextField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:0 attribute:0 multiplier:1 constant:40];
    [self.view addConstraint:usernameLeft];
    [self.view addConstraint:usernameRight];
    [self.view addConstraint:usernameTop];
    [self.view addConstraint:usernameHeight];
    
    NSLayoutConstraint *passwordLeft  = [NSLayoutConstraint constraintWithItem:_passwordTextField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:30];
    NSLayoutConstraint *passwordRight   = [NSLayoutConstraint constraintWithItem:_passwordTextField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-30];
    NSLayoutConstraint *passwordTop = [NSLayoutConstraint constraintWithItem:_passwordTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_usernameTextField attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    NSLayoutConstraint *passwordHeight = [NSLayoutConstraint constraintWithItem:_passwordTextField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:0 attribute:0 multiplier:1 constant:40];
    [self.view addConstraint:passwordLeft];
    [self.view addConstraint:passwordRight];
    [self.view addConstraint:passwordTop];
    [self.view addConstraint:passwordHeight];
    
    NSLayoutConstraint *loginButtonLeft  = [NSLayoutConstraint constraintWithItem:_loginButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:30];
    NSLayoutConstraint *loginButtonRight   = [NSLayoutConstraint constraintWithItem:_loginButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-30];
    NSLayoutConstraint *loginButtonTop = [NSLayoutConstraint constraintWithItem:_loginButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_passwordTextField attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    NSLayoutConstraint *loginButtonHeight = [NSLayoutConstraint constraintWithItem:_loginButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:0 attribute:0 multiplier:1 constant:40];
    [self.view addConstraint:loginButtonLeft];
    [self.view addConstraint:loginButtonRight];
    [self.view addConstraint:loginButtonTop];
    [self.view addConstraint:loginButtonHeight];
    
    NSLayoutConstraint *registerButtonLeft  = [NSLayoutConstraint constraintWithItem:_registerButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:30];
    NSLayoutConstraint *registerButtonRight   = [NSLayoutConstraint constraintWithItem:_registerButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-30];
    NSLayoutConstraint *registerButtonTop = [NSLayoutConstraint constraintWithItem:_registerButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_loginButton attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    NSLayoutConstraint *registerButtonHeight = [NSLayoutConstraint constraintWithItem:_registerButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:0 attribute:0 multiplier:1 constant:40];
    [self.view addConstraint:registerButtonLeft];
    [self.view addConstraint:registerButtonRight];
    [self.view addConstraint:registerButtonTop];
    [self.view addConstraint:registerButtonHeight];
    
    NSLayoutConstraint *contactButtonLeft  = [NSLayoutConstraint constraintWithItem:_contactUSButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:30];
    NSLayoutConstraint *contactButtonRight   = [NSLayoutConstraint constraintWithItem:_contactUSButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_otherLoginButton attribute:NSLayoutAttributeLeft multiplier:1 constant:-30];
    NSLayoutConstraint *contactButtonBottom = [NSLayoutConstraint constraintWithItem:_contactUSButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
    NSLayoutConstraint *contactButtonHeight = [NSLayoutConstraint constraintWithItem:_contactUSButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:0 attribute:0 multiplier:1 constant:30];
    NSLayoutConstraint *contactButtonWidth   = [NSLayoutConstraint constraintWithItem:_contactUSButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_otherLoginButton attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [self.view addConstraint:contactButtonLeft];
    [self.view addConstraint:contactButtonRight];
    [self.view addConstraint:contactButtonBottom];
    [self.view addConstraint:contactButtonHeight];
    [self.view addConstraint:contactButtonWidth];
    
    NSLayoutConstraint *otherButtonRight   = [NSLayoutConstraint constraintWithItem:_otherLoginButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-30];
    NSLayoutConstraint *otherButtonBottom = [NSLayoutConstraint constraintWithItem:_otherLoginButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
    NSLayoutConstraint *otherButtonHeight = [NSLayoutConstraint constraintWithItem:_otherLoginButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:0 attribute:0 multiplier:1 constant:30];
    [self.view addConstraint:otherButtonRight];
    [self.view addConstraint:otherButtonBottom];
    [self.view addConstraint:otherButtonHeight];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_passwordTextField == textField) {
        [_usernameTextField becomeFirstResponder];
    } else {
        [_passwordTextField becomeFirstResponder];
    }
    return YES;
}

- (UIImageView *)p_createImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    // init property
    return imageView;
}

- (UITextField *)p_createTextFieldWithPlaceholder:(NSString *)placeHoderTitle color:(UIColor *)bgColor {
    UITextField *textField = [[UITextField alloc] init];
//    textField.backgroundColor = bgColor;
    textField.placeholder = placeHoderTitle;
    // init property
    return textField;
}

- (UIButton *)p_createButtonWithTitle:(NSString *)title color:(UIColor *)bgColor radius:(CGFloat)radius {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = bgColor;
    button.layer.cornerRadius = radius;
    // init property
    return button;
}

- (void)p_login:(UIButton *)sender {
    ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = [[SDHomeTabBarViewController alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
