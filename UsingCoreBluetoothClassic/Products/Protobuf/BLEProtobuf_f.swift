//
//  BLEProtobuf_f.swift
//  CoreBluetoothClassicSample
//
//  Created by A$CE on 2020/1/14.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

public typealias PB_Opt_Uint_Code = UInt16

struct PB_Opt {
    static let DeviceInfo:PB_Opt_Uint_Code = 0x0000
    static let PeerInfo:PB_Opt_Uint_Code = 0x0001
    static let MsgNotify:PB_Opt_Uint_Code = 0x0002
    static let Weather:PB_Opt_Uint_Code = 0x0003
    static let AlarmClock:PB_Opt_Uint_Code = 0x0004
    static let Sedentariness:PB_Opt_Uint_Code = 0x0005
    static let DeviceConfig:PB_Opt_Uint_Code = 0x0006
    static let Calendar:PB_Opt_Uint_Code = 0x0007
    static let MotorConfig:PB_Opt_Uint_Code = 0x0008
    static let DataInfo:PB_Opt_Uint_Code = 0x0009

    static let CustomDial:PB_Opt_Uint_Code = 0x000E
    
    static let RealTimeData:PB_Opt_Uint_Code = 0x0070
    static let HistoryData:PB_Opt_Uint_Code = 0x0080
    static let FileUpdate:PB_Opt_Uint_Code = 0x0090

    static let DebugConfig:PB_Opt_Uint_Code =  0xFFFE
    static let ConnectionParams:PB_Opt_Uint_Code =  0xFFFF
    
    static let OutOfConfigRanger = 0x10000
}

