Pod::Spec.new do |s|
  s.name         = "IBFakery"
  s.version      = "0.0.1"
  s.summary      = "Design and prototype UI by filling UI component in Interface Builder with fake data generator."
  s.homepage     = "https://github.com/IBAnimatable/IBFakery"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "IBAnimatable" => "eric.marchand.n7@gmail.com" }
  s.platform     = :ios, '10.0'
  s.source       = { :git => "https://github.com/IBAnimatable/IBFakery.git", tag: "#{s.version}" }
  s.source_files = "Sources/*.swift"
  s.dependency "Fakery"
end
