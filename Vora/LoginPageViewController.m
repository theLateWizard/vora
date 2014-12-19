//
//  LoginPageViewController.m
//  Vora
//
//  Created by Erik Griffin on 12/19/14.
//  Copyright (c) 2014 Erik Griffin. All rights reserved.
//

#import "LoginPageViewController.h"
#import "SCUI.h"
#import "SongListTableViewController.h"



@interface LoginPageViewController ()

@end

@implementation LoginPageViewController

- (IBAction)getSongs:(UIButton *)sender {
    
    NSLog(@"Checkpoint B!");
    
    SCAccount *account = [SCSoundCloud account];
    
    if (!account) {
        // Initialize alert
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Not Logged In"
                                                       message:@"You must login first"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    SCRequestResponseHandler handler = ^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSError *jsonError = nil;
        NSJSONSerialization *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        
        if (!jsonError && [jsonResponse isKindOfClass:[NSArray class]]) {
            
            NSLog(@"Checkpoint C!");
            
            SongListTableViewController *songListVC = [[SongListTableViewController alloc]initWithNibName:@"SongListTableViewController"
                                                                                                 bundle:nil];
            
            songListVC.songs = (NSMutableArray *)jsonResponse;
            
            NSLog(@"Checkpoint D!");
            
            //!! ** !! This is where you left off.  Could not load SongListTableViewController
            
            [self presentViewController:songListVC animated:YES completion:nil];
            
            NSLog(@"Checkpoint E!");
            
        }
        
    };
    
    NSString *resourceURL = @"https://api.soundcloud.com/me/tracks.json";
    [SCRequest performMethod:SCRequestMethodGET
                  onResource:[NSURL URLWithString:resourceURL]
             usingParameters:nil
                 withAccount:account
      sendingProgressHandler:nil
             responseHandler:handler];
}

- (IBAction)login:(UIButton *)sender {
    
    SCLoginViewControllerCompletionHandler handler = ^(NSError *error) {
        if (SC_CANCELED(error)) {
            NSLog(@"Canceled!");
        }
        else if (error) {
            NSLog(@"Error: %@",[error localizedDescription]);
        }
        else {
            NSLog(@"Done!");
        }
    };
    
    [SCSoundCloud requestAccessWithPreparedAuthorizationURLHandler:^(NSURL *preparedURL) {
        
        SCLoginViewController *loginViewController;
        loginViewController = [SCLoginViewController loginViewControllerWithPreparedURL:preparedURL
                                                                      completionHandler:handler];
        
        [self presentViewController:loginViewController animated:YES completion:nil];
        
        
    }];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
