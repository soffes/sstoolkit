Pod::Spec.new do |s|
  s.name         = 'SSToolkit'
  s.version      = '1.0.4'
  s.platform     = :ios
  s.summary      = 'A collection of well-documented iOS classes for making life easier.'
  s.homepage     = 'http://sstoolk.it'
  s.author       = { 'Sam Soffes' => 'sam@soff.es' }
  s.source       = { :git => 'https://github.com/soffes/sstoolkit.git', :tag => 'v1.0.4' }
  s.description  = 'SSToolkit is a collection of well-documented iOS classes for making life ' \
                   'easier by solving common problems all iOS developers face. Some really ' \
                   'handy classes are SSCollectionView, SSGradientView, SSSwitch, and many more.'
  s.source_files = 'SSToolkit/**/*.{h,m}'
  s.frameworks   = 'QuartzCore', 'CoreGraphics', 'MessageUI'
  s.requires_arc = true
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.preserve_paths = 'SSToolkit.xcodeproj', 'Resources'
  s.prefix_header_contents = '#ifdef __OBJC__', '#import "SSToolkitDefines.h"', '#endif'

  s.subspec 'NSArray+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/NSArray+SSToolkitAdditions'
    sp.dependency 'SSToolkit/NSMutableArray+SSToolkitAdditions'
    sp.dependency 'SSToolkit/NSData+SSToolkitAdditions'
  end

  s.subspec 'NSBundle+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/NSBundle+SSToolkitAdditions'
  end

  s.subspec 'NSData+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/NSData+SSToolkitAdditions'
  end

  s.subspec 'NSDate+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/NSDate+SSToolkitAdditions'
    sp.dependency 'SSToolkit/NSBundle+SSToolkitAdditions'
  end

  s.subspec 'NSDictionary+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/NSDictionary+SSToolkitAdditions'
    sp.dependency 'SSToolkit/NSString+SSToolkitAdditions'
    sp.dependency 'SSToolkit/NSData+SSToolkitAdditions'
  end

  s.subspec 'NSMutableArray+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/NSMutableArray+SSToolkitAdditions'
  end

  s.subspec 'NSNumber+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/NSNumber+SSToolkitAdditions'
  end

  s.subspec 'NSString+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/NSString+SSToolkitAdditions'
    sp.dependency 'SSToolkit/NSData+SSToolkitAdditions'
  end

  s.subspec 'NSURL+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/NSURL+SSToolkitAdditions'
    sp.dependency 'SSToolkit/NSDictionary+SSToolkitAdditions'
  end
  
  s.subspec 'SSAddressBarTextField' do |sp|
    sp.source_files = 'SSToolkit/SSAddressBarTextField'
    sp.dependency 'SSToolkit/SSTextField'
    sp.dependency 'SSToolkit/SSAddressBarTextFieldBackgroundView'
    sp.dependency 'SSToolkit/SSDrawingUtilities'
  end

  s.subspec 'SSAddressBarTextFieldBackgroundView' do |sp|
    sp.source_files = 'SSToolkit/SSAddressBarTextFieldBackgroundView'
    sp.dependency 'SSToolkit/SSAddressBarTextFieldBackgroundViewInnerView'
    sp.dependency 'SSToolkit/UIView+SSToolkitAdditions'
  end

  s.subspec 'SSAddressBarTextFieldBackgroundViewInnerView' do |sp|
    sp.source_files = 'SSToolkit/SSAddressBarTextFieldBackgroundViewInnerView'
    sp.dependency 'SSToolkit/UIImage+SSToolkitAdditions'
  end

  s.subspec 'SSAnimatedImageView' do |sp|
    sp.source_files = 'SSToolkit/SSAnimatedImageView'
  end

  s.subspec 'SSBadgeTableViewCell' do |sp|
    sp.source_files = 'SSToolkit/SSBadgeTableViewCell'
    sp.dependency 'SSToolkit/SSBadgeView'
  end

  s.subspec 'SSBadgeView' do |sp|
    sp.source_files = 'SSToolkit/SSBadgeView'
    sp.dependency 'SSToolkit/SSLabel'
    sp.dependency 'SSToolkit/SSDrawingUtilities'
  end

  s.subspec 'SSBorderedView' do |sp|
    sp.source_files = 'SSToolkit/SSBorderedView'
    sp.dependency 'SSToolkit/SSDrawingUtilities'
  end

  s.subspec 'SSButton' do |sp|
    sp.source_files = 'SSToolkit/SSButton'
  end

  s.subspec 'SSCategories' do |sp|
    sp.source_files = 'SSToolkit/SSCategories'
    sp.dependency 'SSToolkit/NSArray+SSToolkitAdditions'
    sp.dependency 'SSToolkit/NSMutableArray+SSToolkitAdditions'
    sp.dependency 'SSToolkit/NSData+SSToolkitAdditions'
    sp.dependency 'SSToolkit/NSDate+SSToolkitAdditions'
    sp.dependency 'SSToolkit/NSDictionary+SSToolkitAdditions'
    sp.dependency 'SSToolkit/NSString+SSToolkitAdditions'
    sp.dependency 'SSToolkit/NSURL+SSToolkitAdditions'
    sp.dependency 'SSToolkit/UIApplication+SSToolkitAdditions'
    sp.dependency 'SSToolkit/UIColor+SSToolkitAdditions'
    sp.dependency 'SSToolkit/UIControl+SSToolkitAdditions'
    sp.dependency 'SSToolkit/UIDevice+SSToolkitAdditions'
    sp.dependency 'SSToolkit/UIImage+SSToolkitAdditions'
    sp.dependency 'SSToolkit/UIScreen+SSToolkitAdditions'
    sp.dependency 'SSToolkit/UIScrollView+SSToolkitAdditions'
    sp.dependency 'SSToolkit/UIView+SSToolkitAdditions'
    sp.dependency 'SSToolkit/UIViewController+SSToolkitAdditions'
  end

  s.subspec 'SSCollectionView' do |sp|
    sp.source_files = 'SSToolkit/SSCollectionView'
    sp.dependency 'SSToolkit/SSCollectionViewItem'
    sp.dependency 'SSToolkit/SSCollectionViewInternal'
    sp.dependency 'SSToolkit/SSCollectionViewItemInternal'
    sp.dependency 'SSToolkit/SSCollectionViewItemTableViewCell'
    sp.dependency 'SSToolkit/SSCollectionViewExtremityTableViewCell'
    sp.dependency 'SSToolkit/SSCollectionViewTableView'
    sp.dependency 'SSToolkit/SSDrawingUtilities'
    sp.dependency 'SSToolkit/UIView+SSToolkitAdditions'
  end

  s.subspec 'SSCollectionViewController' do |sp|
    sp.source_files = 'SSToolkit/SSCollectionViewController'
    sp.dependency 'SSToolkit/SSCollectionView'
    sp.dependency 'SSToolkit/SSDrawingUtilities'
  end

  s.subspec 'SSCollectionViewExtremityTableViewCell' do |sp|
    sp.source_files = 'SSToolkit/SSCollectionViewExtremityTableViewCell'
  end

  s.subspec 'SSCollectionViewInternal' do |sp|
    sp.source_files = 'SSToolkit/SSCollectionViewInternal'
  end

  s.subspec 'SSCollectionViewItem' do |sp|
    sp.source_files = 'SSToolkit/SSCollectionViewItem'
    sp.dependency 'SSToolkit/SSCollectionViewItemInternal'
    sp.dependency 'SSToolkit/SSCollectionView'
    sp.dependency 'SSToolkit/SSCollectionViewInternal'
    sp.dependency 'SSToolkit/SSLabel'
    sp.dependency 'SSToolkit/SSDrawingUtilities'
  end

  s.subspec 'SSCollectionViewItemInternal' do |sp|
    sp.source_files = 'SSToolkit/SSCollectionViewItemInternal'
  end

  s.subspec 'SSCollectionViewItemTableViewCell' do |sp|
    sp.source_files = 'SSToolkit/SSCollectionViewItemTableViewCell'
    sp.dependency 'SSToolkit/SSCollectionViewItem'
    sp.dependency 'SSToolkit/SSCollectionView'
    sp.dependency 'SSToolkit/SSCollectionViewInternal'
  end

  s.subspec 'SSCollectionViewTableView' do |sp|
    sp.source_files = 'SSToolkit/SSCollectionViewTableView'
  end

  s.subspec 'SSConcurrentOperation' do |sp|
    sp.source_files = 'SSToolkit/SSConcurrentOperation'
  end

  s.subspec 'SSDrawingUtilities' do |sp|
    sp.source_files = 'SSToolkit/SSDrawingUtilities'
  end

  s.subspec 'SSGradientView' do |sp|
    sp.source_files = 'SSToolkit/SSGradientView'
    sp.dependency 'SSToolkit/SSBorderedView'
    sp.dependency 'SSToolkit/SSDrawingUtilities'
  end

  s.subspec 'SSHUDView' do |sp|
    sp.source_files = 'SSToolkit/SSHUDView'
    sp.dependency 'SSToolkit/SSHUDWindow'
    sp.dependency 'SSToolkit/SSDrawingUtilities'
    sp.dependency 'SSToolkit/UIView+SSToolkitAdditions'
    sp.dependency 'SSToolkit/NSBundle+SSToolkitAdditions'
    sp.dependency 'SSToolkit/UIImage+SSToolkitAdditions'
  end

  s.subspec 'SSHUDWindow' do |sp|
    sp.source_files = 'SSToolkit/SSHUDWindow'
    sp.dependency 'SSToolkit/SSDrawingUtilities'
    sp.dependency 'SSToolkit/UIImage+SSToolkitAdditions'
  end

  s.subspec 'SSLabel' do |sp|
    sp.source_files = 'SSToolkit/SSLabel'
  end

  s.subspec 'SSLineView' do |sp|
    sp.source_files = 'SSToolkit/SSLineView'
  end

  s.subspec 'SSLoadingView' do |sp|
    sp.source_files = 'SSToolkit/SSLoadingView'
  end

  s.subspec 'SSPickerViewController' do |sp|
    sp.source_files = 'SSToolkit/SSPickerViewController'
  end

  s.subspec 'SSPieProgressView' do |sp|
    sp.source_files = 'SSToolkit/SSPieProgressView'
    sp.dependency 'SSToolkit/SSDrawingUtilities'
  end

  s.subspec 'SSRateLimit' do |sp|
    sp.source_files = 'SSToolkit/SSRateLimit'
  end

  s.subspec 'SSRatingPicker' do |sp|
    sp.source_files = 'SSToolkit/SSRatingPicker'
    sp.dependency 'SSToolkit/UIImage+SSToolkitAdditions'
    sp.dependency 'SSToolkit/UIView+SSToolkitAdditions'
  end

  s.subspec 'SSRatingPickerScrollView' do |sp|
    sp.source_files = 'SSToolkit/SSRatingPickerScrollView'
    sp.dependency 'SSToolkit/SSGradientView'
    sp.dependency 'SSToolkit/SSRatingPicker'
    sp.dependency 'SSToolkit/SSTextField'
    sp.dependency 'SSToolkit/SSTextView'
    sp.dependency 'SSToolkit/SSDrawingUtilities'
  end

  s.subspec 'SSRatingPickerViewController' do |sp|
    sp.source_files = 'SSToolkit/SSRatingPickerViewController'
    sp.dependency 'SSToolkit/SSRatingPickerScrollView'
    sp.dependency 'SSToolkit/SSRatingPicker'
    sp.dependency 'SSToolkit/SSTextField'
    sp.dependency 'SSToolkit/SSTextView'
    sp.dependency 'SSToolkit/UIScreen+SSToolkitAdditions'
  end

  s.subspec 'SSTextField' do |sp|
    sp.source_files = 'SSToolkit/SSTextField'
    sp.dependency 'SSToolkit/SSDrawingUtilities'
  end

  s.subspec 'SSTextView' do |sp|
    sp.source_files = 'SSToolkit/SSTextView'
  end

  s.subspec 'SSToolkit' do |sp|
    sp.source_files = 'SSToolkit/SSToolkit'
    sp.dependency 'SSToolkit/SSAnimatedImageView'
    sp.dependency 'SSToolkit/SSBadgeView'
    sp.dependency 'SSToolkit/SSBorderedView'
    sp.dependency 'SSToolkit/SSCollectionView'
    sp.dependency 'SSToolkit/SSCollectionViewItem'
    sp.dependency 'SSToolkit/SSGradientView'
    sp.dependency 'SSToolkit/SSHUDView'
    sp.dependency 'SSToolkit/SSLabel'
    sp.dependency 'SSToolkit/SSLineView'
    sp.dependency 'SSToolkit/SSLoadingView'
    sp.dependency 'SSToolkit/SSPieProgressView'
    sp.dependency 'SSToolkit/SSWebView'
    sp.dependency 'SSToolkit/SSBadgeTableViewCell'
    sp.dependency 'SSToolkit/SSAddressBarTextField'
    sp.dependency 'SSToolkit/SSButton'
    sp.dependency 'SSToolkit/SSTextField'
    sp.dependency 'SSToolkit/SSTextView'
    sp.dependency 'SSToolkit/SSRatingPicker'
    sp.dependency 'SSToolkit/SSCollectionViewController'
    sp.dependency 'SSToolkit/SSPickerViewController'
    sp.dependency 'SSToolkit/SSRatingPickerViewController'
    sp.dependency 'SSToolkit/SSWebViewController'
    sp.dependency 'SSToolkit/SSConcurrentOperation'
    sp.dependency 'SSToolkit/SSDrawingUtilities'
    sp.dependency 'SSToolkit/SSRateLimit'
  end

  s.subspec 'SSToolkitDefines' do |sp|
    sp.source_files = 'SSToolkit/SSToolkitDefines'
  end

  s.subspec 'SSWebView' do |sp|
    sp.source_files = 'SSToolkit/SSWebView'
    sp.dependency 'SSToolkit/NSString+SSToolkitAdditions'
  end

  s.subspec 'SSWebViewController' do |sp|
    sp.source_files = 'SSToolkit/SSWebViewController'
    sp.dependency 'SSToolkit/SSWebView'
    sp.dependency 'SSToolkit/UIImage+SSToolkitAdditions'
  end

  s.subspec 'UIApplication+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/UIApplicaton+SSToolkitAdditions'
  end

  s.subspec 'UIColor+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/UIColor+SSToolkitAdditions'
  end

  s.subspec 'UIControl+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/UIControl+SSToolkitAdditions'
  end

  s.subspec 'UIDevice+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/UIDevice+SSToolkitAdditions'
  end

  s.subspec 'UIImage+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/UIImage+SSToolkitAdditions'
  end

  s.subspec 'UIScreen+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/UIScreen+SSToolkitAdditions'
  end

  s.subspec 'UIScrollView+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/UIScrollView+SSToolkitAdditions'
  end

  s.subspec 'UIView+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/UIView+SSToolkitAdditions'
  end

  s.subspec 'UIViewController+SSToolkitAdditions' do |sp|
    sp.source_files = 'SSToolkit/UIViewController+SSToolkitAdditions'
  end

  def s.post_install(target_installer)
    puts "\nGenerating SSToolkit resources bundle\n".yellow if config.verbose?
    Dir.chdir File.join(config.project_pods_root, 'SSToolkit') do
      command = "xcodebuild -project SSToolkit.xcodeproj -target SSToolkitResources CONFIGURATION_BUILD_DIR=./"
      command << " 2>&1 > /dev/null" unless config.verbose?
      unless system(command)
        raise ::Pod::Informative, "Failed to generate SSToolkit resources bundle"
      end
    end
    if Version.new(Pod::VERSION) >= Version.new('0.16.999')
      script_path = target_installer.copy_resources_script_path
    else
      script_path = File.join(config.project_pods_root, target_installer.target_definition.copy_resources_script_name)
    end
    File.open(script_path, 'a') do |file|
      file.puts "install_resource 'SSToolkit/SSToolkitResources.bundle'"
    end
  end
end
