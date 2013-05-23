//
//  ULErrorViewController.h
//  uLoginTestApp
//
//  Created by Alexey Talkan on 15.04.13.
//  Copyright (c) 2013 Alexey Talkan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "uLogin.h"

@interface ULErrorViewController : UIViewController {
	IBOutlet UIImageView *imageProvider;
	IBOutlet UILabel *labelDescription;
	
	NSString *errCode;
	id<ULProvider> provider;
}

-(id)initWithErrorCode:(NSString*)thisErrCode andProvider:(id<ULProvider>)thisProvider;

@end
