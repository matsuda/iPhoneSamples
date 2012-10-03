//
//  ViewController.m
//  TestAirplay
//
//  Created by matsuda on 2012/10/03.
//  Copyright (c) 2012年 Appirits. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()
@property (nonatomic, retain) MPMoviePlayerController *player;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupMoviePlayer];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _player = nil;
}

- (void)dealloc
{
    APP_RELEASE_SAFELY(_player);
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupMoviePlayer
{
    APPLog;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sample_movie_1024k" ofType:@"mp4"];
    NSLog(@"path >>>>>>>>>>>>>>>>> %@", filePath);
    NSURL *url = [NSURL fileURLWithPath:filePath];

//    NSString *filePath = @"";
//    NSURL *url = [NSURL URLWithString:filePath];

    MPMoviePlayerController *player = [[[MPMoviePlayerController alloc] initWithContentURL:url] autorelease];
    player.view.frame = CGRectMake((320 - 300) / 2, (480 - 200) / 2, 300, 200);
    [player setContentURL:url];
    [player prepareToPlay];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerLoadStateDidChange:) name:MPMoviePlayerLoadStateDidChangeNotification object:player];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    [self.view addSubview:player.view];
    self.player = player;
}

- (void)moviePlayerLoadStateDidChange:(NSNotification *)notification
{
    APPLog;
    MPMoviePlayerController *player = [notification object];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:player];
    [player play];
}

- (void)moviePlayerPlaybackDidFinish:(NSNotification *)notification
{
    APPLog;
    MPMoviePlayerController *player = [notification object];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    [player stop];
    [player.view removeFromSuperview];
    [player release], player = nil;
}

@end
