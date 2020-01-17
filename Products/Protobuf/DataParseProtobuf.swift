//
//  DataParseProtobuf.swift
//  CoreBluetoothClassicSample
//
//  Created by A$CE on 2020/1/14.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

public struct PB_DeivceInfo {
    public var model:String
    public var mac:Data
    public var version:String
}

public struct PB_BatteryInfo {
    public var level:UInt32
    public var isCharging:Bool
}

public struct PB_HealthSummary {
    public var calorie:UInt32
    public var step:UInt32
    public var distance:UInt32
}

public enum PB_HisDatatype {
    typealias RawValue = Int
    case healthData // = 0
    case gnssData // = 1
    case ecgData // = 2
    case ppgData // = 3
    case rriData // = 4
    case medicData // = 5
    case spo2Data // = 6
    case swimData // = 7

    init() {
      self = .healthData
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .healthData
      case 1: self = .gnssData
      case 2: self = .ecgData
      case 3: self = .ppgData
      case 4: self = .rriData
      case 5: self = .medicData
      case 6: self = .spo2Data
      case 7: self = .swimData
      default: return nil
      }
    }

    var rawValue: Int {
      switch self {
      case .healthData: return 0
      case .gnssData: return 1
      case .ecgData: return 2
      case .ppgData: return 3
      case .rriData: return 4
      case .medicData: return 5
      case .spo2Data: return 6
      case .swimData: return 7
      }
    }
}

public struct PB_HisBlock {
    var startSeq: UInt32
    var endSeq: UInt32
    
    static func hisBlocks(pbBlocks: [PB_HisBlock]) -> [HisBlock] {
        var hisBlocks:[HisBlock] = []
        for item in pbBlocks {
            var bk = HisBlock.init()
            bk.startSeq = item.startSeq
            bk.endSeq = item.endSeq
            hisBlocks.append(bk)
        }
        return hisBlocks
    }
}

public struct PB_HisIndexTable {
    public var date:Date
    public var startSeq:UInt32
    public var endSeq:UInt32
    
    static func tableWith(indexTables: [HisIndex]) -> [PB_HisIndexTable] {
        var rITs:[PB_HisIndexTable] = []
        let tsFromGMT = DataHandleProtobuf.tsFromGMT()
        for item in indexTables {
            let date:Date = Date.init(timeIntervalSince1970: TimeInterval(item.time.seconds-uint(tsFromGMT)))
            let iT = PB_HisIndexTable.init(date: date, startSeq: item.startSeq, endSeq: item.endSeq)
            rITs.append(iT)
        }
        return rITs
    }
}

public struct PB_HisData {
    var jsonData:String
}

public struct PB_UserConf {
    var height: UInt32
    var weight: UInt32
    var gender: Bool
    var age: UInt32
    var calibWalk: UInt32
    var calibRun: UInt32
    
    func userConf() -> UserConf {
        var uc:UserConf = UserConf.init()
        uc.height = self.height
        uc.weight = self.weight
        uc.gender = self.gender
        uc.age = self.age
        uc.calibRun = self.calibRun
        uc.calibWalk = self.calibWalk
        return uc
    }
}

public struct PB_BpCaliConf {
    var srcSbp: UInt32
    var srcDbp: UInt32
    var dstSbp: UInt32
    var dstDbp: UInt32
    
    func bpCaliConf() -> BpCaliConf {
        var bpc:BpCaliConf = BpCaliConf.init()
        bpc.srcSbp = self.srcSbp
        bpc.srcDbp = self.srcDbp
        bpc.dstSbp = self.dstSbp
        bpc.dstDbp = self.dstDbp
        return bpc
    }
}

public struct PB_GoalConf {
    var distance: UInt32
    var step: UInt32
    var calorie: UInt32
    
    func goalConf() -> GoalConf {
        var gc = GoalConf.init()
        gc.calorie = self.calorie
        gc.step = self.step
        gc.calorie = self.calorie
        return gc
    }
}

public struct PB_GnssConf {
    var altitude: Float
    var latitude: Float
    var longitude: Float
    
    func gnssConf() -> GnssConf {
        var gc = GnssConf.init()
        gc.altitude = self.altitude
        gc.latitude = self.latitude
        gc.longitude = self.longitude
        return gc
    }
}

public struct PB_AfConf {
    var autoRun: Bool
    var interval: UInt32
    
    func afConf() -> AfConf {
        var ac = AfConf.init()
        ac.autoRun = self.autoRun
        ac.interval = self.interval
        return ac
    }
}

public struct PB_HrAlarmConf {
    var enable: Bool
    var thsHigh: UInt32
    var thsLow: UInt32
    var timeout: UInt32
    var interval: UInt32
    
    func hrAlarmConf() -> HrAlarmConf {
        var hac = HrAlarmConf.init()
        hac.enable = self.enable
        hac.thsLow = self.thsLow
        hac.thsHigh = self.thsHigh
        hac.timeout = self.timeout
        hac.interval = self.interval
        return hac
    }
}

enum PB_VibrateType {
  typealias RawValue = Int
  case alarmClock // = 0
  case incomingCall // = 1
  case sms // = 2
  case sedentariness // = 3
  case charging // = 4
  case calendar // = 5
  case distanceAlarm // = 6
  case heartrateAlarm // = 7
  case others // = 8

  init() {
    self = .alarmClock
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .alarmClock
    case 1: self = .incomingCall
    case 2: self = .sms
    case 3: self = .sedentariness
    case 4: self = .charging
    case 5: self = .calendar
    case 6: self = .distanceAlarm
    case 7: self = .heartrateAlarm
    case 8: self = .others
    default: return nil
    }
  }

  var rawValue: Int {
    switch self {
    case .alarmClock: return 0
    case .incomingCall: return 1
    case .sms: return 2
    case .sedentariness: return 3
    case .charging: return 4
    case .calendar: return 5
    case .distanceAlarm: return 6
    case .heartrateAlarm: return 7
    case .others: return 8
    }
  }

}

public struct PB_VibrateCnf {
    var type: PB_VibrateType
    var mode: UInt32
    var round: UInt32
    
    func vibrateCnf() -> VibrateCnf {
        var vc = VibrateCnf.init()
        vc.type = VibrateType.init(rawValue: self.type.rawValue)!
        return vc
    }
}

public struct PB_MotorConf {
    var conf:[PB_VibrateCnf]
    func motorConf() -> MotorConf {
        var mc = MotorConf.init()
        mc.conf = self.mConfs()
        return mc
    }
    
    func mConfs() -> [VibrateCnf] {
        var vcfs:[VibrateCnf] = []
        for item in self.conf {
            vcfs.append(item.vibrateCnf())
        }
        return vcfs
    }
}

public struct PB_MotorVibrate {
    var mode: UInt32
    var round: UInt32
    
    func motorConf() -> MotorVibrate {
        var mv = MotorVibrate.init()
        mv.mode = self.mode
        mv.round = self.round
        return mv
    }
}



class DataParseProtobuf: NSObject {

}
