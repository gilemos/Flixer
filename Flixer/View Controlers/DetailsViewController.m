//
//  DetailsViewController.m
//  Flixer
//
//  Created by gilemos on 6/26/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TrailerViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bigImage;
@property (weak, nonatomic) IBOutlet UIImageView *smallImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property NSString *finalTrailer;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *baseURL = @"https://image.tmdb.org/t/p/w500";
    
    NSString *endingURLSmall = self.movie[@"poster_path"];
    
    NSString *completeURLSmall = [baseURL stringByAppendingString:endingURLSmall];
    
    NSURL *posterURLSmall = [NSURL URLWithString:completeURLSmall];
    
    [self.smallImage setImageWithURL:posterURLSmall];
    [self.smallImage setUserInteractionEnabled:TRUE];
    
    
    
    NSString *endingURLBig = self.movie[@"backdrop_path"];
    
    NSString *completeURLBig = [baseURL stringByAppendingString:endingURLBig];

    NSURL *posterURLBig = [NSURL URLWithString:completeURLBig];
    
    [self.bigImage setImageWithURL: posterURLBig];
    
    self.movieTitleLabel.text = self.movie[@"title"];
    
    self.synopsisLabel.text = self.movie[@"overview"];
    
    [self.movieTitleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
    
    [self fetchTrailer];
    
                                           
    
    // Do any additional setup after loading the view.
}

-(void)fetchTrailer {
    
    NSString *beggining = @"https://api.themoviedb.org/3/movie/";
    
    NSString *key = [self.movie[@"id"] stringValue];
    
    NSString *ending = @"/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US";
    
    NSString *completeURLOne = [beggining stringByAppendingString:key];
    
    NSString *completeURLFinal = [completeURLOne stringByAppendingString:ending];
    
    NSURL *URLFinal = [NSURL URLWithString:completeURLFinal];
    
    NSURL *url = URLFinal;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //NSLog(@"got here");
        
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            
            //my code for bonus section 1 - Alert Controller
            
            //Creating an allert controller
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Error" message:@"Could not fetch the movies, sorry! Please check you internet connection" preferredStyle:(UIAlertControllerStyleAlert)];
            
            //Creating an action for the allert controller
            UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"TryAgain" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self fetchTrailer];
            }];
            
            //Connecting the action with the controller
            [alert addAction:tryAgainAction];
            
            //Presenting the controller
            [self presentViewController:alert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
            }];
            
            NSLog(@"Did not get there");
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *resultsData = dataDictionary[@"results"];
            
            NSDictionary *dicitonaryOfVideos = resultsData[0];
            
            NSString *videoKey = dicitonaryOfVideos[@"key"];
            
            //NSLog(@"got here");
            
            NSString *begginingTrailer = @"https://www.youtube.com/watch?v=";
            
            self.finalTrailer = [begginingTrailer stringByAppendingString:videoKey];
            
            NSLog(@"Hello");
        }
        
    }];
    [task resume];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    TrailerViewController *trailerViewController = [segue destinationViewController];
    
    trailerViewController.trailer = self.finalTrailer;
}

@end
