//
//  TrailerViewController.m
//  Flixer
//
//  Created by gilemos on 6/27/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "TrailerViewController.h"
#import <WebKit/WebKit.h>

@interface TrailerViewController ()

@property NSString *urlString;

@property (weak, nonatomic) IBOutlet WKWebView *webkit;

@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Convert the url String to a NSURL object.
    NSURL *url = [NSURL URLWithString:self.trailer];

    
    //Print to see if it works
    
    NSURL *testURL = [NSURL URLWithString:@"https://www.youtube.com/watch?v=xbs7FT7dXYc"];
    
    // Place the URL in a URL Request.
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    
    // Load Request into WebView.
    [self.webkit loadRequest:request];
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
