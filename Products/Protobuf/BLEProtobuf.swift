//
//  BLEProtobuf.swift
//  CoreBluetoothClassicSample
//
//  Created by A$CE on 2020/1/14.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

struct PROTOBUF_UUID_STR {
    static let serviceUuid:String = "2E8C0001-2D91-5533-3117-59380A40AF8F"
    static let notifyUuid:String = "2E8C0002-2D91-5533-3117-59380A40AF8F"
    static let writeUuid:String = "2E8C0003-2D91-5533-3117-59380A40AF8F"
}

protocol BleProtobufDelegate: class {
    func bleProtobufDidRecieveDeviceInfo(deviceInfo: DeviceInfoResponse)
}

class BLEProtobuf: NSObject {
    
    let dataHandle:DataHandleProtobuf = DataHandleProtobuf()
    let dataParser:DataParseProtobuf = DataParseProtobuf()
    
    weak var bpbDelegate:BleProtobufDelegate?
    
    //MARK: @Public
    //MARK: cmds
    func getDeviceInfo() -> Data {
        let payload = dataHandle.deviceInfoRequest()
        return self.append(optCode: PB_Opt.DeviceInfo, payload: payload)
    }
    
    //MARK: receive data
    var _recvFinished = true
    var _recvData:Data = Data()
    var _dataLength:UInt = 0
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
       
        if (_recvData.count-8) == _dataLength {
            self.dataCheck(data: _recvData)
            _recvData = Data()
            _recvFinished = true
        }else {
            _recvFinished = false
        }
    }
    
    //MARK: @OutPut
    func dataCheckOfOptCode(optCode: PB_Opt_Uint_Code,data: Data) -> Void {
        switch optCode {
        case PB_Opt.DeviceInfo:
            do {
                let diResponse = try DeviceInfoResponse(serializedData: data)
                bpbDelegate?.bleProtobufDidRecieveDeviceInfo(deviceInfo: diResponse)
            } catch let error {
                print(error)
            }
        default:
            break
        }
    }
    
    func append(optCode: PB_Opt_Uint_Code, payload: Data) -> Data {
        var mData = Data.init(capacity: 0)

        var pbytes:[UInt8] = [0,0,0,0,0,0,0,0]
        pbytes[0] = 0x44
        pbytes[1] = 0x54
        
        let len = payload.count
        let lenA = len/0x100;
        let lenB = len%0x100;
        pbytes[2] = UInt8(lenB);
        pbytes[3] = UInt8(lenA);

        let payloadByte = [UInt8](payload)
        let crcCode:UInt16 = self.CalcCrc16(data: payloadByte)
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
    
    //MARK: @Private
    func CalcCrc16(data: [UInt8]) -> UInt16 {
        var wCRCin:UInt16 = 0x0000
        let wCPoly:UInt16 = 0x1021
        var wChar:UInt8 = 0
        
        for idx in 0..<data.count {
            wChar = data[idx]
            wCRCin ^= (UInt16(wChar) << 8)
            for _ in 0..<8 {
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
    
    func getDataLength(data: Data) -> UInt {
        let subData = data.subdata(in: 2..<4)
        let a = subData[0]
        let b = subData[1]
        return UInt(UInt16(a) + 0x100 * UInt16(b))
    }
    
    func prefixCheck(data: Data) -> Bool {
        let length = 8
        if data.count < length {
            return false
        }
        
        let perfixData = data.subdata(in: 0..<2)
        let byteA = perfixData[0]
        let byteB = perfixData[1]
        let isNewPerfix = (byteA == 0x44) && (byteB == 0x54)
        return isNewPerfix
    }
    
    func dataCheck(data: Data) -> Void {
        let optCode = self.getOperationCode(data: data)
        
        if data.count < 8 {
            print("DATA LENGTH ERROR【 \(data) 】")
            return
        }
        
        let payloadData = data.subdata(in: 8..<data.count)
        let crcData = [UInt8](payloadData)
        let crcCk = self.CalcCrc16(data: crcData)
        let crcCode = self.getCrcCheckValue(data: data)
        if (crcCk != crcCode) {
            return;
        }
        
        self.dataCheckOfOptCode(optCode: optCode, data: payloadData)
//     MARK: DEMO
//        do {
//            let bi = try DeviceInfoResponse(jsonUTF8Data: payloadData)
//            let bookInfo = try PhoneBookInfo(serializedData: payloadData)
//
//        } catch let error {
//            print(error)
//        }
    }

    func getCrcCheckValue(data: Data) -> UInt16 {
        let subData = data.subdata(in: 4..<6)
        let a = subData[0];
        let b = subData[1];
        return UInt16(a) + 0x100 * UInt16(b)
    }
    
    func getOperationCode(data: Data) -> UInt16 {
        let subData = data.subdata(in: 6..<8)
        let a = subData[0];
        let b = subData[1];
        return UInt16(a) + 0x100 * UInt16(b)
    }
}
