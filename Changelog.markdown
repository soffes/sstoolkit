# SSToolkit Changelog

### Version 0.1.2

[Released October 31, 2011](https://github.com/samsoffes/sstoolkit/tree/0.1.2)

* Fix bug in HUD view not dismissing
* Fix leak in collection view
* Move SSCollection view to it's own repo


### Version 0.1.1

[Released October 18, 2011](https://github.com/samsoffes/sstoolkit/tree/0.1.1)

* Added `SSCollectionViewItemAnimation` to SSCollectionView

* Added basic tests

* Documented SSCollectionViewDataSource

* Documented SSCollectionViewDelegate

* Added `- (NSArray *)visibleItems` to SSCollectionView

* Added `- (NSArray *)indexPathsForVisibleRows` to SSCollectionView

* Added begin/end updates to SSCollection with the following methods:    

        - (void)beginUpdates;
        - (void)endUpdates;
        - (void)insertItemsAtIndexPaths:(NSArray *)indexPaths withItemAnimation:(SSCollectionViewItemAnimation)animation;
        - (void)deleteItemsAtIndexPaths:(NSArray *)indexPaths withItemAnimation:(SSCollectionViewItemAnimation)animation;
        - (void)insertSections:(NSIndexSet *)sections withItemAnimation:(SSCollectionViewItemAnimation)animation;
        - (void)deleteSections:(NSIndexSet *)sections withItemAnimation:(SSCollectionViewItemAnimation)animation;

### Version 0.1.0

[Released October 17, 2011](https://github.com/samsoffes/sstoolkit/tree/0.1.0)

* Initial release
