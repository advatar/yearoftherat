Pod::Spec.new do |s|

s.name         = 'GengziRat'

s.version      = "0.0.2"

s.summary      = 'BLE SDK in Swift. Developed by iwown iOS developer team'

s.license      = 'BSD 3-Clause'

s.author       = { "xuezou" => "377949550@qq.com" }

s.homepage     = 'https://github.com/iwown/BLE_SDK_2020'

s.source       = { :git => "https://github.com/iwown/BLE_SDK_2020.git", :tag => s.version}

s.source_files = "UsingCoreBluetoothClassic/Products/", "UsingCoreBluetoothClassic/Products/pb_instance_swift", "UsingCoreBluetoothClassic/Products/pb_instance_swift/*.swift", "UsingCoreBluetoothClassic/Products/Protobuf", "UsingCoreBluetoothClassic/Products/Protobuf/*.swift"

s.platform     = :ios, "10.0"

s.requires_arc = true

s.dependency 'SwiftProtobuf'

end
