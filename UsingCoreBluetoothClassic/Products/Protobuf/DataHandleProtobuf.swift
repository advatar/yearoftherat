//
//  DataHandleProtobuf.swift
//  CoreBluetoothClassicSample
//
//  Created by A$CE on 2020/1/14.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

enum RTDataSbscrbr {
    case readTime
    case readBattery
    case readHealth
    case easyCameraOn
    case easyCameraOff
}

class DataHandleProtobuf: NSObject {
    //MARK: Request
    func deviceInfoRequest() -> Data {
        let diO = DevInfoOperation.read
        var diR = DeviceInfoRequest.init()
        diR.reserved = 123
        diR.operation = diO
        let binaryData: Data = try! diR.serializedData()
        return binaryData
    }
    
    func dataInfoRequest() -> Data {
        let diR = DataInfoRequest.init()
        let binaryData: Data = try! diR.serializedData()
        return binaryData
    }
    
    //MARK: Subscriber
    func realTimeDataSubscriber(rtDSB: RTDataSbscrbr) -> Data {
        var rtSBR = RtSubscriber.init()
        switch rtDSB {
        case .readTime:
            rtSBR.time = RtSync.onlyOnce
        case .readBattery:
            rtSBR.battery = RtSync.onlyOnce
        case .readHealth:
            rtSBR.health = RtSync.onlyOnce
        case .easyCameraOn:
            rtSBR.mode = RtMode.enterCamera
        case .easyCameraOff:
            rtSBR.mode = RtMode.backNormal
        }
        let binaryData: Data = try! rtSBR.serializedData()
        return binaryData
    }
    
    func historyDataIndexTable(idSync: HisITSync) -> Data {
        var hS = HisSubscriber.init()
        hS.operation = HisOperation.itSync
        hS.itSync = idSync
        let binaryData: Data = try! hS.serializedData()
        return binaryData
    }

    func historyDataStart(idSync: HisStartSync) -> Data {
        var hS = HisSubscriber.init()
        hS.operation = HisOperation.startSync
        hS.startSync = idSync
        let binaryData: Data = try! hS.serializedData()
        return binaryData
    }
    
    
    //MARK: Information
    func peerInformationDateTime(gpbConf: DateTime) -> Data {
        var piN = PeerInfoNotification.init()
        piN.dateTime = gpbConf;
        piN.peerType = PeerInfoNotification.PeerType.appIos;
        let binaryData: Data = try! piN.serializedData()
        return binaryData
    }
    func peerInformationGnss(gpbConf: GnssConf) -> Data {
        var piN = PeerInfoNotification.init()
        piN.gnssConf = gpbConf;
        piN.peerType = PeerInfoNotification.PeerType.appIos;
        let binaryData: Data = try! piN.serializedData()
        return binaryData
    }
    func peerInformationHrAlarm(gpbConf: HrAlarmConf) -> Data {
        var piN = PeerInfoNotification.init()
        piN.hrAlarmConf = gpbConf;
        piN.peerType = PeerInfoNotification.PeerType.appIos;
        let binaryData: Data = try! piN.serializedData()
        return binaryData
    }
    func peerInformationUserConf(gpbConf: UserConf) -> Data {
        var piN = PeerInfoNotification.init()
        piN.userConf = gpbConf;
        piN.peerType = PeerInfoNotification.PeerType.appIos;
        let binaryData: Data = try! piN.serializedData()
        return binaryData
    }
    func peerInformationGoalConf(gpbConf: GoalConf) -> Data {
        var piN = PeerInfoNotification.init()
        piN.goalConf = gpbConf;
        piN.peerType = PeerInfoNotification.PeerType.appIos;
        let binaryData: Data = try! piN.serializedData()
        return binaryData
    }
    func peerInformationBpcaliConf(gpbConf: BpCaliConf) -> Data {
        var piN = PeerInfoNotification.init()
        piN.bpcaliConf = gpbConf;
        piN.peerType = PeerInfoNotification.PeerType.appIos;
        let binaryData: Data = try! piN.serializedData()
        return binaryData
    }
    func peerInformationAfConf(gpbConf: AfConf) -> Data {
        var piN = PeerInfoNotification.init()
        piN.afConf = gpbConf;
        piN.peerType = PeerInfoNotification.PeerType.appIos;
        let binaryData: Data = try! piN.serializedData()
        return binaryData
    }

    func messageNotifyInformationMsgHandler(msgConf: MsgHandler) -> Data {
        var msgN = MsgNotification.init()
        msgN.handler = msgConf
        let binaryData: Data = try! msgN.serializedData()
        return binaryData
    }
    func messageNotifyInformationMsgFilter(msgConf: MsgFilter) -> Data {
        var msgN = MsgNotification.init()
        msgN.filter = msgConf
        let binaryData: Data = try! msgN.serializedData()
        return binaryData
    }
    func messageNotifyInformationMsgNotify(msgConf: MsgNotify) -> Data {
        var msgN = MsgNotification.init()
        msgN.notify = msgConf
        let binaryData: Data = try! msgN.serializedData()
        return binaryData
    }
    
    //MARK: Config
    func g24WeatherGroupData(weather: WeatherGroup) -> Data {
        var wN = WeatherNotification.init()
        wN.operation = WeatherOperation.add
        wN.group = weather
        let binaryData: Data = try! wN.serializedData()
        return binaryData
    }

    func g24WeatherClear() -> Data {
        var wN = WeatherNotification.init()
        wN.operation = WeatherOperation.clear
        let binaryData: Data = try! wN.serializedData()
        return binaryData
    }

    func alarmClcoksAddData(alarmClock: AlarmGroup) -> Data {
        var aN = AlarmNotification.init()
        aN.operation = AlarmOperation.add
        aN.group = alarmClock
        let binaryData: Data = try! aN.serializedData()
        return binaryData
    }
    
    func alarmClcoksRemoveData(alarmClock: AlarmIDList) -> Data {
        var aN = AlarmNotification.init()
        aN.operation = AlarmOperation.remove
        aN.idList = alarmClock
        let binaryData: Data = try! aN.serializedData()
        return binaryData
    }

    func alarmClcoksClearData() -> Data {
        var aN = AlarmNotification.init()
        aN.operation = AlarmOperation.clear;
        aN.reserved = 123;
        let binaryData: Data = try! aN.serializedData()
        return binaryData
    }
}


