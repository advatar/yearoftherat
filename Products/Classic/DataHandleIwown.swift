//
//  DataHandleIwown.swift
//  GengziRat
//
//  Created by A$CE on 2020/3/20.
//  Copyright © 2020 iwown. All rights reserved.
//

public struct IW_DndMode {
    public var dndType:UInt8
    public var startHour:UInt8
    public var startMinute:UInt8
    public var endHour:UInt8
    public var endMinute:UInt8
}

public struct IW_Weather {
    public var temp:Int16
    public var unit:UInt8
    public var type:UInt8
    public var pm:Int16
}

public struct IW_DayWeather {
    public var tempMax:Int16
    public var tempMin:Int16
    public var type:UInt8
    public var pm:Int16
}

public struct IW_24Weather {
    public var startDate:Date
    public var unit:UInt8
    public var weather24Arrs:Array<IW_Weather>
    public var weather7Arrs:Array<IW_DayWeather>
}

let DATA_LEN:Int = 40

import UIKit

class DataHandleIwown: NSObject {
    
    func MAKE_HANDER(grp: IW_CMD_Uint_Code, cmd: IW_CMD_Uint_Code) -> UInt8 {
        return (UInt8(((grp & 0x0f) << 4) | (cmd & 0x0f)))
    }
    
    func dataWithGroupCmds(grp:IW_CMD_Uint_Code, cmd:IW_CMD_Uint_Code, sData: Data?) -> Array<Data> {
        var mArray = Array<Data>.init()
        var mData = Data.init(capacity: 0)

        var pbytes:[UInt8] = [0,0,0,0]
        pbytes[0] = 0x21
        pbytes[1] = 0xFF
       
        let gCmd = self.MAKE_HANDER(grp: grp, cmd: cmd)
        pbytes[2] = gCmd
        
        if sData != nil {
            pbytes[3] = UInt8(sData!.count)
        }
        
        let dataHeader = Data(pbytes)

        mData.append(dataHeader)

        let mCount = mData.count
        
        var index:Int = 0
        while index < mCount {
            let subData = mData.subdata(in: index..<(index+DATA_LEN))
            mArray.append(subData)
            index += DATA_LEN
        }

        return mArray
    }
    
    func getDndModeSet(dndMode: IW_DndMode) -> Data {
        var pbytes:[UInt8] = [0x00,0,0,0,0,0]
        pbytes[1] = dndMode.dndType
        pbytes[2] = dndMode.startHour
        pbytes[3] = dndMode.startMinute
        pbytes[4] = dndMode.endHour
        pbytes[5] = dndMode.endMinute

        let data = Data(pbytes)
        return data        
    }
    
    func getWeatherSet(weather: IW_Weather) -> Data {
        var pbytes:[UInt8] = [0,0,0,0,0,0]
        pbytes[0] = UInt8(weather.temp & 0xff)
        pbytes[1] = UInt8((weather.temp>>8) & 0xff)
        pbytes[2] = weather.unit
        pbytes[3] = weather.type
        pbytes[4] = UInt8(weather.pm%0x100)
        pbytes[5] = UInt8(weather.pm/0x100)

        let data = Data(pbytes)
        return data
    }
    
    func get24WeatherSet(weather24: IW_24Weather) -> Data {
        let subYear = UInt8(weather24.startDate.year - 2000)
        let subMonth = UInt8(weather24.startDate.month - 1)
        let subDay = UInt8(weather24.startDate.day - 1)
        let subHour = UInt8(weather24.startDate.hour - 1)

        let pBytes = [subYear, subMonth, subDay, subHour]
        let pData = Data(pBytes)
         
        var data24 = Data.init()
        data24.append(pData)
        data24.append(Data([weather24.unit]))
        for i in 0..<weather24.weather24Arrs.count {
            if (i == 24) { //只取24小时
                break
            }
            let w = weather24.weather24Arrs[i]
            let tempD = getWeatherDataWithOutUnit(weather: w);
            data24.append(tempD)
        }
        return data24;
    }
    
    func getWeatherDataWithOutUnit(weather: IW_Weather) -> Data {
        var pbytes:[UInt8] = [0,0,0,0,0]
        pbytes[0] = UInt8(weather.temp & 0xff)
        pbytes[1] = UInt8((weather.temp>>8) & 0xff)
        pbytes[2] = weather.type
        pbytes[3] = UInt8(weather.pm%0x100)
        pbytes[4] = UInt8(weather.pm/0x100)

        let data = Data(pbytes)
        return data
    }
    
    func getIndexTableData(iT : IW_IndexTable) -> Data {
        var pbytes:[UInt8] = [0,0,0,0,0,0,0]
        pbytes[0] = UInt8(iT.recordDate.year-2000)
        pbytes[1] = UInt8(iT.recordDate.month-1)
        pbytes[2] = UInt8(iT.recordDate.day-1)
        pbytes[3] = UInt8(iT.start%0x100)
        pbytes[4] = UInt8(iT.start>>8)
        pbytes[5] = UInt8(iT.end%0x100)
        pbytes[6] = UInt8(iT.end>>8)

        let data = Data(pbytes)
        return data
    }
}
