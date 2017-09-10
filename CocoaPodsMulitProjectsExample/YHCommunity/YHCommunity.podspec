Pod::Spec.new do |s|
    s.name = 'YHCommunity'
    s.version = '2.0'
    s.license = 'Commercial'
    s.homepage = 'https://www.yhouse.com/'
    s.author = 'YHOUSE'
    s.summary = 'YHCommunity'
    s.platform = :ios, '7.0'
    s.source_files = ['YHCommunity/**/**/*.{h,m,c}']
    s.public_header_files = ['YHCommunity/**/**/*.{h,c}']
    s.resources = ["YHCommunity/*.xcassets", "YHCommunity/**/*.xib", "YHCommunity/Community/**/*"]
    s.exclude_files = "YHCommunity/AppDelegate.{h,m}", "YHCommunity/**/main.m", "YHCommunity/ViewController.{h,m}"
    s.dependency 'YHLibrary'
    s.source = { :path => 'YHCommunity' }
end
