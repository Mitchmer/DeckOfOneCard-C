//
//  MMCard.m
//  DeckOfOneCard-C
//
//  Created by Mitch Merrell on 8/20/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

#import "MMCard.h"

static NSString *suitKey = @"suit";
static NSString *imageKey = @"image";

@implementation MMCard

- (instancetype) initWithCardSuit:(NSString *)suit image:(NSString *)image
{
    self = [super init];
    if (self != nil)
    {
        _suit = suit;
        _image = image;
    }
    
    return self;
}

@end

@implementation MMCard (JSONConvertable)

- (instancetype) initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *suit = dictionary[suitKey];
    NSString *image = dictionary[imageKey];
    
    return [self initWithCardSuit:suit image:image];
}

@end
