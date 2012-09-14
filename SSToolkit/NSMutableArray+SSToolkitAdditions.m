#import "NSMutableArray+SSToolkitAdditions.h"

@implementation NSMutableArray (SSToolkitAdditions)

- (void)shuffle
{
    for (NSUInteger i = [self count] - 1; i > 0; i--) {
        [self exchangeObjectAtIndex:arc4random_uniform(i + 1)
                  withObjectAtIndex:i];
    }
}

@end
