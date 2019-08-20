//
//  MMCardController.h
//  DeckOfOneCard-C
//
//  Created by Mitch Merrell on 8/20/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCard.h"
#import <UIKit/UIKit.h>

@interface MMCardController : NSObject

+ (instancetype) shared;

- (void) drawNewCard:(NSInteger)count completion:( void(^) (NSArray<MMCard *> *cards))completion;
- (void) fetchImage:(MMCard *)card completion:(void (^) (UIImage *image))completion;

@end
