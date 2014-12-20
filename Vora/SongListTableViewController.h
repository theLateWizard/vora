//
//  SongListTableViewController.h
//  Vora
//
//  Created by Erik Griffin on 12/19/14.
//  Copyright (c) 2014 Erik Griffin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface SongListTableViewController : UITableViewController


@property (nonatomic) NSMutableArray *songs;

@property (nonatomic) AVAudioPlayer *player;







@end
