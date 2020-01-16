//
//  LogManager.swift
//  CoreBluetoothClassicSample
//
//  Created by A$CE on 2020/1/13.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class LogManager: NSObject {
    public var textContent: String = ""
    
    static let sharedInstance: LogManager = {
          let instance = LogManager()
          // setup code
          return instance
    }()

    public func addLogs(text : String) {
        let log:String = "\(Date()): " + text + "\n"
        textContent = textContent + log
    }
    
    public func saveLogs() {
        // 将textContent 写入本地文件
    }
}
