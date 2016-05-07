//
//  ViewController.m
//  OC_JS_Interaction
//
//  Created by 李长青 on 16/5/7.
//  Copyright © 2016年 LiChangqing. All rights reserved.
//

#import "ViewController.h"


#import <JavaScriptCore/JSContext.h>
#import <JavaScriptCore/JSValue.h>
#import <JavaScriptCore/JSManagedValue.h>
#import <JavaScriptCore/JSVirtualMachine.h>
#import <JavaScriptCore/JSExport.h>


@interface ViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 22, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 22)];
    
    _webView.delegate = self;
    
    [self.view addSubview:_webView];
    
    
    NSString *urlString = @"http://www.baidu.com";
    NSURL *httpUrl = [NSURL URLWithString:urlString];
    NSURLRequest *httpRequest = [NSURLRequest requestWithURL:httpUrl];
    [_webView loadRequest:httpRequest];
    
    
    
}

#pragma mark-
#pragma mark----UIWebViewDelegate----
//网页加载之前调用此方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}
//网页已经开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
//网页已经加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
//    // OC调用JS  弹出alert
//    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    NSString *alertJS = @"alert('test js OC')";
//    [context evaluateScript:alertJS];
    
    
    
    // JS 调用 OC
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"test1"] = ^(){
        
        NSArray *args = [JSContext currentArguments];
        for (id obj in args) {
            NSLog(@"%@",obj);
        }
    };
    
    
    NSString *jsFuncStr = @"test1('参数1')";
    [context evaluateScript:jsFuncStr];
    
    NSString *jsFunctStr1=@"test1('参数a','参数b')";
    [context evaluateScript:jsFunctStr1];
    
}

//网页加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
