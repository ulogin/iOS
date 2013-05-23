//
//  ULAccountViewController.h
//  uLoginTestApp
//
//  Created by Alexey Talkan on 15.04.13.
//  Copyright (c) 2013 Alexey Talkan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "uLogin.h"

@interface ULAccountViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	IBOutlet UIImageView *imagePhoto;
	IBOutlet UILabel *labelName;
	IBOutlet UILabel *labelVia;
	IBOutlet UITableView *table;
	IBOutlet UIButton *buttonBack;
	
	ULUserProfileData *profile;
	id<ULProvider> provider;
}

-(id)initWithProfile:(ULUserProfileData*)profile byProvider:(id<ULProvider>)provider;

@end
