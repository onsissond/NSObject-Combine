Pod::Spec.new do |s|
  s.name         = "NSObject+Combine"
  s.version      = "1.0.1"
  s.summary      = "Handy Combine extensions on NSObject."
  s.description  = <<-DESC
    Right now, we just have a `cancellable` property, but we're open to PRs!
                   DESC
  s.homepage     = "https://github.com/onsissond/NSObject-Combine"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Evgenii Sukhanov" => "onsissond@gmail.com" }

  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.watchos.deployment_target = '6.0'
  s.tvos.deployment_target = '13.0'

  s.swift_version = '5.2'
  s.source       = { :git => "https://github.com/onsissond/NSObject-Combine.git", :tag => s.version }
  s.source_files  = %w(NSObject+Combine.swift HasCancellable.swift CombineDisposeBag.swift)
  s.frameworks  = "Foundation"
  s.frameworks  = "Combine"
end
