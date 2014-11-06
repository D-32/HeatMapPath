Pod::Spec.new do |s|
  s.name             = "HeatMapPath"
  s.version          = "1.0.0"
  s.summary          = "Goal-Based vector field path finding."
  s.homepage         = "https://github.com/d-32/HeatMapPath"
  s.license          = 'MIT'
  s.author           = { "Dylan Marriott" => "info@d-32.com" }
  s.source           = { :git => "https://github.com/d-32/HeatMapPath.git", :tag => s.version.to_s }
  s.social_media_url = "https://twitter.com/dylan36032"
  s.screenshot  	 = "http://46.105.26.1/uploads/heatmap.png"
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'HeatMapPath' => ['Pod/Assets/*.png']
  }
end