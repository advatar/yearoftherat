//
//  DataParseIwown.swift
//  GengziRat
//
//  Created by A$CE on 2020/3/20.
//  Copyright © 2020 iwown. All rights reserved.
//

import UIKit

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
    
    //MARK: @Gnss
    func payloadParserHealthDayData(payload: Data) -> Void {
        if (payload.count < 20) {
            print("DATA LENGTH IS TOO SHORT !!! [payloadParserHealthDayData]")
            return;
        }
         
        let summary = self.healthDay60DataParsing(data: payload)
        self.biDelegate?.bleIwownDidRecieveRealTimeData(rtData: summary)
    }
    
    func payloadParserHealthMinuteData(payload: Data) -> Void {
        let ctrlNum = UInt8(payload[0])
        if ctrlNum == 0 {
            let its = self.parseIndexTableWithData(data: payload.subdata(in: 1..<payload.count))
            self.biDelegate?.bleIwownDidRecieveIndexTable61(its: its)
        }else {
            let healthMinute = self.healthMinute61DataParsing(data: payload)
            self.biDelegate?.bleIwownDidRecieveHealthMinite61(healthMinute: healthMinute)
        }
    }
    
    func payloadParserGNSSMinuteData(payload: Data) -> Void {
    }
    
    func payloadParserECGMinuteData(payload: Data) -> Void {
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
        switch cmd {
        case IV_CMD_ID.HEALTH_DAY_DATA:
            print("60 --")
            self.payloadParserHealthDayData(payload: payload)
        case IV_CMD_ID.HEALTH_MINUTE_DATA:
            self.payloadParserHealthMinuteData(payload: payload)
        case IV_CMD_ID.GNSS_MINUTE_DATA:
            self.payloadParserGNSSMinuteData(payload: payload)
        case IV_CMD_ID.ECG_MINUTE_DATA:
            self.payloadParserECGMinuteData(payload: payload)
        default:
            print("parseGNSSGroup : 未知协议类型")
        }
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
    
    func healthDay60DataParsing(data: Data) -> IW_HealthSummary {
        let year = Int(data[0]) + 2000
        let month = Int(data[1]+1)
        let day = Int(data[2]+1)
        let date = Date(year: year, month: month, day: day, hour: 0, minute: 0)
//        let type = UInt8(data[3])
        let steps = self.uint32Data(data: data.subdata(in: 8..<12))
        let distance = self.uint32Data(data: data.subdata(in: 12..<16))
        let calories = self.uint32Data(data: data.subdata(in: 16..<20))
        return IW_HealthSummary(recordDate: date, calorie: UInt32(calories), step: UInt32(steps), distance: UInt32(distance))
    }
    
    func healthMinute61DataParsing(data: Data) -> IW_HealthMinute? {
        let seq = self.uint16Data(data: data.subdata(in: 0..<2))
        
        var location = 7
        if (data.count < location + 1) {
            return nil
        }
    
        let year = Int(data[2]) + 2000
        let month = Int(data[3]+1)
        let day = Int(data[4]+1)
        let hours = Int(data[5])
        let minutes = Int(data[6])
        let recordDate = Date(year: year, month: month, day: day, hour: hours, minute: minutes)
        let typeData = data[7]
        location = location + 1
        
        var sport:IWH_SportMinute?
        if (UInt8(typeData) & 0x20) > 0 {
            sport = self.getSportDataParse(data: data.subdata(in: location..<location+10))
            location = location + 10
        }

        var heart:IWH_HeartRate?
        if (UInt8(typeData) & 0x01) > 0 {
            heart = self.getHeartRateDataParse(data: data.subdata(in: location..<location+7))
            location = location + 7
        }
        
        var hrv:IWH_HRVFatigue?
        if (UInt8(typeData) & 0x02) > 0 {
            hrv = self.getHeartRateVariabilityData(data: data.subdata(in: location..<location+14))
            location = location + 14
        }
        
        var bl:IWH_BloodPressure?
        if (UInt8(typeData) & 0x04) > 0 {
            bl = self.getBloodPressData(data: data.subdata(in: location..<location+6))
            location = location + 6
        }
        
        return IW_HealthMinute(seqnum: UInt16(seq), recordDate: recordDate, dataType: UInt8(typeData), sport: sport, heartRate: heart, hrvFatigue: hrv, blp: bl, sleepCmd: data)
    }
    
    func parseIndexTableWithData(data: Data) -> Array<IW_IndexTable> {
//        let num = UInt8(data[0])
        let mData = data.subdata(in: 1..<data.count)
        var dataArr = Array<IW_IndexTable>()
        while mData.count >= 10 {
            let iT = self.getTableRowData(data: mData)
            dataArr.append(iT)
        }
        return dataArr
    }

    func getTableRowData(data: Data) -> IW_IndexTable {
        let year = Int(data[0]) + 2000
        let month = Int(data[1]) + 1
        let day = Int(data[2]) + 1
        let hours = Int(data[3])
        let minutes = Int(data[4])
        let seconds = Int(data[5])
        let dateMinute = Date(year: year, month: month, day: day, hour: hours, minute: minutes)
        let recordDate = dateMinute.addingTimeInterval(TimeInterval(seconds))
        
        let startSeq = self.uint16Data(data: data.subdata(in: 6..<8))
        let endSeq = self.uint16Data(data: data.subdata(in: 8..<10))
        return IW_IndexTable(recordDate: recordDate, start: UInt16(startSeq), end: UInt16(endSeq))
    }
    
    func getSportDataParse(data: Data) -> IWH_SportMinute? {
        if data.count < 10 {
            return nil
        }
        
        let calorie = self.uint16Data(data: data.subdata(in: 0..<2))
        let steps = self.uint16Data(data: data.subdata(in: 2..<4))
        let distance_gsensor = self.uint16Data(data: data.subdata(in: 4..<6))
        let sport_type = self.uint16Data(data: data.subdata(in: 6..<8))
        let state_type_encode = UInt8(data[8])

        let state_type = state_type_encode & 15
        let pre_minute = (state_type_encode & 240)>>4
        let reserve = UInt8(data[9])
        return IWH_SportMinute(sport_type: UInt8(sport_type), steps: UInt32(calorie), distance: UInt32(steps), calorie: UInt32(distance_gsensor), stateType: state_type, second: reserve, preMinute: pre_minute)
    }
    
    func getHeartRateDataParse(data: Data) -> IWH_HeartRate {
        let minData = self.uint16Data(data: data.subdata(in: 0..<2))
        let maxData = self.uint16Data(data: data.subdata(in: 2..<4))
        let avgData = self.uint16Data(data: data.subdata(in: 4..<6))
        let level = UInt8(data[6])
        return IWH_HeartRate(minBpm: UInt16(minData), maxBpm: UInt16(maxData), avgBpm: UInt16(avgData), level: level)
    }
    
    func getHeartRateVariabilityData(data: Data) -> IWH_HRVFatigue {
        let sdnn = self.uint16Data(data: data.subdata(in: 0..<2))/10
        let rmssd = self.uint32Data(data: data.subdata(in: 2..<6))/10
        let pnn50 = self.uint32Data(data: data.subdata(in: 6..<10))/10
        let mean = self.uint16Data(data: data.subdata(in: 10..<12))/10
        let bpm = self.uint16Data(data: data.subdata(in: 12..<14))/10

        var fatigue:UInt32
        if bpm > 0 {
            fatigue = UInt32(bpm)
        }else {
            fatigue = UInt32(log(Double(rmssd))*20.0);
        }
        return IWH_HRVFatigue(sdnn: UInt32(sdnn), rmssd: UInt32(rmssd), pnn50: UInt32(pnn50), mean: UInt32(mean), fatigue: fatigue)
    }
    
    func getBloodPressData(data:Data) -> IWH_BloodPressure {
        let sbp = self.uint16Data(data: data.subdata(in: 0..<2))
        let dbp = self.uint16Data(data: data.subdata(in: 2..<4))
        let bpm = self.uint16Data(data: data.subdata(in: 4..<6))
        return IWH_BloodPressure(sbp: UInt16(sbp), dbp: UInt16(dbp), bpm: UInt16(bpm))
    }
}
