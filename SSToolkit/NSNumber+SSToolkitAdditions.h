//
//  NSNumber+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Alexander Zats on 5/22/12.
//  Copyright (c) 2012 Sam Soffes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (SSToolkitAdditions)

///--------------
/// @name Date from timestamp
///--------------

/**
 Creates an instance of `NSDate` using current number as timestamp.
 @return NSDate with current number as unix timestamp or `nil` if current number contains 0.
 */
- (NSDate *)dateValue;

///--------------
/// @name Localized plurals
///--------------

- (NSString *)pluralWithForms:(NSString *)pluralForms;

/**
 With given list of plural forms returns a correct one to use with specified number. So far supports only integers.
 Following code:
 
 <pre><code>NSLocale *enUSLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_us"];
 NSNumber *tweetsCount;
 for (int i = 0; i < 3; ++i) {
 tweetsCount = [NSNumber numberWithInteger:i];
 NSString *pluralForm = [tweetsCount pluralFormWithStringForms:@"tweet,tweets" locale:enUSLocale];
 NSLog(@"%@ %@", tweetsCount, pluralForm);
 }</code></pre>
 
 produces output:
 
 <pre><code>0 tweets
 1 tweet
 2 tweet</code></pre>
 
 To create a truly localized experience, use `pluralFormWithStringForms:` method in conjunction with `Localizable.strings` files. It will automatically choose current system language:
 
 Excerpt from `Localizable.strings` for English locale: 
 <pre><code>"pluralMinuteForms" = "minute,minutes";</code></pre>
 
 Excerpt from `Localizable.strings` for Hebrew locale: 
 <pre><code>"pluralMinuteForms" = "דקה,דקותֿ";</code></pre>
 
 Excerpt from `Localizable.strings` for Russian locale: 
 <pre><code>"pluralMinuteForms" = "минута,минуты,минут";</code></pre>
 
 <pre><code>for (int i = 0; i < 60; ++i) {
	 NSNumber *minutes = [NSNumber numberWithInteger:i];
	 NSString *pluralForm = [minutes pluralFormWithStringForms:NSLocalizedString(@"pluralMinuteForms", @"Correct form of the world `minute` will be chosen automatically")];
	 NSLog(@"%@ %@", minutes, pluralForm);
 }</code></pre> 
 
 @param pluralForms comma-separated list of plural forms, e.g. `@"minute,minutes"`
 @param language Canonicalized IETF BCP 47 language identifier, e.g. `en` for English (not `en_us`).
 
 @return One of passed stringForms that correspond to the integer representation of the number.
 */
- (NSString *)pluralWithForms:(NSString *)pluralForms language:(NSString *)language;

@end
