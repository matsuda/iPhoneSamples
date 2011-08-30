//
//  TestUUIDViewController.m
//  TestUUID
//
//  Created by Kosuke Matsuda on 11/08/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestUUIDViewController.h"

#import "SFHFKeychainUtils.h"

// アプリケーションタイトル
#define zTestUUIDApplicationName                @"TestUUID"

static NSString * const UIApplication_UIID_Key = @"uniqueInstallationIdentifier";


@interface TestUUIDViewController (PrivateMethods)
- (NSString *)loadUUIDFromKeychain;
- (NSString *)generateUUIDForKeychain;
- (void)saveUUIDToKeychain:(NSString *)uuid;
- (void)clearUUIDInKeychain;
@end


@implementation TestUUIDViewController

@synthesize uuid = uuid_, loadButton = loadButton_, createButton = createButton_, saveButton = saveButton_, clearButton = clearButton_;

- (void)dealloc
{
	[uuid_ release];
	[loadButton_ release];
	[createButton_ release];
	[saveButton_ release];
	[clearButton_ release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Private methods

- (NSString *)loadUUIDFromKeychain
{
    NSError *error;
	
    NSString *uuid = [SFHFKeychainUtils getPasswordForUsername:UIApplication_UIID_Key andServiceName:zTestUUIDApplicationName error:&error];
	
    return uuid;
}

- (NSString *)generateUUIDForKeychain
{
	// Create universally unique identifier (object)
	CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
	
	// Get the string representation of CFUUID object.
	// NSString *uuidStr = [(NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObject) autorelease];
	CFStringRef uuidString = CFUUIDCreateString( kCFAllocatorDefault, uuidObject );
	NSString *uuidStr = (NSString *)CFStringCreateCopy( NULL, uuidString);
	
	// If needed, here is how to get a representation in bytes, returned as a structure
	// typedef struct {
	//   UInt8 byte0;
	//   UInt8 byte1;
	//   ...
	//   UInt8 byte15;
	// } CFUUIDBytes;
	// CFUUIDBytes bytes = CFUUIDGetUUIDBytes(uuidObject);
	
	CFRelease(uuidObject);
	CFRelease(uuidString);

	return uuidStr;
}

- (void)saveUUIDToKeychain:(NSString *)uuid
{
    NSError *error;
	
    [SFHFKeychainUtils storeUsername:UIApplication_UIID_Key andPassword:uuid forServiceName:zTestUUIDApplicationName updateExisting:YES error:&error];
}

- (void)clearUUIDInKeychain
{
    NSError *error;
	
	[SFHFKeychainUtils deleteItemForUsername:UIApplication_UIID_Key andServiceName:zTestUUIDApplicationName error:&error];
}

#pragma mark - IBAction methods

- (IBAction)createUUID:(id)sender
{
	self.uuid.text = [self generateUUIDForKeychain];
}

- (IBAction)loadUUID:(id)sender
{
	self.uuid.text = [self loadUUIDFromKeychain];
}

- (IBAction)saveUUID:(id)sender
{
	NSString *uuid = self.uuid.text;
	if (uuid && ![uuid isEqualToString:@""]) {
		[self saveUUIDToKeychain:uuid];
		self.uuid.text = [self loadUUIDFromKeychain];
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UUID" message:@"UUID is empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

- (IBAction)clearUUID:(id)sender
{
	[self clearUUIDInKeychain];
	self.uuid.text = nil;
}

@end
