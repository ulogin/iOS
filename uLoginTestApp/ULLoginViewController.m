//
//  ULLoginViewController.m
//  uLoginTestApp
//
//  Created by Alexey Talkan on 10.04.13.
//  Copyright (c) 2013 Alexey Talkan. All rights reserved.
//

#import "ULLoginViewController.h"
#import "ULAccountViewController.h"

@interface ULLoginViewController ()

@end

@implementation ULLoginViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:kuLoginLoginSuccess object:nil];
	
	UIScrollView* scrollView = (UIScrollView*)self.view;
	scrollView.contentSize = ((UIView*)[scrollView.subviews objectAtIndex:0]).frame.size;

	NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:buttonPoweredBy.titleLabel.text];
	[attrString addAttribute:NSFontAttributeName
					   value:[UIFont systemFontOfSize:12]
					   range:(NSRange){0,[attrString length]}];
	[attrString addAttribute:NSForegroundColorAttributeName
					   value:[UIColor grayColor]
					   range:(NSRange){0,[attrString length]}];
	[attrString addAttribute:NSUnderlineStyleAttributeName
					   value:[NSNumber numberWithInt:1]
					   range:(NSRange){11,[attrString length]-11}];
	[buttonPoweredBy setAttributedTitle:attrString forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
}

-(IBAction)labelPoweredClick:(id)sender{
	NSURL* url = [NSURL URLWithString:@"http://ulogin.ru/"];
	[[UIApplication sharedApplication] openURL:url];
}


#pragma mark - Login methods

-(IBAction)loginByULogin{
	ULDefaultConfigurator *config = [ULDefaultConfigurator new];
	[[uLogin sharedInstance] startLogin:config viewController:self];
}

-(IBAction)loginByULoginVK{
	ULMyConfigurator *config = [[ULMyConfigurator alloc] initWithSingleProvider:[[ULProviderVkontakte alloc] init]];
	[[uLogin sharedInstance] startLogin:config viewController:self];
}

-(IBAction)loginByULoginOK{
	ULMyConfigurator *config = [[ULMyConfigurator alloc] initWithSingleProvider:[[ULProviderOdnoklassniki alloc] init]];
	[[uLogin sharedInstance] startLogin:config viewController:self];
}

-(IBAction)loginByULoginMail{
	ULMyConfigurator *config = [[ULMyConfigurator alloc] initWithSingleProvider:[[ULProviderMailRU alloc] init]];
	[[uLogin sharedInstance] startLogin:config viewController:self];
}

-(IBAction)loginByULoginFB{
	ULMyConfigurator *config = [[ULMyConfigurator alloc] initWithSingleProvider:[[ULProviderFacebook alloc] init]];
	[[uLogin sharedInstance] startLogin:config viewController:self];
}

-(IBAction)loginByULoginTW{
	ULMyConfigurator *config = [[ULMyConfigurator alloc] initWithSingleProvider:[[ULProviderTwitter alloc] init]];
	[[uLogin sharedInstance] startLogin:config viewController:self];
}


#pragma mark - Login success / fail

-(void)loginSuccess:(NSNotification*)notification{
	NSLog(@"Notification: %@", notification.userInfo);
	
	dispatch_async(dispatch_get_main_queue(), ^{
		ULAccountViewController *accountViewController = [[[ULAccountViewController alloc] initWithNibName:@"ULAccountViewController" bundle:nil] initWithProfile:[notification.userInfo objectForKey:@"profile"] byProvider:[notification.userInfo objectForKey:@"provider"]];
		[self.navigationController pushViewController:accountViewController animated:YES];
	});
}

@end


@implementation ULMyConfigurator

-(id)initWithSingleProvider:(id<ULProvider>)thisProvider{
	self = [super init];
	if(self){
		provider = thisProvider;
	}
	return self;
}

-(NSArray *)providers{
	return [NSArray arrayWithObject:provider];
}

@end