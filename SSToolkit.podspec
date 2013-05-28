Pod::Spec.new do |s|
  s.name         = 'SSToolkit'
  s.version      = '1.1'
  s.platform     = :ios
  s.summary      = 'A collection of well-documented iOS classes for making life easier.'
  s.homepage     = 'http://sstoolk.it'
  s.author       = { 'Sam Soffes' => 'sam@soff.es' }
  s.source       = { :git => 'https://github.com/soffes/sstoolkit.git', :tag => "v#{s.version}" }
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
    sp.subspec 'SSAddressBarTextFieldBackgroundView' do |ssp|
      ssp.source_files = 'SSToolkit/SSAddressBarTextFieldBackgroundView'
      ssp.subspec 'SSAddressBarTextFieldBackgroundViewInnerView' do |sbsp|
        sbsp.source_files = 'SSToolkit/SSAddressBarTextFieldBackgroundViewInnerView'
        sbsp.dependency 'SSToolkit/UIImage+SSToolkitAdditions'
      end

      ssp.dependency 'SSToolkit/UIView+SSToolkitAdditions'
    end

    sp.dependency 'SSToolkit/SSTextField'
    sp.dependency 'SSToolkit/SSDrawingUtilities'
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
    
    sp.subspec 'SSCollectionViewItem' do |ssp|
      ssp.source_files = 'SSToolkit/SSCollectionViewItem'
      ssp.dependency 'SSToolkit/SSLabel'
    end
    
    sp.subspec 'SSCollectionViewInternal' do |ssp|
      ssp.source_files = 'SSToolkit/SSCollectionViewInternal'
    end

    sp.subspec 'SSCollectionViewItemInternal' do |ssp|
      ssp.source_files = 'SSToolkit/SSCollectionViewItemInternal'
    end

    sp.subspec 'SSCollectionViewItemTableViewCell' do |ssp|
      ssp.source_files = 'SSToolkit/SSCollectionViewItemTableViewCell'
    end

    sp.subspec 'SSCollectionViewExtremityTableViewCell' do |ssp|
      ssp.source_files = 'SSToolkit/SSCollectionViewExtremityTableViewCell'
    end

    sp.subspec 'SSCollectionViewTableView' do |ssp|
      ssp.source_files = 'SSToolkit/SSCollectionViewTableView'
    end
    
    sp.dependency 'SSToolkit/SSDrawingUtilities'
    sp.dependency 'SSToolkit/UIView+SSToolkitAdditions'
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
    sp.subspec 'SSHUDWindow' do |ssp|
      ssp.source_files = 'SSToolkit/SSHUDWindow'
      ssp.dependency 'SSToolkit/SSDrawingUtilities'
      ssp.dependency 'SSToolkit/UIImage+SSToolkitAdditions'
    end

    sp.dependency 'SSToolkit/UIView+SSToolkitAdditions'
    sp.dependency 'SSToolkit/NSBundle+SSToolkitAdditions'
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

  s.subspec 'SSRatingPickerViewController' do |sp|
    sp.source_files = 'SSToolkit/SSRatingPickerViewController'
    sp.subspec 'SSRatingPickerScrollView' do |ssp|
      ssp.source_files = 'SSToolkit/SSRatingPickerScrollView'
      ssp.dependency 'SSToolkit/SSGradientView'
      ssp.dependency 'SSToolkit/SSTextField'
      ssp.dependency 'SSToolkit/SSTextView'
    end

    sp.dependency 'SSToolkit/SSRatingPicker'
    sp.dependency 'SSToolkit/UIScreen+SSToolkitAdditions'
  end

  s.subspec 'SSTextField' do |sp|
    sp.source_files = 'SSToolkit/SSTextField'
    sp.dependency 'SSToolkit/SSDrawingUtilities'
  end

  s.subspec 'SSTextView' do |sp|
    sp.source_files = 'SSToolkit/SSTextView'
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
    if Version.new(Pod::VERSION) >= Version.new('0.16.999')
      sandbox_root = target.sandbox_dir
    else
      sandbox_root = config.project_pods_root
    end

    Dir.chdir File.join(sandbox_root, 'SSToolkit') do
      command = "xcodebuild -project SSToolkit.xcodeproj -target SSToolkitResources CONFIGURATION_BUILD_DIR=./"
      command << " 2>&1 > /dev/null"
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
