//
//  NSNumber+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Alexander Zats on 5/22/12.
//  Copyright (c) 2012 Sam Soffes. All rights reserved.
//

#import "NSNumber+SSToolkitAdditions.h"

#define kDefaultLocaleIdetifier @"en"

@interface NSNumber (SSToolkitAdditionsPrivate)

// Returns correct form of the plural for spcified integer
typedef NSUInteger(^PluralFormSelector)(NSInteger integer);

- (void)initializePluralForms;

@end

@implementation NSNumber (SSToolkitAdditions)

static NSMutableDictionary *PluralFormSolvers;

- (NSDate *)dateValue
{
	NSTimeInterval timestamp = [self doubleValue];
	if (!timestamp) {
		return nil;
	}
	return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

- (NSString *)pluralWithForms:(NSString *)pluralForms
{	
	return [NSLocale preferredLanguages].count > 0 ? [self pluralWithForms:pluralForms language:[[NSLocale preferredLanguages] objectAtIndex:0]] : nil;	
}

- (NSString *)pluralWithForms:(NSString *)pluralForms language:(NSString *)language
{	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[self initializePluralForms];
	});
	
	PluralFormSelector pluralSolver = [PluralFormSolvers valueForKey:language];
	if (!pluralSolver) {
		pluralSolver = [PluralFormSolvers valueForKey:kDefaultLocaleIdetifier];
		if (!pluralSolver) {
			return nil;
		}
	}
	
	NSUInteger index = pluralSolver( [self integerValue]);
	NSArray *components = [pluralForms componentsSeparatedByString:@","];
	if (components.count <= index) {
		return nil;
	}
	return [components objectAtIndex:index];
	
}

@end

@implementation NSNumber (SSToolkitAdditionsPrivate)

- (void)initializePluralForms
{
	PluralFormSolvers = [NSMutableDictionary dictionary];
	
	PluralFormSelector pluralSolver;
	
	// rule 0 (1 form) Asian (Chinese, Japanese, Korean, Vietnamese), Persian, Turkic/Altaic (Turkish), Thai, Lao
	pluralSolver = [^NSUInteger(NSInteger n){
		return 0;
	} copy];
	[PluralFormSolvers setObject:pluralSolver forKey:@"zh"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"ja"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"ko"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"vi"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"fa"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"tr"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"th"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"lo"];
	
	// rule #1 (2 forms) Germanic (Danish, Dutch, English, Faroese, Frisian, German, Norwegian, Swedish), Finno-Ugric 
	// (Estonian, Finnish, Hungarian), Language isolate (Basque), Latin/Greek (Greek), Semitic (Hebrew), Romanic 
	// (Italian, Portuguese, Spanish, Catalan)
	pluralSolver = [^NSUInteger(NSInteger n){
		return (n != 1) ? 1 : 0;
	} copy];
	[PluralFormSolvers setObject:pluralSolver forKey:@"da"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"nl"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"en"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"fo"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"fy"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"de"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"no"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"sv"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"sv"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"et"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"fi"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"hu"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"eu"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"el"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"he"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"it"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"pt"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"es"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"ca"];
	
	// rule #2 (2 forms) Romanic (French, Brazilian Portuguese)
	pluralSolver = [^NSUInteger(NSInteger n){
		return (n > 1) ? 1 : 0;
	} copy];
	[PluralFormSolvers setObject:pluralSolver forKey:@"fr"];
	// [PluralSolversDictionary setObject:pluralSolver forKey:@"??"];
	
	// rule #3 (3 forms) Baltic (Latvian)
	pluralSolver = [^NSUInteger(NSInteger n){
		return (n % 10 == 1) && (n % 100 != 11) ? 1 : (n != 0) ? 2 : 0;
	} copy];
	[PluralFormSolvers setObject:pluralSolver forKey:@"lv"];
	
	// rule #4 (4 forms) Celtic (Scottish Gaelic)
	pluralSolver = [^NSUInteger(NSInteger n){
		return ((n == 1) || (n == 11)) ? 0 : ((n == 2) || (n == 12)) ? 1 : ((n > 0) && (n < 20)) ? 2 : 3;
	} copy];
	[PluralFormSolvers setObject:pluralSolver forKey:@"gd"];
	
	// rule #5 (3 forms) Romanic (Romanian)
	pluralSolver = [^NSUInteger(NSInteger n){
		return (n == 1) ? 0 : ((n == 0) || ((n % 100 > 0) && (n % 100 < 20))) ? 1 : 2;
	} copy];
	[PluralFormSolvers setObject:pluralSolver forKey:@"ro"];
	
	// rule #6 (3 forms) Baltic (Lithuanian)
	pluralSolver = [^NSUInteger(NSInteger n){
		return ((n % 10 == 1) && (n % 100 != 11)) ? 0 : (((n % 10 >= 2) && (n % 100 < 10)) || (n % 100 >= 20)) ? 2 : 1;
	} copy];
	[PluralFormSolvers setObject:pluralSolver forKey:@"lt"];
	
	// rule #7 (3 forms) Slavic (Bosnian, Croatian, Serbian, Russian, Ukrainian)
	pluralSolver = [^NSUInteger(NSInteger n){
		return ((n % 10 == 1) && (n % 100 != 11)) ? 0 : ((n % 10 >= 2) && (n % 10 <= 4) && ((n % 100 < 10) || n % 100 >= 20)) ? 1 : 2;
	} copy];
	[PluralFormSolvers setObject:pluralSolver forKey:@"bs"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"hr"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"sr"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"ru"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"uk"];
	
	// rule #8 (3 forms) Slavic (Slovak, Czech)
	pluralSolver = [^NSUInteger(NSInteger n){
		return (n == 1) ? 0 : ((n >= 2) && (n <= 4)) ? 1 : 2;
	} copy];
	[PluralFormSolvers setObject:pluralSolver forKey:@"sk"];
	[PluralFormSolvers setObject:pluralSolver forKey:@"cs"];
	
	// rule #9 (3 forms) Slavic (Polish)
	pluralSolver = [^NSUInteger(NSInteger n){
		return (n == 1) ? 0 : ((n % 10 >= 2) && (n % 10 <= 4) && ((n % 100 < 10) || (n % 100 >= 20))) ? 1 : 2;
	} copy];
	[PluralFormSolvers setObject:pluralSolver forKey:@"pl"];
	
	// rule #10 (4 forms) Slavic (Slovenian, Sorbian)
	pluralSolver = [^NSUInteger(NSInteger n){
		return (n % 100 == 1) ? 0 : (n % 100 == 2) ? 1 : ((n % 100 == 3) || (n % 100 == 4)) ? 2 : 3;
	} copy];
	[PluralFormSolvers setObject:pluralSolver forKey:@"sl"];
	// [PluralSolversDictionary setObject:pluralSolver forKey:@"??"];
	
	// rule #11 (5 forms) Celtic (Irish Gaelic)
	pluralSolver = [^NSUInteger(NSInteger n){
		return (n == 1) ? 0 : (n == 2) ? 1 : (n >= 3) && (n <= 6) ? 2 : ((n >= 7) && (n <= 10)) ? 3 : 4;
	} copy];
	[PluralFormSolvers setObject:pluralSolver forKey:@"ga"];
	
	// rule #12 (6 forms) Semitic (Arabic)
	pluralSolver = [^NSUInteger(NSInteger n){
		return (n == 0) ? 5 : (n == 1) ? 0 : (n == 2) ? 1 : ((n % 100 >= 3) && (n % 100 <= 10)) ? 2 : ((n % 100 >= 11) && (n % 100 <= 99)) ? 3 : 4;
	} copy];
	[PluralFormSolvers setObject:pluralSolver forKey:@"ar"];
	
	// rule #13 (4 forms) Semitic (Maltese)
	pluralSolver = [^NSUInteger(NSInteger n){
		return (n == 1) ? 0 : ((n == 0) || ((n % 100 > 0) && (n % 100 <= 10))) ? 1 : ((n % 100 > 10) && (n % 100 < 20)) ? 2 : 3;
	} copy];
	[PluralFormSolvers setObject:pluralSolver forKey:@"mt"];
	
	// rule #14 (3 forms) Slavic (Macedonian)
	pluralSolver = [^NSUInteger(NSInteger n){
		return (n % 10 == 1) ? 0 : (n % 10 == 2) ? 1 : 2;
	} copy];
	[PluralFormSolvers setObject:pluralSolver forKey:@"mk"];
	
	// rule #15 (2 forms) Icelandic
	pluralSolver = [^NSUInteger(NSInteger n){
		return ((n % 10 == 1) && (n % 100 != 11)) ? 0 : 1;
	} copy];
	[PluralFormSolvers setObject:pluralSolver forKey:@"is"];
}

@end