# SSToolkit Changelog

### Version 0.1.1

**Unreleased**

* Added `SSCollectionViewItemAnimation` to SSCollectionView

* Added basic tests

* Added begin/end updates to SSCollection with the following methods:    

        - (void)beginUpdates;
        - (void)endUpdates;
        - (void)insertItemsAtIndexPaths:(NSArray *)indexPaths withItemAnimation:(SSCollectionViewItemAnimation)animation;
        - (void)deleteItemsAtIndexPaths:(NSArray *)indexPaths withItemAnimation:(SSCollectionViewItemAnimation)animation;
        - (void)insertSections:(NSIndexSet *)sections withItemAnimation:(SSCollectionViewItemAnimation)animation;
        - (void)deleteSections:(NSIndexSet *)sections withItemAnimation:(SSCollectionViewItemAnimation)animation;
        - (void)moveSection:(NSInteger)section toSection:(NSInteger)newSection;

### Version 0.1.0

[Released September 18, 2011](https://github.com/samsoffes/sskeychain/tree/0.1.0)

* Initial release
