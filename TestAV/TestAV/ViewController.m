//
//  ViewController.m
//  TestAV
//
//  Created by Kosuke Matsuda on 2012/12/26.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "ShutterView.h"

@interface ViewController () <ShutterViewDelegate> {
    AVCaptureStillImageOutput *_stillImageOutput;
}
@property (strong, nonatomic) IBOutlet ShutterView *shutterView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupShutterView];
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.shutterView.frame));
    [self setupAVCapture:rect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupShutterView
{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ShutterView class]) owner:self options:nil];
    CGRect shutterViewFrame = self.shutterView.frame;
    shutterViewFrame.origin.y = CGRectGetHeight(self.view.frame) - CGRectGetHeight(shutterViewFrame);
    self.shutterView.frame = shutterViewFrame;
    [self.view addSubview:self.shutterView];
    self.shutterView.delegate = self;
}

- (void)setupAVCapture:(CGRect)frame
{
    // AVCaptureSession
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    if ([session canSetSessionPreset:AVCaptureSessionPresetMedium]) {
        session.sessionPreset = AVCaptureSessionPresetMedium;
    } else {
        // error
    }

    // AVCaptureDevice & AVCaptureDeviceInput
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (!input) {
        // error
    }
    if ([session canAddInput:input]) {
        [session addInput:input];
    } else {
        // error
    }

    // AVCaptureStillImageOutput
    AVCaptureStillImageOutput *stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    if ([session canAddOutput:stillImageOutput]) {
        [session addOutput:stillImageOutput];
    } else {
        // error
    }
    _stillImageOutput = stillImageOutput;

    // AVCaptureVideoPreviewLayer
    UIView *previewView = [[UIView alloc] initWithFrame:frame];
    // [previewView.layer setMasksToBounds:YES];
    [self.view addSubview:previewView];

    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    captureVideoPreviewLayer.frame = previewView.bounds;
    captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [previewView.layer addSublayer:captureVideoPreviewLayer];

    [session startRunning];
}

- (void)didPushShutterAtShutterView:(ShutterView *)shutterView
{
    AVCaptureConnection *stillImageConnection = [_stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    AVCaptureVideoOrientation avcaptureOrientation = AVCaptureVideoOrientationPortrait;
    [stillImageConnection setVideoOrientation:avcaptureOrientation];
    [stillImageConnection setVideoScaleAndCropFactor:1.f];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [_stillImageOutput setOutputSettings:outputSettings];
    [_stillImageOutput captureStillImageAsynchronouslyFromConnection:stillImageConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error){
        if (error) {
            // error
        } else {
            NSData *jpegData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            [self displayPhotoOnMainQueue:jpegData];
        }
    }];
}

- (void)displayPhotoOnMainQueue:(NSData *)data
{
    UIImage *image = [UIImage imageWithData:data];
    if (image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.shutterView.frame));
            [self.view addSubview:imageView];
            [self animationWithScalingImage:imageView];
        });
    }
}

- (void)animationWithScalingImage:(UIImageView *)imageView
{
    UIImageView *shutterViewImageView = self.shutterView.imageView;
    CGRect shutterViewRect = [self.view convertRect:shutterViewImageView.frame fromView:self.shutterView];

    CGFloat scaleX = CGRectGetWidth(shutterViewRect) / CGRectGetWidth(imageView.frame);
    CGFloat scaleY = CGRectGetHeight(shutterViewRect) / CGRectGetHeight(imageView.frame);
    CGFloat translateX = CGRectGetMidX(shutterViewRect) - CGRectGetMidX(imageView.frame);
    CGFloat translateY = CGRectGetMidY(shutterViewRect) - CGRectGetMidY(imageView.frame);

    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    anim.duration = 0.2;
    anim.values = @[
        [NSValue valueWithCATransform3D:CATransform3DIdentity],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(scaleX, scaleY, 1.0)]
    ];
    anim.keyTimes = @[[NSNumber numberWithFloat:0.f], [NSNumber numberWithFloat:0.7f], [NSNumber numberWithFloat:1.f]];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [imageView.layer addAnimation:anim forKey:@"transformScale"];

    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"position"];
    anim2.delegate = self;
    anim2.toValue = [NSValue valueWithCGPoint:shutterViewRect.origin];
    anim2.duration = 0.2;
    anim2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    anim2.removedOnCompletion = NO;
    anim2.fillMode = kCAFillModeForwards;
    [imageView.layer addAnimation:anim2 forKey:@"position"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    UIImageView *imageView;
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[UIImageView class]]) {
            imageView = (UIImageView *)v;
            break;
        }
    }
    if ([anim isEqual:[imageView.layer animationForKey:@"position"]]) {
        [self.shutterView setImage:imageView.image];
        [imageView removeFromSuperview];
    }
}

@end
