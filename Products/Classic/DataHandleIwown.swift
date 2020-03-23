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
}
