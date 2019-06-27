//
//  DetailsViewController.m
//  Flixer
//
//  Created by gilemos on 6/26/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bigImage;
@property (weak, nonatomic) IBOutlet UIImageView *smallImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *baseURL = @"https://image.tmdb.org/t/p/w500";
    
    NSString *endingURLSmall = self.movie[@"poster_path"];
    
    NSString *completeURLSmall = [baseURL stringByAppendingString:endingURLSmall];
    
    NSURL *posterURLSmall = [NSURL URLWithString:completeURLSmall];
    
    [self.smallImage setImageWithURL:posterURLSmall];
    
    
    
    NSString *endingURLBig = self.movie[@"backdrop_path"];
    
    NSString *completeURLBig = [baseURL stringByAppendingString:endingURLBig];

    NSURL *posterURLBig = [NSURL URLWithString:completeURLBig];
    
    [self.bigImage setImageWithURL: posterURLBig];
    
    self.movieTitleLabel.text = self.movie[@"title"];
    
    self.synopsisLabel.text = self.movie[@"overview"];
    
    [self.movieTitleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
    
                                           
    
    // Do any additional setup after loading the view.
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
