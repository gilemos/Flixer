//
//  MoviesViewController.m
//  Flixer
//
//  Created by gilemos on 6/26/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCellTableViewCell.h"

//This one we imported with the library we got from the coconut pod thing
#import "UIImageView+AFNetworking.h"

//Importing stuff for the next screen to appear
#import "DetailsViewController.h"


@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *movies;

@property (weak, nonatomic) IBOutlet UITableView *moviesTableView;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.moviesTableView.dataSource = self;
    self.moviesTableView.delegate = self;
    [self fetchMovies];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    
    [self.moviesTableView insertSubview:self.refreshControl atIndex:0];
    
    
}

-(void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@", dataDictionary);
            
            self.movies = dataDictionary[@"results"];
            
            for(NSDictionary *movie in self.movies) {
                NSLog(@"%@", movie[@"title"]);
                
            }
            
            [self.moviesTableView reloadData];
            // TODO: Get the array of movies
            // TODO: Store the movies in a property to use elsewhere
            // TODO: Reload your table view data
        }
        
        [self.refreshControl endRefreshing];
    }];
    [task resume];
}
    

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellTemplate"];
    
    NSDictionary *movieNames = self.movies[indexPath.row];
    
    cell.titleLabel.text = movieNames[@"title"];
    
    cell.descriptionLabel.text = movieNames[@"overview"];

    
    NSString *baseURL = @"https://image.tmdb.org/t/p/w500";
    
    NSString *endingURL = movieNames[@"poster_path"];
    
    NSString *completeURL = [baseURL stringByAppendingString:endingURL];
    
    //We need to change it into the format of an NSURL. It is just like the String, but it will
    //Check to see if it is a valid URL.
    NSURL *posterURL = [NSURL URLWithString:completeURL];
    
    [cell.movieImage setImageWithURL:posterURL];
    
    
    
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    MovieCellTableViewCell *tappedCell = sender;
    
    NSIndexPath *indexPath = [self.moviesTableView indexPathForCell:tappedCell];
    
    NSDictionary *curMovie = self.movies[indexPath.row];
    
    DetailsViewController *detailsViewController = [segue destinationViewController];
    
    detailsViewController.movie = curMovie;
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
