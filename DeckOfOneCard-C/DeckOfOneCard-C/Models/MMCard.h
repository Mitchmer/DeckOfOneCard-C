//
//  MMCard.h
//  DeckOfOneCard-C
//
//  Created by Mitch Merrell on 8/20/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMCard : NSObject

@property (nonatomic, readonly) NSString *suit;
@property (nonatomic, readonly) NSString *image;

- (instancetype) initWithCardSuit:(NSString *)suit image:(NSString *)image;

@end

@interface MMCard (JSONConvertable)

- (instancetype) initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
