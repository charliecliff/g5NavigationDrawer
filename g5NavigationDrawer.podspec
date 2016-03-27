#
# Be sure to run `pod lib lint g5NavigationDrawer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "g5NavigationDrawer"
  s.version          = "0.1.1"
  s.summary          = "g5NavigationDrawer."
  s.description      = "A Helpul UI Framework for building out a simple Navigation Drawer"

  s.homepage         = "https://github.com/charliecliff/g5NavigationDrawer"
  s.license          = 'MIT'
  s.author           = { "cliffhanger62" => "charlie.cliff@gmail.com" }
  s.source           = { :git => "https://github.com/charliecliff/g5NavigationDrawer.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'g5NavigationDrawer' => ['Pod/Assets/**/*']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
end
