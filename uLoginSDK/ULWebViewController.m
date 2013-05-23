//
//  ULViewController.m
//  uLoginTestApp
//
//  
//  Copyright (c) 2012 easy-pro.ru All rights reserved.
//

#import "ULWebViewController.h"
#import "ConnectionErrors.h"
#import "uLogin.h"
#import "ULErrorViewController.h"

@implementation ULWebViewController

-(ULWebViewController*)initWithProvider:(id<ULProvider>)thisProvider andConfigurator:(ULDefaultConfigurator*)thisConfig {
	currentProvider = thisProvider;
	config = thisConfig;

	return self;
}

-(void)viewWillAppear:(BOOL)animated{
	labelTitle.text = [currentProvider title];	
}
-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
	NSLog(@"URL: %@", [config apiURL:currentProvider]);
    [_webView loadRequest:[[NSURLRequest alloc] initWithURL:[config apiURL:currentProvider]]];
}

-(IBAction)backButtonClicked:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Web view delegate

-(void)webViewDidStartLoad:(UIWebView *)webView {
	activityIndicatorView.hidden = NO;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
	activityIndicatorView.hidden = YES;
	
	NSString *currentURL = webView.request.URL.absoluteString;
	NSLog(@"%@", currentURL);
	
    NSString* uLoginState = [webView stringByEvaluatingJavaScriptFromString:@"ulogin_state"];
    NSString* token = [webView stringByEvaluatingJavaScriptFromString:@"token"];
	NSLog(@"uLoginState: %@\nToken: %@", uLoginState, token);
	
	if([token length] > 0){
		[self loadProfileByToken:token];
	}
}


#pragma mark - Token methods

-(void)loadProfileByToken:(NSString*)token {
    NSString *urlAddress = [@"http://ulogin.ru/token.php?token=" stringByAppendingString:token];
	NSError* error = nil;
	NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlAddress] options:NSDataReadingUncached error:&error];

	if(error){
		[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Ошибка", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
		[self.navigationController popViewControllerAnimated:YES];
		return;
	}
	
	ULUserProfileData *profile = [[ULUserProfileData alloc] initWithData:data];
	if( [profile Error] == nil ) {
		[[NSNotificationCenter defaultCenter] postNotificationName:[kuLoginLoginSuccess stringByAppendingString:@".internal"] object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:profile, @"profile", currentProvider, @"provider", nil]];
	}
	else {
		ULErrorViewController *errorViewController = [[[ULErrorViewController alloc] initWithNibName:@"ULErrorViewController" bundle:nil] initWithErrorCode:[profile Error] andProvider:currentProvider];
		[self.navigationController pushViewController:errorViewController animated:YES];
		
		NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
		[navigationArray removeObjectAtIndex:([self.navigationController.viewControllers count]-2)];
		self.navigationController.viewControllers = navigationArray;
	}
}


@end
