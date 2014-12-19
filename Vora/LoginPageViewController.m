//
//  LoginPageViewController.m
//  Vora
//
//  Created by Erik Griffin on 12/19/14.
//  Copyright (c) 2014 Erik Griffin. All rights reserved.
//

#import "LoginPageViewController.h"
#import "SCUI.h"


@interface LoginPageViewController ()

@end

@implementation LoginPageViewController


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
