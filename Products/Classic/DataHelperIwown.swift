//
//  DataHelperIwown.swift
//  GengziRat
//
//  Created by A$CE on 2020/3/20.
//  Copyright © 2020 iwown. All rights reserved.
//
import SwiftDate
import UIKit

class DataHelperIwown: NSObject {
    func getDataInTime(date: Date) -> Data {
        var pbytes:[UInt8] = [0,0,0,0,0,0]

        pbytes[0] = UInt8(date.year - 2000)
        pbytes[1] = UInt8(date.month - 1)
        pbytes[2] = UInt8(date.day - 1)
        pbytes[3] = UInt8(date.hour)
        pbytes[4] = UInt8(date.minute)
        pbytes[5] = UInt8(date.second)

        let dataHeader = Data(pbytes)
        return dataHeader
    }
}
