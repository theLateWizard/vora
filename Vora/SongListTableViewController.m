//
//  SongListTableViewController.m
//  Vora
//
//  Created by Erik Griffin on 12/19/14.
//  Copyright (c) 2014 Erik Griffin. All rights reserved.
//

#import "SongListTableViewController.h"
#import "SCUI.h"

@interface SongListTableViewController ()

@end

@implementation SongListTableViewController


-(NSMutableArray *) songs {
    
    if (!_songs) {
        NSLog(@"Hello there! Greetings from an uninstantiated song array!");
        _songs = [[NSMutableArray alloc]init];
    }
    return _songs;
}


/*
-(AVAudioPlayer *) player {
    if (!_player) {
        NSLog(@"Hello from unallocated _player!");
        _player = [[AVAudioPlayer alloc]init];
    }
    return _player;
}
 */

-(void)viewWillAppear:(BOOL)animated {
    
    // NSLog(@"I SHALL APPEAR!");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.songs count];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCAccount *account = [SCSoundCloud account];
    
    NSDictionary *song = [self.songs objectAtIndex:indexPath.row];
    NSString *streamURL = [song objectForKey:@"stream_url"];
    
    [SCRequest performMethod:SCRequestMethodGET
                  onResource:[NSURL URLWithString:streamURL]
             usingParameters:nil
                 withAccount:account
      sendingProgressHandler:nil
             responseHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                 
                 NSError *playerError;
                 
                 self.player = [[AVAudioPlayer alloc]initWithData:data error:&playerError];
                 
                 [self.player prepareToPlay];
                 [self.player play];
                 
             }];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:CellIdentifier];
    }
    
    
    NSDictionary *song = [self.songs objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [song objectForKey:@"title"];
    
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
