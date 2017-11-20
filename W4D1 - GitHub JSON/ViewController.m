//
//  ViewController.m
//  W4D1 - GitHub JSON
//
//  Created by Murat Ekrem Kolcalar on 11/20/17.
//  Copyright © 2017 murtilicious. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"
#import "Repo.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <Repo*> *reposArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/brokeandfurious/repos"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        
        if (error) {
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            // Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        // If we reach this point, we have successfully retrieved the JSON from the API
        
        self.reposArray = [@[] mutableCopy];
        for (NSDictionary *repo in repos) {
//            NSString *repoName = repo[@"name"];
            Repo *newRepo = [[Repo alloc] initWithDictionary:repo];
            [self.reposArray addObject:newRepo];
            NSLog(@"%@", self.reposArray);
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
        }
    }];
    
    [dataTask resume];
    
}

#pragma mark - UITableView DataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.reposArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Repo *currentRepo = self.reposArray[indexPath.item];
    if (cell == nil) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.gitLabel.text = currentRepo.name;
//    cell.gitLabel.text = self.reposArray[indexPath.item]; - Before Repo Class
    return cell;
}

@end
