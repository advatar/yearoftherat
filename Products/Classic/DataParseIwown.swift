//
//  DataParseIwown.swift
//  GengziRat
//
//  Created by A$CE on 2020/3/20.
//  Copyright © 2020 iwown. All rights reserved.
//

import UIKit

public struct IW_DeivceInfo {
    public var model:String
    public var mac:Data
    public var version:String
}

public struct IW_BatteryInfo {
    public var level:UInt8
}

public struct IW_ManuFactoryDate {
    public var str:String
}

public struct IW_FactoryConf {
    public var str:String
}

public struct IW_HealthSport {
    public var calorie:UInt32
    public var step:UInt32
    public var distance:UInt32
    public var duration:UInt32
    public var type:UInt32
    public var start_time:Date
    public var end_time:Date
    public var seq:UInt32
}

public struct IW_HealthSleep {
    public var seq:UInt32
    public var sleep_type:UInt32
    /**! The same state duration ,unit is minutes*/
    public var activity:UInt32
    /**
     Here for the introduction of the concept of sleep data, each group of data contains such content, the first data sleepType 1, followed by a fixed effective sleep data (sleepType == 3 | sleepType == 4), and finally A data sleepType is 2 (that means the end of the normal, this sleep data is valid) or 5 (that this is a place data, for example, put the bracelet on the table, may produce such data, the algorithm that this is not valid Sleep data, which is disturbing information), some bracelet will produce sleepType == 6 data that awake, you can also use the interval between the two groups that awake
     sleep_enter : The start of the group is one minute, the date and start_time are the same
     sleep_exit : Similar to sleep_enter.
     mode : 2 or 5.
     */
    public var sleep_enter:UInt32
    public var sleep_exit:UInt32
    public var mode:UInt32

    public var start_time:Date
    public var end_time:Date
}

public struct IW_HealthSummary {
    public var recordDate:Date
    public var calorie:UInt32
    public var step:UInt32
    public var distance:UInt32
}

class DataParseIwown: NSObject {
    
    public var biDelegate:BleIwownDelegate?
    
    //MARK: @Device
    func payloadParserDeviceInfo(payload: Data) -> Void {
        let modelData = payload.subdata(in: 2..<6)
        let verData = payload.subdata(in: 8..<12)
        let macData = payload.subdata(in: 12..<18)
        
        var model:String = ""
        for i in 0..<4 {
            let c = modelData[i]
            let str = String.init(format: "%c", c)
            model = model + str;
        }
        
        var version:String = ""
        for i in 0..<4 {
            let c = verData[i]
            let str = String.init(format: "%d", c)
            version = version + str;
        }
        
        let deviceInfo:IW_DeivceInfo = IW_DeivceInfo(model: model, mac: macData, version: version)
        
        biDelegate?.bleIwownDidRecieveDeviceInfo(deviceInfo: deviceInfo)
    }
    
    func payloadParserBattery(payload: Data) -> Void {
        let byteA = payload[0]
        let level = UInt8(byteA)
        let battery:IW_BatteryInfo = IW_BatteryInfo(level: level)
        biDelegate?.bleIwownDidRecieveBatteryInfo(batteryInfo: battery)
    }
    
    func payloadParserManufactureDate(payload: Data) -> Void {
        let newStr = String(data: payload, encoding: String.Encoding.utf8)
        let str = String.init(format: "23ff0b%02lx%@", payload.count,newStr!)
        let mfDate = IW_ManuFactoryDate(str: str)
        biDelegate?.bleIwownDidRecieveManuFactoryDate(str: mfDate)
    }
    
    func payloadParserfactureConf(payload: Data) -> Void {
        let newStr = String(data: payload, encoding: String.Encoding.utf8)
        let str = String.init(format: "23ff0c%02lx%@", payload.count,newStr!)
        let fc:IW_FactoryConf = IW_FactoryConf(str: str)
        biDelegate?.bleIwownDidRecieveFactoryConf(str: fc)
    }
    //MARK: @Config
    func payloadParserSportList(paylod: Data) -> Void {
        if paylod.count == 0 {
            return
        }
        
        var arr:Array = Array<IW_Sport_Uint_Code>()
          
        for i in 1..<paylod.count {
            let sportType = paylod[i]
            arr.append(IW_Sport_Uint_Code(sportType))
        }
        biDelegate?.bleIwownDidRecieveSupportSportList(arr: arr)
    }
    
    //MARK: @DataLog
    func payloadParserCurSportData(payload: Data) -> Void {
        if (payload.count < 5) {
            print("DATA LENGTH IS TOO SHORT !!! [payloadParserCurSportData]")
            return;
        }
        
        let dateMark = payload.subdata(in: 0..<2)
        
        var recordDate:Date?
        if dateMark[0] == 0xFF &&
            dateMark[1] == 0xFF &&
            dateMark[2] == 0xFF {
            recordDate = Date()
        }else {
            recordDate = dateData(data: dateMark)
        }
        
        let typeNum = Int32(payload[3])
        if typeNum == 0x01 {
            let caloriesData = payload.subdata(in: 4..<8)
            let stepsData = payload.subdata(in: 8..<12)
            let distanceData = payload.subdata(in: 12..<16)

            let calories = uint32Data(data: caloriesData)
            let steps = uint32Data(data: stepsData)
            let distance = uint32Data(data: distanceData)
            let hSport = IW_HealthSummary(recordDate: recordDate!, calorie: UInt32(calories), step: UInt32(steps), distance: UInt32(distance))
            
            self.biDelegate?.bleIwownDidRecieveRealTimeData(rtData: hSport)
        }
    }
    
    func payloadParserSportData(payload: Data) -> Void {
        
        let seqData = payload.subdata(in: 0..<2)
        let byteA = seqData[0]
        let byteB = seqData[1]
        let seqNum = UInt32(byteA) + UInt32(byteB) * 0x100
       
        let dateMark = payload.subdata(in: 0..<2)
       
        if dateMark[0] == 0xFF &&
            dateMark[1] == 0xFF &&
            dateMark[2] == 0xFF {
            print("End Of Sync 29")
            biDelegate?.bleIwownDidRecieveSportData(hsData: nil)
            return;
        }
        
        let recordDate = dateData(data: dateMark)
        let typeNum = Int32(payload[3])
        
        let startMin = uint16Data(data: payload.subdata(in: 4..<6))
        let endMin = uint16Data(data: payload.subdata(in: 6..<8))
        let startDate = recordDate!.addingTimeInterval(TimeInterval(startMin*60))
        var endDate = recordDate!.addingTimeInterval(TimeInterval(endMin*60))
        if (startMin > endMin) {
            endDate = endDate.addingTimeInterval(TimeInterval(3600*24));
        }
        
        let inTypeData = payload.subdata(in: 8..<payload.count)
        if typeNum == 0x00 {
            var sleep:IW_HealthSleep = self.sleepDataParsing(data: inTypeData)
            sleep.start_time = startDate
            sleep.end_time = endDate
        }else {
            var sport:IW_HealthSport = self.sportDataParsing(data: inTypeData)
            sport.type = UInt32(typeNum)
            sport.seq = seqNum
            sport.start_time = startDate
            sport.end_time = endDate
        }
    }
    
    
    //MARK: @Route
    func parseDataInIwown(ptCode: UInt8, payload: Data) ->  Void {
        let grp:IW_CMD_Uint_Code = IW_CMD_Uint_Code(ptCode >> 4)
        let cmd:IW_CMD_Uint_Code = IW_CMD_Uint_Code(ptCode%0x10)
        switch grp {
        case IW_CMD_GRP.DEVICE:
            self.parseDeviceGroup(cmd: cmd, payload: payload)
        case IW_CMD_GRP.CONFIG:
            self.parseConfigGroup(cmd: cmd, payload: payload)
        case IW_CMD_GRP.DATALOG:
            self.parseDataLogGroup(cmd: cmd, payload: payload)
        case IW_CMD_GRP.MSG:
            self.parseMsgGroup(cmd: cmd, payload: payload)
        case IW_CMD_GRP.CTRL:
            self.parseCtrlGroup(cmd: cmd, payload: payload)
        case IW_CMD_GRP.HEARTRATE:
            self.parseHeartRateGroup(cmd: cmd, payload: payload)
        case IW_CMD_GRP.GNSS:
            self.parseGNSSGroup(cmd: cmd, payload: payload)
        default:
            print("parseDataInIwown : 未知协议类型")
        }
    }
    
    func parseDeviceGroup(cmd: IW_CMD_Uint_Code, payload: Data) -> Void {
        switch cmd {
        case IV_CMD_ID.DEVICE_GET_INFORMATION:
            self.payloadParserDeviceInfo(payload: payload)
        case IV_CMD_ID.DEVICE_GET_BATTERY:
            self.payloadParserBattery(payload: payload)
        case IV_CMD_ID.DEVICE_MANUFACTURE_DATE:
            self.payloadParserManufactureDate(payload: payload)
        case IV_CMD_ID.DEVICE_FACTORY_CONF:
            self.payloadParserfactureConf(payload: payload)
        default:
            print("parseDataLogGroup : 未知协议类型")
        }
    }
    
    func parseConfigGroup(cmd: IW_CMD_Uint_Code, payload: Data) -> Void {
        
    }
    
    func parseDataLogGroup(cmd: IW_CMD_Uint_Code, payload: Data) -> Void {
        switch cmd {
        case IV_CMD_ID.DATALOG_GET_SPORTDATA:
            self.payloadParserSportData(payload: payload)
        case IV_CMD_ID.DATALOG_GET_CUR_SPORTDATA:
            self.payloadParserCurSportData(payload: payload)
        default:
            print("parseDataLogGroup : 未知协议类型")
        }
    }
    
    func parseMsgGroup(cmd: IW_CMD_Uint_Code, payload: Data) -> Void {
        
    }
    
    func parseCtrlGroup(cmd: IW_CMD_Uint_Code, payload: Data) -> Void {
        
    }
    
    func parseHeartRateGroup(cmd: IW_CMD_Uint_Code, payload: Data) -> Void {
        switch cmd {
        case IV_CMD_ID.HEARTRATE_DATA:
            print("51 --")
        case IV_CMD_ID.HEARTRATE_HOURS_DATA:
            print("53 --")
        default:
            print("parseHeartRateGroup : 未知协议类型")
        }
    }

    func parseGNSSGroup(cmd: IW_CMD_Uint_Code, payload: Data) -> Void {
        
    }
    
    //MARK: @private
    func dateData(data : Data) -> Date? {
        if data.count < 3 {
            print("Warning data length not match dateData")
            return nil
        }
        
        let yearNum = Int(data[0]) + 2000
        let monthNum = Int(data[1]) + 1
        let dayNum = Int(data[2]) + 1
    
        var hour = 0
        var minute = 0
        if data.count == 5 {
            hour = Int(data[3])
            minute = Int(data[4])
        }
        return Date(year: yearNum, month: monthNum, day: dayNum, hour: hour, minute: minute)
    }
    
    func uint16Data(data : Data) -> Int {
        if data.count != 2 {
            print("Warning data length not match uint16Data")
            return 0
        }
        let dataValue = Int(data[0]) + Int(data[1]) * 0x100
        return dataValue
    }
    
    func uint32Data(data : Data) -> Int {
        if data.count != 4 {
            print("Warning data length not match uint32Data")
            return 0
        }
        let dataValue = Int(data[0]) + Int(data[1]) * 0x100 + Int(data[2]) * 0x10000 + Int(data[3]) * 0x1000000
        return dataValue
    }
    
    func sportDataParsing(data: Data) -> IW_HealthSport {
        let activeMin = uint16Data(data: data.subdata(in: 0..<2))
        let calories = uint16Data(data: data.subdata(in: 2..<4))
        var steps = 0
        if data.count >= 6 {
            steps = uint16Data(data: data.subdata(in: 4..<6))
        }
        var distance = 0
        if data.count >= 8 {
            distance = uint16Data(data: data.subdata(in: 6..<8))
        }
        return IW_HealthSport.init(calorie: UInt32(calories), step: UInt32(steps), distance: UInt32(distance), duration: UInt32(activeMin), type: 0, start_time: Date(), end_time: Date(), seq: 0)
    }
    
    func sleepDataParsing(data: Data) -> IW_HealthSleep {
        let activity = uint16Data(data: data.subdata(in: 0..<2))
        let sleepType = UInt32(data[2])
        let mode = UInt32(data[3])
        let start = uint16Data(data: data.subdata(in: 4..<6))
        let end = uint16Data(data: data.subdata(in: 6..<8))
        let sleep = IW_HealthSleep(seq: 0, sleep_type: sleepType, activity: UInt32(activity), sleep_enter: UInt32(start), sleep_exit: UInt32(end), mode: mode, start_time: Date(), end_time: Date())
        return sleep
    }
    
}
