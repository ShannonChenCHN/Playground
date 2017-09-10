Pod::Spec.new do |s|
    s.name = 'YHLibrary'
    s.version = '2.0'
    s.license = 'Commercial'
    s.homepage = 'https://www.yhouse.com/'
    s.author = 'YHOUSE'
    s.summary = 'YHLibrary'
    s.platform = :ios, '7.0'
    s.source_files = 'Library/**/*.{h,m}'
    s.public_header_files = ["Library/**/*.h"]
    s.vendored_libraries = 'Library/**/*.a'
    s.vendored_frameworks = 'Library/**/*.framework'
    s.resources = ["**/*.xcassets", "Library/**/*.png", "Library/**/*.bundle", "Resources/**/*"]
    s.source = { :path => 'YHLibrary' }
end
