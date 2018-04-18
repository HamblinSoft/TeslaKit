# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

inhibit_all_warnings!

def common_pods
    pod 'ObjectMapper', '~> 3.1'
end

target 'TeslaKit' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TeslaKit
  common_pods
  pod 'SwiftLint'

end

target 'Example' do
    use_frameworks!

    pod 'TeslaKit', :path => './'

    target 'Tests' do
        inherit! :search_paths

        use_frameworks!
    end
end


