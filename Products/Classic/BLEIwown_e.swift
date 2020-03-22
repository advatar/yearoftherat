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


public typealias IW_Sport_Uint_Code = UInt16

struct IV_SPORT_TYPE {
    static let SLEEP:IW_Sport_Uint_Code = 0x00 //睡眠
    
    static let WALKING:IW_Sport_Uint_Code = 0x01 //走路
    static let NORMAL_MODE:IW_Sport_Uint_Code = 0x01 //彩屏非运动模式
    static let SITE_UPS:IW_Sport_Uint_Code = 0x02 //仰卧起坐
    static let PUSH_UP:IW_Sport_Uint_Code = 0x03 //俯卧撑
    static let ROPE_SKIPPING:IW_Sport_Uint_Code = 0x04 //跳绳
    static let MOUNTAINEERING:IW_Sport_Uint_Code = 0x05 //登山
    static let PULL_UP:IW_Sport_Uint_Code = 0x06 //引体向上
    static let RUNNING:IW_Sport_Uint_Code = 0x07 //跑步
    static let APP_JIANMEICAO:IW_Sport_Uint_Code = 0x08 //健美操
    
    static let CRUNCHES:IW_Sport_Uint_Code = 0x09 //卷腹
    static let DEEP_SQUAT:IW_Sport_Uint_Code = 0x0a //深蹲
    static let AIR_PEDAL:IW_Sport_Uint_Code = 0x0b //空中蹬车
    static let HIP_BRIDGE:IW_Sport_Uint_Code = 0x0c //臀桥
    static let DUMB_BELL:IW_Sport_Uint_Code = 0x0d //哑铃锻炼
    static let APP_KAIHETIAO:IW_Sport_Uint_Code = 0x0e //开合跳
    static let APP_JIANBUDUN:IW_Sport_Uint_Code = 0x0f //箭步蹲
    static let SLIMMING_EXERCISE:IW_Sport_Uint_Code = 0x10 //蹦床
    static let CLIMB_STAIRS:IW_Sport_Uint_Code = 0x11 //爬楼梯
    
    static let APP_BUYU:IW_Sport_Uint_Code = 0x12 //捕鱼
    static let APP_SHOULIE:IW_Sport_Uint_Code = 0x13 //狩猎
    static let APP_JIAWU:IW_Sport_Uint_Code = 0x14 //家务活动
    static let APP_JIATINGXIULI:IW_Sport_Uint_Code = 0x15 //家庭修理
    static let APP_ANJINGBUDONG:IW_Sport_Uint_Code = 0x16 //安静不动
    static let APP_XUEXI:IW_Sport_Uint_Code = 0x17 //学习
    static let APP_CAOPINGTINGXUE:IW_Sport_Uint_Code = 0x18 //草坪庭院
    static let APP_JIAOTAN:IW_Sport_Uint_Code = 0x19 //交谈
    static let APP_YUEQIYANZOU:IW_Sport_Uint_Code = 0x1a //乐器演奏
    static let APP_ZHIYEHUODONG:IW_Sport_Uint_Code = 0x1b //职业活动
    static let APP_ZILIHUODONG:IW_Sport_Uint_Code = 0x1c //自理活动
    static let APP_XINGSHENGHUO:IW_Sport_Uint_Code = 0x1d //性生活
    static let APP_XIUXIAN:IW_Sport_Uint_Code = 0x1e //休闲
    
    static let APP_GONGLVZIXINGCHE:IW_Sport_Uint_Code = 0x91 //功率自行车
    static let APP_TABUJI:IW_Sport_Uint_Code = 0x92 //踏步机
    static let APP_HUABAN:IW_Sport_Uint_Code = 0x93 //滑板
    static let APP_PULATI:IW_Sport_Uint_Code = 0x94 //普拉提
    static let APP_SHIPINYUNDONG:IW_Sport_Uint_Code = 0x95 //视频运动
    static let APP_TAIQIU:IW_Sport_Uint_Code = 0x96 //台球
    static let APP_QUANJI:IW_Sport_Uint_Code = 0x97 //拳击
    static let APP_JIANLIAN:IW_Sport_Uint_Code = 0x98 //教练
    static let APP_ZHIBIAO:IW_Sport_Uint_Code = 0x9a //掷镖
    static let APP_TUOLABISAI:IW_Sport_Uint_Code = 0x9b //拖拉比赛
    static let APP_JIANSHU:IW_Sport_Uint_Code = 0x9c //剑术
    static let APP_GANLANQIU:IW_Sport_Uint_Code = 0x9d //橄榄球
    static let APP_FEIPAN:IW_Sport_Uint_Code = 0x9e //飞盘
    static let APP_GAOERFU:IW_Sport_Uint_Code = 0x9f //高尔夫
    static let APP_TICAO:IW_Sport_Uint_Code = 0xa0 //体操
    static let APP_SHOUQIU:IW_Sport_Uint_Code = 0xa1 //手球
    static let APP_HUAXIANG:IW_Sport_Uint_Code = 0xa2 //滑翔
    static let APP_QUGUNQIU:IW_Sport_Uint_Code = 0xa3 //曲棍球
    static let APP_BINGQIU:IW_Sport_Uint_Code = 0xa4 //冰球
    static let APP_QIMA:IW_Sport_Uint_Code = 0xa5 //骑马
    static let APP_HUILIQIU:IW_Sport_Uint_Code = 0xa6 //回力球
    static let APP_WUSHU:IW_Sport_Uint_Code = 0xa7 //武术
    static let APP_YUEYE:IW_Sport_Uint_Code = 0xa8 //越野
    static let APP_BANQIU:IW_Sport_Uint_Code = 0xa9 //板球
    static let APP_MANQIU:IW_Sport_Uint_Code = 0xaa //马球
    static let APP_TIAOSAN:IW_Sport_Uint_Code = 0xab //跳伞
    static let APP_LEIQIU:IW_Sport_Uint_Code = 0xac //垒球
    static let APP_BIQIU:IW_Sport_Uint_Code = 0xad //壁球
    static let TAIJI:IW_Sport_Uint_Code = 0xae //太极
    static let APP_SHUAIJIAO:IW_Sport_Uint_Code = 0xaf //摔跤
    static let APP_JIAOSHI:IW_Sport_Uint_Code = 0xb0 //驾驶
    static let APP_SHEJIAN:IW_Sport_Uint_Code = 0xb1 //射箭
    static let BRISK_WALKING:IW_Sport_Uint_Code = 0xb5 //快走
    static let APP_JIACHUAN:IW_Sport_Uint_Code = 0xb6 //驾船
    static let APP_PIHUATING:IW_Sport_Uint_Code = 0xb7 //皮划艇
    static let APP_FANCHUAN:IW_Sport_Uint_Code = 0xb8 //帆船
    static let APP_HUASHUI:IW_Sport_Uint_Code = 0xb9 //滑水
    static let APP_QIANSHUI:IW_Sport_Uint_Code = 0xba //潜水
    static let APP_CHONGLANG:IW_Sport_Uint_Code = 0xbb //冲浪
    static let APP_SHUIQIU = 0xbc //水球
    static let APP_TIAOXUE:IW_Sport_Uint_Code = 0xbd //跳雪
    static let APP_XUEQIAO:IW_Sport_Uint_Code = 0xbe //雪橇
    static let APP_XUESHANGQICHE:IW_Sport_Uint_Code = 0xbf //雪上骑车
    static let APP_TIAOSHUI:IW_Sport_Uint_Code = 0xc0 //跳水
    
    static let MASK:IW_Sport_Uint_Code = 0x80 //掩码
    
    static let INDOORBIKE:IW_Sport_Uint_Code = 0x20//室内单车
    static let GROUPCLASS:IW_Sport_Uint_Code = 0x30 //团课
    static let PERSONALEDUCATION:IW_Sport_Uint_Code = 0x31 //私教
    static let TREADMILL:IW_Sport_Uint_Code = 0x32 //跑步机
    static let FREETRAINING:IW_Sport_Uint_Code = 0x33 //自由训练
    static let BADMINTON:IW_Sport_Uint_Code = 0x80 //羽毛球
    static let BASKETBALL:IW_Sport_Uint_Code = 0x81 //篮球
    static let FOOTBALL:IW_Sport_Uint_Code = 0x82 //足球
    static let SWIM:IW_Sport_Uint_Code = 0x83 //游泳
    static let VOLLEYBALL:IW_Sport_Uint_Code = 0x84 //排球
    static let TABLE_TENNIS:IW_Sport_Uint_Code = 0x85 //乒乓球
    static let BOWLING:IW_Sport_Uint_Code = 0x86 //保龄球
    static let TENNIS:IW_Sport_Uint_Code = 0x87 //网球
    static let CYCLING:IW_Sport_Uint_Code = 0x88 //骑行
    static let SKI:IW_Sport_Uint_Code = 0x89 //滑雪
    static let SKATE:IW_Sport_Uint_Code = 0x8a //滑冰
    static let ROCK_CLIMBING:IW_Sport_Uint_Code = 0x8b //攀岩
    static let GYM:IW_Sport_Uint_Code = 0x8c //健身房健身
    static let DANCE:IW_Sport_Uint_Code = 0x8d //跳舞
    static let TABLET_SUPPORT:IW_Sport_Uint_Code = 0x8e //平板撑
    static let GYM_EXERCISE:IW_Sport_Uint_Code = 0x8f //健身操
    static let YOGA:IW_Sport_Uint_Code = 0x90 //瑜伽
    static let SHUTTLECOCK:IW_Sport_Uint_Code = 0x91 //毽球
    static let ALLBALL:IW_Sport_Uint_Code = 0x92 //所有球类
    static let POWALKING:IW_Sport_Uint_Code = 0x93 //健步走
    static let GOLF:IW_Sport_Uint_Code = 0x94 //高尔夫
    static let CANOEING:IW_Sport_Uint_Code = 0x95 //皮划艇
    
    static let HEART_RATE:IW_Sport_Uint_Code = 0xf0 //心率
    
    static let OTHER:IW_Sport_Uint_Code = 0xFF //其他
    static let WALKING_SAVE:IW_Sport_Uint_Code = 0x100 //步行
}

