//
//  BLEProtobuf.swift
//  CoreBluetoothClassicSample
//
//  Created by A$CE on 2020/1/14.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class BLEProtobuf: NSObject {
    let dataHandle:DataHandleProtobuf = DataHandleProtobuf()
    let dataParser:DataParseProtobuf = DataParseProtobuf()
    
    func getDeviceInfo() -> Data {
        let payload = dataHandle.deviceInfoRequest()
        return self.append(optCode: PB_Opt.DeviceInfo, payload: payload)
    }
    
    ///@Private
    func append(optCode: PB_Opt_Uint_Code, payload: Data) -> Data {
        var mData = Data.init(capacity: 0)

        var pbytes:[UInt8] = []
        pbytes[0] = 0x44
        pbytes[1] = 0x54
        
        let len = payload.count
        let lenA = len/0x100;
        let lenB = len%0x100;
        pbytes[2] = UInt8(lenB);
        pbytes[3] = UInt8(lenA);

        let payloadByte = [UInt8](payload)
        let crcCode:UInt16 = self.CalcCrc16Check(data: payloadByte)
        let crcA = crcCode/0x100;
        let crcB = crcCode%0x100;
        pbytes[4] = UInt8(crcB);
        pbytes[5] = UInt8(crcA);

        let optI:UInt16 = UInt16(optCode);
        let optA = optI/0x100;
        let optB = optI%0x100;
        pbytes[6] = UInt8(optB);
        pbytes[7] = UInt8(optA);

        let headerData = Data(pbytes)
        mData.append(headerData)
        mData.append(payload)
        return mData
    }
    
    func CalcCrc16Check(data: [UInt8]) -> UInt16 {
        var wCRCin:UInt16 = 0x0000
        let wCPoly:UInt16 = 0x1021
        var wChar:UInt8 = 0
        
        for idx in 0...data.count {
            wChar = data[idx]
            wCRCin = wCRCin ^ UInt16(wChar << 8)
            for i in 0...8 {
                print(i)
                let result:UInt16 = wCRCin & 0x8000
                if result > 0 {
                    wCRCin = (wCRCin << 1) ^ wCPoly
                }else {
                    wCRCin = wCRCin << 1;
                }
            }
        }
        return (wCRCin) ;
    }
}
