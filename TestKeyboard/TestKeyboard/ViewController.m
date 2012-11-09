//
//  ViewController.m
//  TestKeyboard
//
//  Created by Kosuke Matsuda on 2012/11/03.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

/*
 http://blog.carbonfive.com/2012/03/12/customizing-the-ios-keyboard/
 */
#import "ViewController.h"

#define APPLog NSLog(@"%s(%p) : %d", __PRETTY_FUNCTION__, self, __LINE__)

@interface ViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak ,nonatomic) UIView *keyboard;
@property (assign, nonatomic) CGRect keyboardOriginalFrame;
@end

@implementation ViewController {
    BOOL _isPanning;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupAccessoryView];
    // [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    APPLog;
    self.keyboard.hidden = NO;
    // determine what portion of the view will be hidden by the keyboard
    CGRect keyboardEndFrameInScreenCoordinates;
    [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrameInScreenCoordinates];
    NSLog(@"keyboardEndFrameInScreenCoordinates >>> %@", NSStringFromCGRect(keyboardEndFrameInScreenCoordinates));
    CGRect keyboardEndFrameInWindowCoordinates = [self.view.window convertRect:keyboardEndFrameInScreenCoordinates fromWindow:nil];
    NSLog(@"keyboardEndFrameInWindowCoordinates >>> %@", NSStringFromCGRect(keyboardEndFrameInWindowCoordinates));
    CGRect keyboardEndFrameInViewCoordinates = [self.view convertRect:keyboardEndFrameInWindowCoordinates fromView:nil];
    NSLog(@"keyboardEndFrameInViewCoordinates >>> %@", NSStringFromCGRect(keyboardEndFrameInViewCoordinates));
    CGRect windowFrameInViewCoords = [self.view convertRect:self.view.window.frame fromView:nil];
    NSLog(@"windowFrameInViewCoords >>> %@", NSStringFromCGRect(windowFrameInViewCoords));

    // build an inset to add padding to the content view equal to the height of the portion of the view hidden by the keyboard
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, CGRectGetHeight(keyboardEndFrameInViewCoordinates), 0);

    // CGFloat heightBelowViewInWindow = windowFrameInViewCoords.origin.y + windowFrameInViewCoords.size.height - (self.view.frame.origin.y + self.view.frame.size.height);
    // NSLog(@"heightBelowViewInWindow >>> %f", heightBelowViewInWindow);
    // CGFloat heightCoveredByKeyboard = keyboardEndFrameInViewCoordinates.size.height - heightBelowViewInWindow;
    // NSLog(@"heightCoveredByKeyboard >>> %f", heightCoveredByKeyboard);
    // build an inset to add padding to the content view equal to the height of the portion of the view hidden by the keyboard
    // UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, heightCoveredByKeyboard, 0);
    [self setInsets:insets givenUserInfo:notification.userInfo];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    APPLog;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    APPLog;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    APPLog;
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self setInsets:insets givenUserInfo:notification.userInfo];
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    APPLog;
    self.keyboard.hidden = NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isEqual:self.textView]) {
        return YES;
    }
    return NO;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:self.view];
    NSLog(@"location >>>>> %@", NSStringFromCGPoint(location));
    CGPoint translation = [recognizer translationInView:self.view];
    NSLog(@"translation >>>>> %@", NSStringFromCGPoint(translation));
    CGPoint velocity = [recognizer velocityInView:self.view];
    NSLog(@"velocity >>>>> %@", NSStringFromCGPoint(velocity));

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        UIView *accessory = self.textView.inputAccessoryView;
        self.keyboard = accessory.superview;
        self.keyboardOriginalFrame = accessory.superview.frame;
    }

    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGRect windowFrameInViewCoords = [self.view convertRect:self.view.window.frame fromView:nil];
        NSLog(@"windowFrameInViewCoords >>> %@", NSStringFromCGRect(windowFrameInViewCoords));
        CGRect aFrame = self.keyboard.frame;
        if ( location.y - CGRectGetMinY(windowFrameInViewCoords) > CGRectGetMinY(aFrame) || CGRectGetMinY(aFrame) != CGRectGetMinY(self.keyboardOriginalFrame) ) {
            _isPanning = YES;
            CGFloat y = aFrame.origin.y + translation.y;
            y = MAX(y, CGRectGetMinY(self.keyboardOriginalFrame));
            y = MIN(y, CGRectGetMaxY(self.keyboardOriginalFrame));
            aFrame.origin.y = y;
            self.keyboard.frame = aFrame;
        }
    }

    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        if (_isPanning) {
            if (velocity.y >= 0) {
                [self animateKeyboardOffscreen];
            } else {
                [self animateKeyboardReturnToOriginalPosition];
            }
        }
        _isPanning = NO;
    }

    [recognizer setTranslation:CGPointZero inView:self.view];
}

- (void)animateKeyboardOffscreen {
    [UIView animateWithDuration:0.18
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect newFrame = self.keyboard.frame;
                         newFrame.origin.y = CGRectGetMaxY(self.keyboardOriginalFrame);
                         self.keyboard.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         self.keyboard.hidden = YES;
                         [self.textView resignFirstResponder];
                     }];
}

- (void)animateKeyboardReturnToOriginalPosition {
    [UIView animateWithDuration:0.18
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect newFrame = self.keyboard.frame;
                         newFrame.origin.y = CGRectGetMinY(self.keyboardOriginalFrame);
                         self.keyboard.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)setInsets:(UIEdgeInsets)insets givenUserInfo:(NSDictionary *)userInfo
{
    APPLog;
    NSLog(@"insets >>> %@", NSStringFromUIEdgeInsets(insets));
    // match the keyboard's animation
    double duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    UIViewAnimationOptions animationOptions = animationCurve;
    [UIView animateWithDuration:duration delay:0 options:animationOptions animations:^{
        self.textView.contentInset = insets;
        self.textView.scrollIndicatorInsets = insets;
    } completion:nil];
}

- (IBAction)closeKeyboard:(id)sender
{
    [self.textView resignFirstResponder];
}

- (void)setupAccessoryView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    view.backgroundColor = [UIColor grayColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(5, 5, 70, 40);
    [button setTitle:@"close" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    // UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    self.textView.inputAccessoryView = view;

    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    gesture.delegate = self;
    // [self.view addGestureRecognizer:gesture];
    [self.textView addGestureRecognizer:gesture];
}

@end
