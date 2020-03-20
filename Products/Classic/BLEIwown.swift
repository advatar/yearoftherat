//
//  BLEIwown.swift
//  GengziRat
//
//  Created by A$CE on 2020/3/19.
//  Copyright © 2020 iwown. All rights reserved.
//

import Foundation

public struct IWOWN_UUID_STR {
    public static let serviceUuid:String = "FF20"
    public static let notifyUuid:String = "FF23"
    public static let writeUuid:String = "FF21"
}

public protocol BleIwownDelegate: class {
    //DEVICE
    func bleIwownDidRecieveDeviceInfo(deviceInfo: IW_DeivceInfo)
    func bleIwownDidRecieveBatteryInfo(batteryInfo: IW_BatteryInfo)

   /*
    steps: 1827
    distance: 11176 (unit is 0.1 m)
    calorie: 596 (unit is 0.1 kcal)
    */
    func bleIwownDidRecieveRealTimeData(rtData: IW_HealthSummary)
    /**hsData is nil means end of reciver*/
    func bleIwownDidRecieveSportData(hsData: IW_HealthSport?)
}

class BLEIwown: NSObject {
    
    let dataHandle:DataHandleIwown = DataHandleIwown()
    let dataParser:DataParseIwown = DataParseIwown()
    let dataHelper:DataHelperIwown = DataHelperIwown()
    
    func registerIwownDelegate(d: BleIwownDelegate) -> Void {
        dataParser.biDelegate = d
    }
    
    //MARK: @Public
    //MARK: cmds
    public func getDeviceInfo() -> Data {
        return dataHandle.dataWithGroupCmds(grp: IW_CMD_GRP.DEVICE, cmd: IV_CMD_ID.DEVICE_GET_INFORMATION, sData: nil).first!
    }
    
    public func getBattery() -> Data {
        return dataHandle.dataWithGroupCmds(grp: IW_CMD_GRP.DEVICE, cmd: IV_CMD_ID.DEVICE_GET_BATTERY, sData: nil).first!
    }
    
    public func syscTime(date : Date) -> Data {
        return dataHandle.dataWithGroupCmds(grp: IW_CMD_GRP.CONFIG, cmd: IV_CMD_ID.CONFIG_SET_TIME, sData: dataHelper.getDataInTime(date: date)).first!
    }
    
    public func syncDataSummary29() -> Data {
        return dataHandle.dataWithGroupCmds(grp: IW_CMD_GRP.DATALOG, cmd: IV_CMD_ID.DATALOG_GET_CUR_SPORTDATA, sData: nil).first!
    }
    
    public func syncDataDetail28() -> Data {
        return dataHandle.dataWithGroupCmds(grp: IW_CMD_GRP.DATALOG, cmd: IV_CMD_ID.DATALOG_GET_SPORTDATA, sData: nil).first!
    }
    
    //MARK: receive data
    var _recvFinished = true
    var _recvData:Data = Data()
    var _dataLength:UInt = 0
    let LENGTH_OF_HEADER:Int = 4
    func braceletCmdReceive(data: Data) -> Void {
        if data.isEmpty {
            return
        }
        
        if _recvFinished {
            if !self.prefixCheck(data: data) {
                // 数据头错误，返回
                return
            }
            _dataLength = self.getDataLength(data: data)
            _recvData = data
        } else {
            _recvData.append(data)
        }
       
        if (_recvData.count-LENGTH_OF_HEADER) == _dataLength {
            self.dataCheck(data: _recvData)
            _recvData = Data()
            _recvFinished = true
        }else {
            _recvFinished = false
        }
    }
    
    func getDataLength(data: Data) -> UInt {
        let byteA = data[3]
        return UInt(byteA)
    }
    
    func prefixCheck(data: Data) -> Bool {
        if data.count < LENGTH_OF_HEADER {
            return false
        }
        
        let perfixData = data.subdata(in: 0..<2)
        let byteA = perfixData[0]
        let byteB = perfixData[1]
        let isNewPerfix = (byteA == 0x21) && (byteB == 0xff)
        return isNewPerfix
    }
    
    func dataCheck(data: Data) -> Void {
            if data.count < LENGTH_OF_HEADER {
                print("DATA LENGTH ERROR【 \(data) 】")
                return
            }
        
            let ptCode = UInt8(data[3])
            let payloadData = data.subdata(in: LENGTH_OF_HEADER..<data.count)
            
            dataParser.parseDataInIwown(ptCode: ptCode, payload: payloadData)
        }

}