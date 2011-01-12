#!/usr/bin/python

#	Copyright (c) 2008 Matthew Ball
# 
#	Permission is hereby granted, free of charge, to any person
#	obtaining a copy of this software and associated documentation
#	files (the "Software"), to deal in the Software without
#	restriction, including without limitation the rights to use,
#	copy, modify, merge, publish, distribute, sublicense, and/or sell
#	copies of the Software, and to permit persons to whom the
#	Software is furnished to do so, subject to the following
#	conditions:
# 
#	The above copyright notice and this permission notice shall be
#	included in all copies or substantial portions of the Software.
#
#	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
#	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
#	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
#	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
#	OTHER DEALINGS IN THE SOFTWARE.

import sys 
import os 
import fnmatch
import re
import errno
from optparse import OptionParser
from xml.dom import minidom

def _mkdir(newdir):
    if os.path.isdir(newdir):
        pass
    elif os.path.isfile(newdir):
        raise OSError("a file with the same name as the desired " \
                      "dir, '%s', already exists." % newdir)
    else:
        head, tail = os.path.split(newdir)
        if head and not os.path.isdir(head):
            _mkdir(head)

        if tail:
            os.mkdir(newdir)

def longestToShortestCompare(x, y):
	if len(x) > len(y):
		return -1
	elif len(x) < len(y):
		return 1
	else:
		return 0

def fileIsDocumented(filePath):
	# Only XML files can contain documentation information
	if not os.path.splitext(filePath)[1] == ".xml":
		return False
	
	# Check if the object is documented
	originaldoc = minidom.parse(filePath)
	briefList = originaldoc.getElementsByTagName('briefdescription')
	detailList = originaldoc.getElementsByTagName('detaileddescription')

	for briefItem in briefList:
		paraList = briefItem.getElementsByTagName('para')
		if len(paraList) > 0:
			return True

	for detailItem in detailList:
		paraList = detailItem.getElementsByTagName('para')
		if len(paraList) > 0:
			return True

	return False

def nameForFile(filePath):
	if not os.path.splitext(filePath)[1] == ".xml":
		return None
	
	xmlDoc = minidom.parse(filePath)
	return xmlDoc.getElementsByTagName("name")[0].firstChild.data

def typeForFile(filePath):
	if not os.path.splitext(filePath)[1] == ".xml":
		return None
		
	xmlDoc = minidom.parse(filePath)
	return xmlDoc.getElementsByTagName("object")[0].attributes["kind"].value

def cleanXML(filePath, outputDirectory):
	if not fileIsDocumented(filePath):
		return
		
	fileName = os.path.split(filePath)[1]
		
	global verbose
	if verbose:
		print "Cleaning " + fileName
		
	_mkdir(outputDirectory)
	
	# Perform the XSL Transform
	tempPath = os.path.join(outputDirectory, fileName)
	stylesheetPath = os.path.join(sys.path[0], "object.xslt")
	os.system("xsltproc -o \"%s\" \"%s\" \"%s\"" % (tempPath, stylesheetPath, filePath))
	
	# Load the new XML file to get some values from it
	objectName = nameForFile(tempPath)
	objectType = typeForFile(tempPath)
	
	# Determine the appropriate subdirectory for the file
	if objectType == "class":
		finalPath = os.path.join(outputDirectory, "Classes")
	elif objectType == "category":
		finalPath = os.path.join(outputDirectory, "Categories")
	elif objectType == "protocol":
		finalPath = os.path.join(outputDirectory, "Protocols")
	_mkdir(finalPath)
	
	# Move the file to its final location
	finalPath = os.path.join(finalPath, objectName + ".xml")
	os.system("mv \"%s\" \"%s\"" % (tempPath, finalPath))
	
def createIndexXML(directory):
	outputPath = os.path.join(directory, "index.xml")
	indexXML = minidom.Document()
	
	projectElement = indexXML.createElement("project")
	projectElement.setAttribute("name", "##PROJECT##")
	indexXML.appendChild(projectElement)
	
	# Add one element per file
	for (path, dirs, files) in os.walk(directory):
		for fileName in files:
			# Only look at XML files
			if not os.path.splitext(fileName)[1] == ".xml":
				continue
			
			# Get information about the file
			filePath = os.path.join(path, fileName)
			objectName = nameForFile(filePath)
			objectType = typeForFile(filePath)
			
			# Create an <object> element
			objectElement = indexXML.createElement("object")
			objectElement.setAttribute("kind", objectType)
			projectElement.appendChild(objectElement)
			
			# Create a <name> element
			nameElement = indexXML.createElement("name")
			objectElement.appendChild(nameElement)
			nameText = indexXML.createTextNode(objectName)
			nameElement.appendChild(nameText)
			
	# Write the index file
	f = open(outputPath, "w")
	indexXML.writexml(f, "", "\t", "\n")
	f.close()
	
	return outputPath
	
def linkify(directory, shouldEstablishIPhoneLinks):
	indexFile = minidom.parse(os.path.join(directory, "index.xml"))
	documentedObjects = indexFile.getElementsByTagName("name")
	
	global verbose
	
	# Get each file
	for (path, dirs, files) in os.walk(directory):
		for fileName in files:
			# Skip the index and any non-xml files
			if fileName == "index.xml" or not os.path.splitext(fileName)[1] == ".xml":
				continue
			
			filePath = os.path.join(path, fileName)
			
			if verbose:
				print "Linkifying " + fileName
			
			f = open(filePath, "r")
			fileContents = f.read()
			f.close()
			
			# Remove all refs initially
			# We will recreate them ourselves
			fileContents = re.sub("\\<ref(?: .*)?\\>(.*?)\\</ref\\>", "\\1", fileContents);
			
			documentedTargets = {}
			
			if not shouldEstablishIPhoneLinks:
				if verbose:
					print "Establishing links to Foundation"
				macFoundationClasses = [
					"NSAffineTransform",
					"NSAppleEventDescriptor",
					"NSAppleEventManager",
					"NSAppleScript",
					"NSArchiver",
					"NSArray",
					"NSAssertionHandler",
					"NSAttributedString",
					"NSAutoreleasePool",
					"NSBlockOperation",
					"NSBundle",
					"NSCachedURLResponse",
					"NSCalendar",
					"NSCharacterSet",
					"NSClassDescription",
					"NSCloneCommand",
					"NSCloseCommand",
					"NSCoder",
					"NSComparisonPredicate",
					"NSCompoundPredicate",
					"NSCondition",
					"NSConditionLock",
					"NSConnection",
					"NSCountCommand",
					"NSCountedSet",
					"NSCreateCommand",
					"NSData",
					"NSDate",
					"NSDateComponents",
					"NSDateFormatter",
					"NSDecimalNumber",
					"NSDecimalNumberHandler",
					"NSDeleteCommand",
					"NSDeserializer",
					"NSDictionary",
					"NSDirectoryEnumerator",
					"NSDistantObject",
					"NSDistantObjectRequest",
					"NSDistributedLock",
					"NSDistributedNotificationCenter",
					"NSEnumerator",
					"NSError",
					"NSException",
					"NSExistsCommand",
					"NSExpression",
					"NSFileHandle",
					"NSFileManager",
					"NSFormatter",
					"NSGarbageCollector",
					"NSGetCommand",
					"NSHashTable",
					"NSHost",
					"NSHTTPCookie",
					"NSHTTPCookieStorage",
					"NSHTTPURLResponse",
					"NSIndexPath",
					"NSIndexSet",
					"NSIndexSpecifier",
					"NSInputStream",
					"NSInvocation",
					"NSInvocationOperation",
					"NSKeyedArchiver",
					"NSKeyedUnarchiver",
					"NSLocale",
					"NSLock",
					"NSLogicalTest",
					"NSMachBootstrapServer",
					"NSMachPort",
					"NSMapTable",
					"NSMessagePort",
					"NSMessagePortNameServer",
					"NSMetadataItem",
					"NSMetadataQuery",
					"NSMetadataQueryAttributeValueTuple",
					"NSMetadataQueryResultGroup",
					"NSMethodSignature",
					"NSMiddleSpecifier",
					"NSMoveCommand",
					"NSMutableArray",
					"NSMutableAttributedString",
					"NSMutableCharacterSet",
					"NSMutableData",
					"NSMutableDictionary",
					"NSMutableIndexSet",
					"NSMutableSet",
					"NSMutableString",
					"NSMutableURLRequest",
					"NSNameSpecifier",
					"NSNetService",
					"NSNetServiceBrowser",
					"NSNotification",
					"NSNotificationCenter",
					"NSNotificationQueue",
					"NSNull",
					"NSNumber",
					"NSNumberFormatter",
					"NSObject",
					"NSOperation",
					"NSOperationQueue",
					"NSOrthography",
					"NSOutputStream",
					"NSPipe",
					"NSPointerArray",
					"NSPointerFunctions",
					"NSPort",
					"NSPortCoder",
					"NSPortMessage",
					"NSPortNameServer",
					"NSPositionalSpecifier",
					"NSPredicate",
					"NSProcessInfo",
					"NSPropertyListSerialization",
					"NSPropertySpecifier",
					"NSProtocolChecker",
					"NSProxy",
					"NSQuitCommand",
					"NSRandomSpecifier",
					"NSRangeSpecifier",
					"NSRecursiveLock",
					"NSRelativeSpecifier",
					"NSRunLoop",
					"NSScanner",
					"NSScriptClassDescription",
					"NSScriptCoercionHandler",
					"NSScriptCommand",
					"NSScriptCommandDescription",
					"NSScriptExecutionContext",
					"NSScriptObjectSpecifier",
					"NSScriptSuiteRegistry",
					"NSScriptWhoseTest",
					"NSSerializer",
					"NSSet",
					"NSSetCommand",
					"NSSocketPort",
					"NSSocketPortNameServer",
					"NSSortDescriptor",
					"NSSpecifierTest",
					"NSSpellServer",
					"NSStream",
					"NSString",
					"NSTask",
					"NSTextCheckingResult",
					"NSThread",
					"NSTimer",
					"NSTimeZone",
					"NSUnarchiver",
					"NSUndoManager",
					"NSUniqueIDSpecifier",
					"NSURL",
					"NSURLAuthenticationChallenge",
					"NSURLCache",
					"NSURLConnection",
					"NSURLCredential",
					"NSURLCredentialStorage",
					"NSURLDownload",
					"NSURLHandle",
					"NSURLProtectionSpace",
					"NSURLProtocol",
					"NSURLRequest",
					"NSURLResponse",
					"NSUserDefaults",
					"NSValue",
					"NSValueTransformer",
					"NSWhoseSpecifier",
					"NSXMLDocument",
					"NSXMLDTD",
					"NSXMLDTDNode",
					"NSXMLElement",
					"NSXMLNode",
					"NSXMLParser"]
				documentedTargets.update(dict.fromkeys(macFoundationClasses, "http://developer.apple.com/mac/library/documentation/Cocoa/Reference/Foundation/Classes/{name}_Class/index"))
				
				macFoundationProtocols = [
					"NSCoding",
					"NSComparisonMethods",
					"NSConnectionDelegate",
					"NSCopying",
					"NSDecimalNumberBehaviors",
					"NSErrorRecoveryAttempting",
					"NSFastEnumeration",
					"NSKeyedArchiverDelegate",
					"NSKeyedUnarchiverDelegate",
					"NSKeyValueCoding",
					"NSKeyValueObserving",
					"NSLocking",
					"NSMachPortDelegate",
					"NSMetadataQueryDelegate",
					"NSMutableCopying",
					"NSNetServiceBrowserDelegate",
					"NSNetServiceDelegate",
					"NSObjCTypeSerializationCallBack",
				#	"NSObject", # No way to tell if the class or protocol should be
				#				linked, so assume the class
					"NSPortDelegate",
					"NSScriptingComparisonMethods",
					"NSScriptKeyValueCoding",
					"NSScriptObjectSpecifiers",
					"NSSpellServerDelegate",
					"NSStreamDelegate",
					"NSURLAuthenticationChallengeSender",
					"NSURLHandleClient",
					"NSURLProtocolClient",
					"NSXMLParserDelegate"]
				documentedTargets.update(dict.fromkeys(macFoundationProtocols, "http://developer.apple.com/mac/library/documentation/Cocoa/Reference/Foundation/Protocols/{name}_Protocol/index"))
				
				if verbose:
					print "Establishing links to AppKit"
				macAppKitClasses = [
					"NSActionCell",
					"NSAlert",
					"NSAnimation",
					"NSAnimationContext",
					"NSApplication",
					"NSArrayController",
					"NSATSTypesetter",
					"NSBezierPath",
					"NSBitmapImageRep",
					"NSBox",
					"NSBrowser",
					"NSBrowserCell",
					"NSButton",
					"NSButtonCell",
					"NSCachedImageRep",
					"NSCell",
					"NSCIImageRep",
					"NSClipView",
					"NSCollectionView",
					"NSCollectionViewItem",
					"NSColor",
					"NSColorList",
					"NSColorPanel",
					"NSColorPicker",
					"NSColorSpace",
					"NSColorWell",
					"NSComboBox",
					"NSComboBoxCell",
					"NSControl",
					"NSController",
					"NSCursor",
					"NSCustomImageRep",
					"NSDatePicker",
					"NSDatePickerCell",
					"NSDictionaryController",
					"NSDockTile",
					"NSDocument",
					"NSDocumentController",
					"NSDrawer",
					"NSEPSImageRep",
					"NSEvent",
					"NSFileWrapper",
					"NSFont",
					"NSFontDescriptor",
					"NSFontManager",
					"NSFontPanel",
					"NSForm",
					"NSFormCell",
					"NSGlyphGenerator",
					"NSGlyphInfo",
					"NSGradient",
					"NSGraphicsContext",
					"NSHelpManager",
					"NSImage",
					"NSImageCell",
					"NSImageRep",
					"NSImageView",
					"NSLayoutManager",
					"NSLevelIndicator",
					"NSLevelIndicatorCell",
					"NSMatrix",
					"NSMenu",
					"NSMenuItem",
					"NSMenuItemCell",
					"NSMenuView",
					"NSMutableParagraphStyle",
					"NSNib",
					"NSNibConnector",
					"NSNibControlConnector",
					"NSNibOutletConnector",
					"NSObjectController",
					"NSOpenGLContext",
					"NSOpenGLLayer",
					"NSOpenGLPixelBuffer",
					"NSOpenGLPixelFormat",
					"NSOpenGLView",
					"NSOpenPanel",
					"NSOutlineView",
					"NSPageLayout",
					"NSPanel",
					"NSParagraphStyle",
					"NSPasteboard",
					"NSPasteboardItem",
					"NSPathCell",
					"NSPathComponentCell",
					"NSPathControl",
					"NSPDFImageRep",
					"NSPersistentDocument",
					"NSPICTImageRep",
					"NSPopUpButton",
					"NSPopUpButtonCell",
					"NSPredicateEditor",
					"NSPredicateEditorRowTemplate",
					"NSPrinter",
					"NSPrintInfo",
					"NSPrintOperation",
					"NSPrintPanel",
					"NSProgressIndicator",
					"NSResponder",
					"NSRuleEditor",
					"NSRulerMarker",
					"NSRulerView",
					"NSRunningApplication",
					"NSSavePanel",
					"NSScreen",
					"NSScroller",
					"NSScrollView",
					"NSSearchField",
					"NSSearchFieldCell",
					"NSSecureTextField",
					"NSSecureTextFieldCell",
					"NSSegmentedCell",
					"NSSegmentedControl",
					"NSShadow",
					"NSSlider",
					"NSSliderCell",
					"NSSound",
					"NSSpeechRecognizer",
					"NSSpeechSynthesizer",
					"NSSpellChecker",
					"NSSplitView",
					"NSStatusBar",
					"NSStatusItem",
					"NSStepper",
					"NSStepperCell",
					"NSTableColumn",
					"NSTableHeaderCell",
					"NSTableHeaderView",
					"NSTableView",
					"NSTabView",
					"NSTabViewItem",
					"NSText",
					"NSTextAttachment",
					"NSTextAttachmentCell",
					"NSTextBlock",
					"NSTextContainer",
					"NSTextField",
					"NSTextFieldCell",
					"NSTextInputContext",
					"NSTextList",
					"NSTextStorage",
					"NSTextTab",
					"NSTextTable",
					"NSTextTableBlock",
					"NSTextView",
					"NSTokenField",
					"NSTokenFieldCell",
					"NSToolbar",
					"NSToolbarItem",
					"NSToolbarItemGroup",
					"NSTouch",
					"NSTrackingArea",
					"NSTreeController",
					"NSTreeNode",
					"NSTypesetter",
					"NSUserDefaultsController",
					"NSView",
					"NSViewAnimation",
					"NSViewController",
					"NSWindow",
					"NSWindowController",
					"NSWorkspace"]
				documentedTargets.update(dict.fromkeys(macAppKitClasses, "http://developer.apple.com/mac/library/documentation/Cocoa/Reference/ApplicationKit/Classes/{name}_Class/index"))
				
				macAppKitProtocols = [
					"NSAccessibility",
					"NSAlertDelegate",
					"NSAnimatablePropertyContainer",
					"NSAnimationDelegate",
					"NSApplicationDelegate",
					"NSBrowserDelegate",
					"NSChangeSpelling",
					"NSCollectionViewDelegate",
					"NSColorPickingCustom",
					"NSColorPickingDefault",
					"NSComboBoxCellDataSource",
					"NSComboBoxDataSource",
					"NSComboBoxDelegate",
					"NSControlTextEditingDelegate",
					"NSDatePickerCellDelegate",
					"NSDictionaryControllerKeyValuePair",
					"NSDockTilePlugIn",
					"NSDraggingDestination",
					"NSDraggingInfo",
					"NSDraggingSource",
					"NSDrawerDelegate",
					"NSEditor",
					"NSEditorRegistration",
					"NSFontPanelValidation",
					"NSGlyphStorage",
					"NSIgnoreMisspelledWords",
					"NSImageDelegate",
					"NSKeyValueBindingCreation",
					"NSLayoutManagerDelegate",
					"NSMatrixDelegate",
					"NSMenuDelegate",
					"NSMenuValidation",
					"NSNibAwaking",
					"NSOpenSavePanelDelegate",
					"NSOutlineViewDataSource",
					"NSOutlineViewDelegate",
					"NSPasteboardItemDataProvider",
					"NSPasteboardReading",
					"NSPasteboardWriting",
					"NSPathCellDelegate",
					"NSPathControlDelegate",
					"NSPlaceholders",
					"NSPrintPanelAccessorizing",
					"NSRuleEditorDelegate",
					"NSServicesRequests",
					"NSSoundDelegate",
					"NSSpeechRecognizerDelegate",
					"NSSpeechSynthesizerDelegate",
					"NSSplitViewDelegate",
					"NSTableViewDataSource",
					"NSTableViewDelegate",
					"NSTabViewDelegate",
					"NSTextAttachmentCell",
					"NSTextDelegate",
					"NSTextFieldDelegate",
					"NSTextInput",
					"NSTextInputClient",
					"NSTextViewDelegate",
					"NSTokenFieldCellDelegate",
					"NSTokenFieldDelegate",
					"NSToolbarDelegate",
					"NSToolbarItemValidation",
					"NSToolTipOwner",
					"NSUserInterfaceValidations",
					"NSValidatedUserInterfaceItem",
					"NSWindowDelegate",
					"NSWindowScripting"]
				documentedTargets.update(dict.fromkeys(macAppKitProtocols, "http://developer.apple.com/mac/library/documentation/Cocoa/Reference/ApplicationKit/Protocols/{name}_Protocol/index"))
			
				if verbose:
					print "Establishing links to Address Book"
				macAddressBookClasses = [
					"ABAddressBook",
					"ABGroup",
					"ABMultiValue",
					"ABMutableMultiValue",
					"ABPeoplePickerView",
					"ABPerson",
					"ABRecord",
					"ABSearchElement"]
				documentedTargets.update(dict.fromkeys(macAddressBookClasses, "http://developer.apple.com/mac/library/documentation/UserExperience/Reference/AddressBook/Classes/{name}_Class/index"))
				
				macAddressBookProtocols = [
					"ABActionDelegate",
					"ABImageClient"]
				documentedTargets.update(dict.fromkeys(macAddressBookProtocols, "http://developer.apple.com/mac/library/documentation/UserExperience/Reference/AddressBook/Protocols/{name}_Protocol/index"))
			
				if verbose:
					print "Establishing links to Core Data"
				macCoreDataClasses = [
					"NSAttributeDescription",
					"NSEntityDescription",
					"NSFetchedPropertyDescription",
					"NSFetchRequestExpression",
					"NSManagedObject",
					"NSManagedObjectContext",
					"NSManagedObjectID",
					"NSManagedObjectModel",
					"NSPersistentStoreCoordinator",
					"NSPropertyDescription",
					"NSRelationshipDescription"]
				documentedTargets.update(dict.fromkeys(macCoreDataClasses, "http://developer.apple.com/mac/library/documentation/Cocoa/Reference/CoreDataFramework/Classes/{name}_Class/index"))
			
				# For whatever reason, some Core Data classes aren't at the same location as the others
				macOtherCoreDataClasses = [
					"NSAtomicStore",
					"NSAtomicStoreCacheNode",
					"NSEntityMapping",
					"NSEntityMigrationPolicy",
					"NSExpressionDescription",
					"NSFetchRequest",
					"NSMappingModel",
					"NSMigrationManager",
					"NSPersistentStore",
					"NSPropertyMapping"]
				documentedTargets.update(dict.fromkeys(macOtherCoreDataClasses, "http://developer.apple.com/mac/library/documentation/Cocoa/Reference/{name}_Class/index"))
			
				if verbose:
					print "Establishing links to Core Location"
				macCoreLocationClasses = [
					"CLLocation",
					"CLLocationManager"]
				documentedTargets.update(dict.fromkeys(macCoreLocationClasses, "http://developer.apple.com/mac/library/documentation/CoreLocation/Reference/{name}_Class/index"))
			
				macCoreLocationProtocols = [
					"CLLocationManagerDelegate"]
				documentedTargets.update(dict.fromkeys(macCoreLocationProtocols, "http://developer.apple.com/mac/library/documentation/CoreLocation/Reference/{name}_Protocol/index"))
				
			else:
				if verbose:
					print "Establishing links to Foundation"
				iphoneFoundationClasses = [
					"NSArray",
					"NSAssertionHandler",
					"NSAutoreleasePool",
					"NSBundle",
					"NSCachedURLResponse",
					"NSCalendar",
					"NSCharacterSet",
					"NSCoder",
					"NSComparisonPredicate",
					"NSCompoundPredicate",
					"NSCondition",
					"NSConditionLock",
					"NSCountedSet",
					"NSData",
					"NSDate",
					"NSDateComponents",
					"NSDateFormatter",
					"NSDecimalNumber",
					"NSDecimalNumberHandler",
					"NSDictionary",
					"NSDirectoryEnumerator",
					"NSDistributedNotificationCenter",
					"NSEnumerator",
					"NSError",
					"NSException",
					"NSExpression",
					"NSFileHandle",
					"NSFileManager",
					"NSFormatter",
					"NSHTTPCookie",
					"NSHTTPCookieStorage",
					"NSHTTPURLResponse",
					"NSIndexPath",
					"NSIndexSet",
					"NSInputStream",
					"NSInvocation",
					"NSInvocationOperation",
					"NSKeyedArchiver",
					"NSKeyedUnarchiver",
					"NSLocale",
					"NSLock",
					"NSMachPort",
					"NSMessagePort",
					"NSMethodSignature",
					"NSMutableArray",
					"NSMutableCharacterSet",
					"NSMutableData",
					"NSMutableDictionary",
					"NSMutableIndexSet",
					"NSMutableSet",
					"NSMutableString",
					"NSMutableURLRequest",
					"NSNetService",
					"NSNetServiceBrowser",
					"NSNotification",
					"NSNotificationCenter",
					"NSNotificationQueue",
					"NSNull",
					"NSNumber",
					"NSNumberFormatter",
					"NSObject",
					"NSOperation",
					"NSOperationQueue",
					"NSOutputStream",
					"NSPipe",
					"NSPort",
					"NSPredicate",
					"NSProcessInfo",
					"NSPropertyListSerialization",
					"NSProxy",
					"NSRecursiveLock",
					"NSRunLoop",
					"NSScanner",
					"NSSet",
					"NSSortDescriptor",
					"NSStream",
					"NSString",
					"NSThread",
					"NSTimer",
					"NSTimeZone",
					"NSUndoManager",
					"NSURL",
					"NSURLAuthenticationChallenge",
					"NSURLCache",
					"NSURLConnection",
					"NSURLCredential",
					"NSURLCredentialStorage",
					"NSURLProtectionSpace",
					"NSURLProtocol",
					"NSURLRequest",
					"NSURLResponse",
					"NSUserDefaults",
					"NSValue",
					"NSValueTransformer",
					"NSXMLParser"]
				documentedTargets.update(dict.fromkeys(iphoneFoundationClasses, "http://developer.apple.com/iphone/library/documentation/Cocoa/Reference/Foundation/Classes/{name}_Class/index"))
			
				iphoneFoundationProtocols = [
					"NSCoding",
					"NSCopying",
					"NSDecimalNumberBehaviors",
					"NSErrorRecoveryAttempting",
					"NSFastEnumeration",
					"NSKeyValueCoding",
					"NSKeyValueObserving",
					"NSLocking",
					"NSMutableCopying",
					"NSObject",
					"NSURLAuthenticationChallengeSender",
					"NSURLProtocolClient"]
				documentedTargets.update(dict.fromkeys(iphoneFoundationProtocols, "http://developer.apple.com/iphone/library/documentation/Cocoa/Reference/Foundation/Protocols/{name}_Protocol/index"))
			
				if verbose:
					print "Establishing links to AddressBook"
				iphoneAddressBookClasses = [
					"ABAddressBook",
					"ABMultiValue",
					"ABMutableMultiValue",
					"ABRecord"]
				documentedTargets.update(dict.fromkeys(iphoneAddressBookClasses, "http://developer.apple.com/iphone/library/documentation/AddressBook/Reference/{name}Ref_iPhoneOS/index"))
					
				if verbose:
					print "Establishing links to AddressBookUI"
				iphoneAddressBookUIClasses = [
					"ABNewPersonViewController",
					"ABPeoplePickerNavigationController",
					"ABPersonViewController",
					"ABUnknownPersonViewController"]
				documentedTargets.update(dict.fromkeys(iphoneAddressBookUIClasses, "http://developer.apple.com/iphone/library/documentation/AddressBookUI/Reference/{name}_Class/index"))
				
				iphoneAddressBookUIProtocols = [
					"ABNewPersonViewControllerDelegate",
					"ABPeoplePickerNavigationControllerDelegate",
					"ABPersonViewControllerDelegate",
					"ABUnknownPersonViewControllerDelegate"]
				documentedTargets.update(dict.fromkeys(iphoneAddressBookUIProtocols, "http://developer.apple.com/iphone/library/documentation/AddressBookUI/Reference/{name}_Protocol/index"))
			
				if verbose:
					print "Establishing links to Core Data"
				iphoneCoreDataClasses = [
					"NSAttributeDescription",
					"NSEntityDescription",
					"NSFetchedPropertyDescription",
					"NSFetchRequest",
					"NSManagedObject",
					"NSManagedObjectContext",
					"NSManagedObjectID",
					"NSManagedObjectModel",
					"NSPersistentStoreCoordinator",
					"NSPropertyDescription",
					"NSRelationshipDescription"]
				documentedTargets.update(dict.fromkeys(iphoneCoreDataClasses, "http://developer.apple.com/iphone/library/documentation/Cocoa/Reference/CoreDataFramework/Classes/{name}_Class/index"))
			
				# For some reason, certain Core Data docs are at a different URL
				iphoneOtherCoreDataClasses = [
					"NSAtomicStore",
					"NSAtomicStoreCacheNode",
					"NSEntityMapping",
					"NSEntityMigrationPolicy",
					"NSExpressionDescription",
					"NSFetchedResultsController",
					"NSFetchRequestExpression",
					"NSMappingModel",
					"NSMigrationManager",
					"NSPersistentStore",
					"NSPropertyMapping"]
				documentedTargets.update(dict.fromkeys(iphoneOtherCoreDataClasses, "http://developer.apple.com/iphone/library/documentation/Cocoa/Reference/{name}_Class/index"))
			
				iphoneCoreDataProtocols = [
					"NSFetchedResultsControllerDelegate",
					"NSFetchedResultsSectionInfo"]
				documentedTargets.update(dict.fromkeys(iphoneCoreDataProtocols, "http://developer.apple.com/iphone/library/documentation/CoreData/Reference/{name}_Protocol/index"))
				
				if verbose:
					print "Establishing links to Core Location"
				iphoneCoreLocationClasses = [
					"CLHeading",
					"CLLocation",
					"CLLocationManager"]
				documentedTargets.update(dict.fromkeys(iphoneCoreLocationClasses, "http://developer.apple.com/iphone/library/documentation/CoreLocation/Reference/{name}_Class/index"))
					
				iphoneCoreLocationProtocols = [
					"CLLocationManagerDelegate"]
				documentedTargets.update(dict.fromkeys(iphoneCoreLocationProtocols, "http://developer.apple.com/iphone/library/documentation/CoreLocation/Reference/{name}_Protocol/index"))
				
				
				if verbose:
					print "Establishing links to GameKit"
				iphoneGameKitClasses = [
					"GKPeerPickerController",
					"GKSession",
					"GKVoiceChatService"]
				documentedTargets.update(dict.fromkeys(iphoneGameKitClasses, "http://developer.apple.com/iphone/library/documentation/GameKit/Reference/{name}_Class/index"))
				
				iphoneGameKitProtocols = [
					"GKPeerPickerControllerDelegate",
					"GKSessionDelegate",
					"GKVoiceChatClient"]
				documentedTargets.update(dict.fromkeys(iphoneGameKitProtocols, "http://developer.apple.com/iphone/library/documentation/GameKit/Reference/{name}_Protocol/index"))
				
				if verbose:
					print "Establishing links to MapKit"
				iphoneMapKitClasses = [
					"MKAnnotationView",
					"MKMapView",
					"MKPinAnnotationView",
					"MKPlacemark",
					"MKReverseGeocoder",
					"MKUserLocation"]
				documentedTargets.update(dict.fromkeys(iphoneMapKitClasses, "http://developer.apple.com/iphone/library/documentation/MapKit/Reference/{name}_Class/index"))
				
				iphoneMapKitProtocols = [
					"MKAnnotation",
					"MKMapViewDelegate",
					"MKReverseGeocoderDelegate"]
				documentedTargets.update(dict.fromkeys(iphoneMapKitProtocols, "http://developer.apple.com/iphone/library/documentation/MapKit/Reference/{name}_Protocol/index"))
				
				if verbose:
					print "Establishing links to MessageUI"
				iphoneMessageUIClasses = [
					"MFMailComposeViewController"]
				documentedTargets.update(dict.fromkeys(iphoneMessageUIClasses, "http://developer.apple.com/iphone/library/documentation/MessageUI/Reference/{name}_Class/index"))
				
				iphoneMessageUIProtocols = [
					"MFMailComposeViewControllerDelegate"]
				documentedTargets.update(dict.fromkeys(iphoneMessageUIProtocols, "http://developer.apple.com/iphone/library/documentation/MessageUI/Reference/{name}_Protocol/index"))
				
				if verbose:
					print "Establishing links to StoreKit"
				iphoneStoreKitClasses = [
					"SKMutablePayment",
					"SKPayment",
					"SKPaymentQueue",
					"SKPaymentTransaction"]
				documentedTargets.update(dict.fromkeys(iphoneStoreKitClasses, "http://developer.apple.com/iphone/library/documentation/StoreKit/Reference/{name}_Class/index"))
			
				# For whatever reason, this one class gets to live somewhere else...
				iphoneOtherStoreKitClasses = [
					"SKProduct"]
				documentedTargets.update(dict.fromkeys(iphoneOtherStoreKitClasses, "http://developer.apple.com/iphone/library/documentation/StoreKit/Reference/{name}_Reference/index"))
			
				iphoneStoreKitProtocols = [
					"SKPaymentTransactionObserver"]
				documentedTargets.update(dict.fromkeys(iphoneStoreKitProtocols, "http://developer.apple.com/iphone/library/documentation/StoreKit/Reference/{name}_Protocol/index"))
			
				# REALLY?!?
				iphoneWeirdStoreKitClassesAndProtocols = [
					"SKProductsRequest",
					"SKProductsResponse",
					"SKRequest",
					"SKProductsRequestDelegate",
					"SKRequestDelegate"]
				documentedTargets.update(dict.fromkeys(iphoneWeirdStoreKitClassesAndProtocols, "http://developer.apple.com/iphone/library/documentation/StoreKit/Reference/{name}/index"))
				
				if verbose:
					print "Establishing links to UIKit"
				iphoneUIKitClasses = [
					"UIAcceleration",
					"UIAccelerometer",
					"UIAccessibilityElement",
					"UIActionSheet",
					"UIActivityIndicatorView",
					"UIAlertView",
					"UIApplication",
					"UIBarButtonItem",
					"UIBarItem",
					"UIButton",
					"UIColor",
					"UIControl",
					"UIDatePicker",
					"UIDevice",
					"UIEvent",
					"UIFont",
					"UIImage",
					"UIImagePickerController",
					"UIImageView",
					"UILabel",
					"UILocalizedIndexedCollation",
					"UIMenuController",
					"UINavigationBar",
					"UINavigationController",
					"UINavigationItem",
					"UIPageControl",
					"UIPasteboard",
					"UIPickerView",
					"UIProgressView",
					"UIResponder",
					"UIScreen",
					"UIScrollView",
					"UISearchBar",
					"UISearchDisplayController",
					"UISegmentedControl",
					"UISlider",
					"UISwitch",
					"UITabBar",
					"UITabBarController",
					"UITabBarItem",
					"UITableView",
					"UITableViewCell",
					"UITableViewController",
					"UITextField",
					"UITextView",
					"UIToolbar",
					"UITouch",
					"UIVideoEditorController",
					"UIView",
					"UIViewController",
					"UIWebView",
					"UIWindow"]
				documentedTargets.update(dict.fromkeys(iphoneUIKitClasses, "http://developer.apple.com/iphone/library/documentation/UIKit/Reference/{name}_Class/index"))
				
				iphoneUIKitProtocols = [
					"UIAccelerometerDelegate",
					"UIAccessibility",
					"UIAccessibilityContainer",
					"UIActionSheetDelegate",
					"UIAlertViewDelegate",
					"UIApplicationDelegate",
					"UIImagePickerControllerDelegate",
					"UINavigationBarDelegate",
					"UINavigationControllerDelegate",
					"UIPickerViewDataSource",
					"UIPickerViewDelegate",
					"UIResponderStandardEditActions",
					"UIScrollViewDelegate",
					"UISearchBarDelegate",
					"UISearchDisplayDelegate",
					"UITabBarControllerDelegate",
					"UITabBarDelegate",
					"UITableViewDataSource",
					"UITableViewDelegate",
					"UITextFieldDelegate",
					"UITextInputTraits",
					"UITextViewDelegate",
					"UIVideoEditorControllerDelegate",
					"UIWebViewDelegate"]
				documentedTargets.update(dict.fromkeys(iphoneUIKitProtocols, "http://developer.apple.com/iphone/library/documentation/UIKit/Reference/{name}_Protocol/index"))
			
			
			# Establish links to all files in the project
			for documentedObject in documentedObjects:
				# We need to get rid of whitespace
				# (It's a "feature" of minidom)
				objectName = documentedObject.firstChild.data.replace("\n", "").replace("\t", "")
				objectType = documentedObject.parentNode.attributes["kind"].value
				
				if objectType == "class":
					target = "../Classes/{name}"
				elif objectType == "category":
					target = "../Categories/{name}"
				elif objectType == "protocol":
					target = "../Protocols/{name}"
					
				documentedTargets[objectName] = target
			
			documentedTargetNames = documentedTargets.keys()
			documentedTargetNames.sort(cmp=longestToShortestCompare)
			documentedTargetsPattern = "([^\\<\\>]*)(" + '|'.join(documentedTargetNames) + ")"
			fileContents = re.sub(documentedTargetsPattern, "\\1<ref>\\2</ref>", fileContents)
				
			fileDOM = minidom.parseString(fileContents)
			refNodes = fileDOM.getElementsByTagName("ref")
			for refNode in refNodes:
				# If it's within the top-level <name> or <file> elements,
				# remove the <ref>
				# This is no longer checked in the regex since <name> or <file>
				# could feasibly be used in other contexts (ie: inheritance lists)
				if ((refNode.parentNode.tagName == "name") or (refNode.parentNode.tagName == "file")) and (refNode.parentNode.parentNode.tagName == "object"):
					textNode = fileDOM.createTextNode(refNode.childNodes[0].nodeValue)
					refNode.parentNode.replaceChild(textNode, refNode)
					continue
				
				refName = refNode.childNodes[0].nodeValue
				formatString = documentedTargets[refName]
				refTarget = formatString.format(name=refName)
				refNode.setAttribute("id", refTarget)
	
			# Write the xml file
			f = open(filePath, "w")			
			f.write(fileDOM.toxml("UTF-8"))
			f.close()
			
def convertToHTML(filePath, outputDirectory):
	global verbose
	
	# Get info about the object
	objectName = nameForFile(filePath)
	objectType = typeForFile(filePath)
	
	if verbose:
		print "Converting " + objectName + ".html"
	
	if objectType == "class":
		outputDirectory = os.path.join(outputDirectory, "Classes")
	elif objectType == "category":
		outputDirectory = os.path.join(outputDirectory, "Categories")
	elif objectType == "protocol":
		outputDirectory = os.path.join(outputDirectory, "Protocols")
	_mkdir(outputDirectory)
	
	outputPath = os.path.join(outputDirectory, objectName + ".html")
	
	stylesheetPath = sys.path[0] + '/object2html.xslt'
	os.system("xsltproc -o \"%s\" \"%s\" \"%s\"" % (outputPath, stylesheetPath, filePath))

def convertIndexToHTML(filePath, outputDirectory):
	# Create the index html file
	stylesheetPath = sys.path[0] + '/index2html.xslt'
	outputPath = outputDirectory + '/index.html'
	os.system("xsltproc -o \"%s\" \"%s\" \"%s\"" % (outputPath, stylesheetPath, filePath))

def insertProjectName(directory, projectName):
	for (path, dirs, files) in os.walk(directory):
		for fileName in files:
			filePath = os.path.join(path, fileName)
			
			# Replace Project with projectName
			f = open(filePath, "r")
			text = f.read()
			f.close()
			f = open(filePath, "w")
			f.write(text.replace("##PROJECT##", projectName))
			f.close()

def main(argv=None):
	if argv is None:
		argv = sys.argv
		
	global verbose
		
	# Parse command line options
	optionParser = OptionParser(version="%prog 2.2")
	optionParser.add_option("-i", "--input", type="string", dest="inputDirectory", default=os.getcwd(), help="The directory containing Doxygen's XML output. Default is the current directory")
	optionParser.add_option("-o", "--output", type="string", dest="outputDirectory", default=os.getcwd(), help="The directory to output the converted files to. Default is the current directory")
	optionParser.add_option("-n", "--name", type="string", dest="projectName", default="Untitled", help="The name of the project")
	optionParser.add_option("-x", "--xml", action="store_false", dest="makeHTML", default=True, help="Only generate XML. If this flag is not set, both XML and HTML will be generated")
	optionParser.add_option("-p", "--phone", action="store_true", dest="shouldEstablishIPhoneLinks", default=False, help="Establish links to Apple's iPhone framework documentation, rather than to Mac frameworks")
	optionParser.add_option("-v", "--verbose", action="store_true", dest="verbose", default=False, help="Show detailed information")
	(options, args) = optionParser.parse_args(argv[1:])

	verbose = options.verbose

	if verbose:
		print "Checking arguments"
		
	# Check the arguments
	if not os.path.exists(options.inputDirectory):
		print >>sys.stderr, "Error: Input path does not exist: %s" % (options.inputDirectory)
		optionParser.print_help()
		return errno.ENOENT
	elif not os.path.isdir(options.inputDirectory):
		print >>sys.stderr, "Error: Input path is not a directory: %s" % (options.inputDirectory)
		optionParser.print_help()
		return errno.ENOTDIR
	if os.path.exists(options.outputDirectory) and not os.path.isdir(options.outputDirectory):
		print >>sys.stderr, "Error: Output path is not a directory: %s" % (options.outputDirectory)
		return errno.ENOTDIR
	else:
		_mkdir(options.outputDirectory)
		
	# Set the xml output directory
	xmlOutputDirectory = os.path.join(options.outputDirectory, "xml")
		
	# Clean up the XML files
	if verbose:
		print "Cleaning XML files:"
	
	for fileName in os.listdir(options.inputDirectory):
		if fnmatch.fnmatch(fileName, "interface_*.xml") or fnmatch.fnmatch(fileName, "protocol_*.xml"):
			filePath = os.path.join(options.inputDirectory, fileName)
			cleanXML(filePath, xmlOutputDirectory)

	# Create the index file
	if verbose:
		print "Creating index.xml"
	indexPath = createIndexXML(xmlOutputDirectory)
	
	# Establish inter-file links
	if verbose:
		print "Establishing links:"
	linkify(xmlOutputDirectory, options.shouldEstablishIPhoneLinks)
	
	# Convert to HTML
	if options.makeHTML:
		if verbose:
			print "Converting to HTML:"
		htmlOutputDirectory = os.path.join(options.outputDirectory, "html")
		if (os.path.exists(os.path.join(xmlOutputDirectory, "Classes"))):
			for fileName in os.listdir(os.path.join(xmlOutputDirectory, "Classes")):
				filePath = os.path.join(xmlOutputDirectory, "Classes", fileName)
				convertToHTML(filePath, htmlOutputDirectory)
		if (os.path.exists(os.path.join(xmlOutputDirectory, "Categories"))):
			for fileName in os.listdir(os.path.join(xmlOutputDirectory, "Categories")):
				filePath = os.path.join(xmlOutputDirectory, "Categories", fileName)
				convertToHTML(filePath, htmlOutputDirectory)
		if (os.path.exists(os.path.join(xmlOutputDirectory, "Protocols"))):
			for fileName in os.listdir(os.path.join(xmlOutputDirectory, "Protocols")):
				filePath = os.path.join(xmlOutputDirectory, "Protocols", fileName)
				convertToHTML(filePath, htmlOutputDirectory)
		if verbose:
			print "Converting index.html"
		convertIndexToHTML(indexPath, htmlOutputDirectory)
		
		if verbose:
			print "Copying CSS stylesheets"
		# Copy the CSS files over to the new path
		cssPath = sys.path[0] + '/../temp/css'
		os.system("cp -R \"%s\" \"%s\"" % (cssPath, htmlOutputDirectory))
			
	# Set the project name where necessary
	if verbose:
		print "Setting project name"
	insertProjectName(xmlOutputDirectory, options.projectName)
	if options.makeHTML:
		insertProjectName(htmlOutputDirectory, options.projectName)
		
	return 0
	
if __name__ == '__main__':
	sys.exit(main())
