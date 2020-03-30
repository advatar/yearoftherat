//
//  DataParseIwown_e.swift
//  GengziRat
//
//  Created by A$CE on 2020/3/28.
//  Copyright © 2020 iwown. All rights reserved.
//

import Foundation

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

public struct IW_HeartRate53 {
    public var seq:UInt32
    public var recordDate:Date
    public var heartRates:Array<UInt8>
}

public struct IW_IndexTable {
    public var recordDate:Date
    public var start:UInt16
    public var end:UInt16
}

public struct IWH_SportMinute {
    public var sport_type:UInt8
    public var steps:UInt32
    //Unit : 0.1 m
    public var distance:UInt32
    //Unit : 0.1 kcal
    public var calorie:UInt32
    public var stateType:UInt8
    public var second:UInt8
    public var preMinute:UInt8
}

public struct IWH_HeartRate {
    public var minBpm:UInt16
    public var maxBpm:UInt16
    public var avgBpm:UInt16
    public var level:UInt8
}

public struct IWH_HRVFatigue {
    public var sdnn:UInt32
    public var rmssd:UInt32
    public var pnn50:UInt32
    public var mean:UInt32
    public var fatigue:UInt32
}

public struct IWH_BloodPressure {
    //血压，sbp-收缩压 ；dbp-舒张压
    public var sbp:UInt16
    public var dbp:UInt16
    public var bpm:UInt16
}

public struct IWH_HealthMdt {
    public var sdnn:Float
    public var rmssd:Float
    public var pnn50:Float
    public var mean:Float
    public var status:UInt
    public var result:Float
    public var relax:Float
}

public struct IW_HealthMinute {
    public var seqnum:UInt16
    public var recordDate:Date
    public var dataType:UInt8
    public var sport:IWH_SportMinute?
    public var heartRate:IWH_HeartRate?
    public var hrvFatigue:IWH_HRVFatigue?
    public var blp:IWH_BloodPressure?
    public var sleepCmd:Data
}

public struct IWG_Point {
    public var longitude:Float
    public var latitude:Float
    public var altitude:Int
    public var gpsSpeed:Int
}

public struct IW_GNSSData {
    public var seqnum:UInt16
    public var recordDate:Date
    public var freq:UInt16
    //经纬度个数
    public var num:UInt16
    //经纬度 数组
    public var dataArray:Array<IWG_Point>
}

public struct IW_ECGData {
    public var seqnum:UInt16
    public var recordDate:Date
    public var dataArray:Array<Any>
}

