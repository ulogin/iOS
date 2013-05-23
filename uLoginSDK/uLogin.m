//
//  uLogin.m
//
//  Created by Alexey Talkan on 10.04.13.
//  Copyright (c) 2013 Alexey Talkan. All rights reserved.
//

#import "uLogin.h"
#import "ULProvidersViewController.h"

@implementation uLogin

+(uLogin*)sharedInstance{
    static uLogin* _instance;
    static dispatch_once_t onceToken;
	
    dispatch_once(&onceToken, ^{
        _instance = [[uLogin alloc] init];
    });
	
    return _instance;
}

-(void)startLogin:(ULDefaultConfigurator*)configurator viewController:(UIViewController*)viewController{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginComplete:) name:[kuLoginLoginSuccess stringByAppendingString:@".internal"] object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFail:) name:[kuLoginLoginFail stringByAppendingString:@".internal"] object:nil];
	
	rootViewController = viewController;
	
	if([configurator providers].count == 0){
		[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Не задан провайдер", nil) message:NSLocalizedString(@"В экземпляре класса ULDefaultConfigurator должен быть определён как минимум один провайдер", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
	}
	else if([configurator providers].count == 1){
		ULWebViewController *webViewController = [[[ULWebViewController alloc] initWithNibName:@"ULWebViewController" bundle:nil] initWithProvider:((id<ULProvider>)[[configurator providers] objectAtIndex:0]) andConfigurator:configurator];
		[viewController.navigationController pushViewController:webViewController animated:YES];
	}
	else{
		ULProvidersViewController *providersViewController = [[ULProvidersViewController alloc] initWithNibName:@"ULProvidersViewController" bundle:nil];
		providersViewController.config = configurator;
		[viewController.navigationController pushViewController:providersViewController animated:YES];
	}
}

-(void)loginComplete:(NSNotification*)notification{
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	[rootViewController.navigationController popToViewController:rootViewController animated:NO];
	[[NSNotificationCenter defaultCenter] postNotificationName:kuLoginLoginSuccess object:self userInfo:notification.userInfo];
}

-(void)loginFail:(NSNotification*)notification{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	// Заготовка на кастомный сценарий в будущем
}

@end
