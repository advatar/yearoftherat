//
//  DataHandleIwown.swift
//  GengziRat
//
//  Created by A$CE on 2020/3/20.
//  Copyright © 2020 iwown. All rights reserved.
//

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
}
