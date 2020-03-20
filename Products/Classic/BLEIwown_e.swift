//
//  BLEIwown_e.swift
//  GengziRat
//
//  Created by A$CE on 2020/3/20.
//  Copyright © 2020 iwown. All rights reserved.
//

import Foundation

public typealias IW_CMD_Uint_Code = UInt16

struct IW_CMD_GRP {
    // RESET, UPDATE, INFORMATION, see @static let DEVICE
    static let DEVICE:IW_CMD_Uint_Code = 0x00
    static let NFC = IW_CMD_GRP.DEVICE
    
    // TIME_SETTINGS, BLE_SETTING, AC_SETTING, NMA_SETTING, GNSS_SETTING
    static let CONFIG:IW_CMD_Uint_Code = 0x01
    
    // CLEAR, GET, PEDO_SETTING 2
    static let DATALOG:IW_CMD_Uint_Code = 0x02
    static let SCALE = IW_CMD_GRP.DATALOG
    
    // UPLOAD, DOWNLOAD, 3
    static let MSG:IW_CMD_Uint_Code = 0x03
    static let CTRL:IW_CMD_Uint_Code = 0x04
    
    //心率 5
    static let HEARTRATE:IW_CMD_Uint_Code = 0x05
    
    //GNSS, 健康数据
    static let GNSS:IW_CMD_Uint_Code = 0x06
}

struct IV_CMD_ID {
    static let DEVICE_GET_INFORMATION:IW_CMD_Uint_Code = 0x00
    static let DEVICE_NFC_SET_AND_GET = IV_CMD_ID.DEVICE_GET_INFORMATION
    static let DEVICE_GET_BATTERY:IW_CMD_Uint_Code = 0x01
    static let DEVICE_RESET:IW_CMD_Uint_Code = 0x02
    static let DEVICE_UPDATE:IW_CMD_Uint_Code = 0x03
    static let DEVICE_REQ_REBOND:IW_CMD_Uint_Code = 0x04
    static let DEVICE_DO_REBOND:IW_CMD_Uint_Code = 0x05
    static let DEVICE_DND_MODE:IW_CMD_Uint_Code = 0x06
    static let DEVICE_WEATHER:IW_CMD_Uint_Code = 0x07
    static let DEVICE_SYNCDATA:IW_CMD_Uint_Code = 0x08
    static let DEVICE_HEARTBEAT_SIGNAL:IW_CMD_Uint_Code = 0x09
    // Hardware Option type Support
    static let DEVICE_HW_OPTION_SUPPERT:IW_CMD_Uint_Code = 0x10
    static let DEVICE_MANUFACTURE_DATE:IW_CMD_Uint_Code = 0x11
    static let DEVICE_FACTORY_CONF:IW_CMD_Uint_Code = 0x12
    static let DEVICE_FACTORY_TEST:IW_CMD_Uint_Code = 0x13
    static let DEVICE_EARPHONE_PARAM:IW_CMD_Uint_Code = 0x14
    static let DEVICE_24_WEATHER:IW_CMD_Uint_Code = 0x15

    // Time
    static let CONFIG_SET_TIME:IW_CMD_Uint_Code = 0x00
    static let CONFIG_GET_TIME:IW_CMD_Uint_Code = 0x01
    // BLE
    static let CONFIG_SET_BLE:IW_CMD_Uint_Code = 0x02
    static let CONFIG_GET_BLE:IW_CMD_Uint_Code = 0x03
    // AlarmClock
    static let CONFIG_SET_AC:IW_CMD_Uint_Code = 0x04
    static let CONFIG_GET_AC:IW_CMD_Uint_Code = 0x05
    // No-Move-Alert
    static let CONFIG_SET_NMA:IW_CMD_Uint_Code = 0x06
    static let CONFIG_GET_NMA:IW_CMD_Uint_Code = 0x07
    // Hardware Option
    static let CONFIG_SET_HW_OPTION:IW_CMD_Uint_Code = 0x08
    static let CONFIG_GET_HW_OPTION:IW_CMD_Uint_Code = 0x09
    // Sport List
    static let CONFIG_GET_SPORT_LIST:IW_CMD_Uint_Code = 0x0A
    static let CONFIG_SET_SPORT_TARGET:IW_CMD_Uint_Code = 0x0B
    static let CONFIG_GET_SPORT_TARGET:IW_CMD_Uint_Code = 0x0C
    //schedule
    static let CONFIG_SET_SCHEDULE:IW_CMD_Uint_Code = 0x0D
    static let CONFIG_GET_SCHEDULE:IW_CMD_Uint_Code = 0x0E
    static let CONFIG_GET_HEADSET = IV_CMD_ID.CONFIG_GET_SCHEDULE
    static let CONFIG_SET_HEADSET = IV_CMD_ID.CONFIG_GET_HEADSET
     //contacts
    static let CONFIG_SGET_CONTACTS:IW_CMD_Uint_Code = 0x0F
    
    // Body Parmameters
    static let DATALOG_SET_BODY_PARAM:IW_CMD_Uint_Code = 0x00
    // Read body Parmameters
    static let DATALOG_GET_BODY_PARAM:IW_CMD_Uint_Code = 0x01
    static let DATALOG_CLEAR_ALL:IW_CMD_Uint_Code = 0x02
    static let HEART_RATE_SET_WARNING_PARAM:IW_CMD_Uint_Code = 0x03
    static let HEART_RATE_GET_WARNING_PARAM:IW_CMD_Uint_Code = 0x04
    static let GNSS_SETTING:IW_CMD_Uint_Code = 0x05
    static let GNSS_GET_SETTING:IW_CMD_Uint_Code = 0x06
    static let DATALOG_GET_CUR_DAY_DATA:IW_CMD_Uint_Code = 0x07
    static let DATALOG_GET_SPORTDATA:IW_CMD_Uint_Code = 0x08
    static let DATALOG_GET_CUR_SPORTDATA:IW_CMD_Uint_Code = 0x09
    static let DATALOG_GET_SLEEP_TEST:IW_CMD_Uint_Code = 0x0A
    //SMF -> sport minute freeze
    static let DATALOG_GET_SMF_TEST:IW_CMD_Uint_Code = 0x0B
    
    static let MSG_UPLOAD:IW_CMD_Uint_Code = 0x00
    static let MSG_SINGLE_DOWNLOAD:IW_CMD_Uint_Code = 0x01
    static let MSG_MULTI_DOWNLOAD_START:IW_CMD_Uint_Code = 0x02
    static let MSG_MULTI_DOWNLOAD_CONTINUE:IW_CMD_Uint_Code = 0x03
    static let MSG_MULTI_DOWNLOAD_END:IW_CMD_Uint_Code = 0x04

    static let MSG_SPECIAL_LIST_SET:IW_CMD_Uint_Code = 0x07
    static let MSG_SPECIAL_LIST_GET:IW_CMD_Uint_Code = 0x08
    
    static let CTRL_KEYNOTIFY:IW_CMD_Uint_Code = 0x00
    static let CTRL_MOTOR:IW_CMD_Uint_Code = 0x01
    static let CTRL_SENSOR:IW_CMD_Uint_Code = 0x02
    static let CTRL_EXERCISE:IW_CMD_Uint_Code = 0x03
    static let CTRL_SET_CUSTOM_OPTION:IW_CMD_Uint_Code = 0x0E
    static let CTRL_GET_CUSTOM_OPTION:IW_CMD_Uint_Code = 0x0F
    
    //读取和设置心率参数
    static let HEARTRATE_PARAM:IW_CMD_Uint_Code = 0x00
    //分段心率数据同步
    static let HEARTRATE_DATA:IW_CMD_Uint_Code = 0x01
    //心率模块升级控制
    static let HEARTRATE_UPDATE:IW_CMD_Uint_Code = 0x02
    //分时心率数据
    static let HEARTRATE_HOURS_DATA:IW_CMD_Uint_Code = 0x03
    
    static let HEALTH_DAY_DATA:IW_CMD_Uint_Code = 0x00
    static let HEALTH_MINUTE_DATA:IW_CMD_Uint_Code = 0x01
    static let GNSS_MINUTE_DATA:IW_CMD_Uint_Code = 0x02
    static let GNSS_MINUTE_DATA_TEST:IW_CMD_Uint_Code = 0x03
    static let ECG_MINUTE_DATA:IW_CMD_Uint_Code = 0x04
    static let EPO_DOWNLOAD_START:IW_CMD_Uint_Code = 0x05
    static let SET_TARGET:IW_CMD_Uint_Code = 0x06
    static let READ_TARGET:IW_CMD_Uint_Code = 0x07
    static let R1_MINUTE_DATA:IW_CMD_Uint_Code = 0x08
    
    static let HEALTH_MINUTE_DATA_N:IW_CMD_Uint_Code = 0x0A
    static let GNSS_MINUTE_DATA_N:IW_CMD_Uint_Code = 0x0B
}

