//
//  DataHandleProtobuf.swift
//  CoreBluetoothClassicSample
//
//  Created by A$CE on 2020/1/14.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class DataHandleProtobuf: NSObject {
    func deviceInfoRequest() -> Data {
        let diO = DevInfoOperation.read
        var diR = DeviceInfoRequest.init()
        diR.reserved = 123
        diR.operation = diO
        let binaryData: Data = try! diR.serializedData()
        return binaryData
    }
}

