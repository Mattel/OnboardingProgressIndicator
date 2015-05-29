Pod::Spec.new do |s|
  s.name      = 'STOnboardingProgressView'
  s.version   = '1.0'
  s.platform  = :ios, '8.0'
  s.summary   = 'Custom view used to indicate progress in a multi-step flow.'
  s.homepage  = 'http://sproutling.com'
  s.authors   = { 'Camille Kander' => 'camille@sproutling.com' }
  s.source    = { :git => 'https://github.com/Sproutling/OnboardingProgressIndicator.git', :tag => s.version.to_s }
  s.license      = { :type => 'No License', :file => 'LICENSE' }
  s.source_files = 'OnboardingProgressIndicator/{STOnboardingProgressView.swift,LICENSE}'
  s.requires_arc = true
end