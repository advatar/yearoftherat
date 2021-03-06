// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: om0_command.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

enum Mc30Powermode: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case high // = 0
  case mid // = 1
  case low // = 2

  init() {
    self = .high
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .high
    case 1: self = .mid
    case 2: self = .low
    default: return nil
    }
  }

  var rawValue: Int {
    switch self {
    case .high: return 0
    case .mid: return 1
    case .low: return 2
    }
  }

}

#if swift(>=4.2)

extension Mc30Powermode: CaseIterable {
  // Support synthesized by the compiler.
}

#endif  // swift(>=4.2)

struct OM0TrackConf {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var hash: UInt32 {
    get {return _hash ?? 0}
    set {_hash = newValue}
  }
  /// Returns true if `hash` has been explicitly set.
  var hasHash: Bool {return self._hash != nil}
  /// Clears the value of `hash`. Subsequent reads from it will return its default value.
  mutating func clearHash() {self._hash = nil}

  var autoRun: Bool {
    get {return _autoRun ?? false}
    set {_autoRun = newValue}
  }
  /// Returns true if `autoRun` has been explicitly set.
  var hasAutoRun: Bool {return self._autoRun != nil}
  /// Clears the value of `autoRun`. Subsequent reads from it will return its default value.
  mutating func clearAutoRun() {self._autoRun = nil}

  var interval: UInt32 {
    get {return _interval ?? 30}
    set {_interval = newValue}
  }
  /// Returns true if `interval` has been explicitly set.
  var hasInterval: Bool {return self._interval != nil}
  /// Clears the value of `interval`. Subsequent reads from it will return its default value.
  mutating func clearInterval() {self._interval = nil}

  var model: String {
    get {return _model ?? String()}
    set {_model = newValue}
  }
  /// Returns true if `model` has been explicitly set.
  var hasModel: Bool {return self._model != nil}
  /// Clears the value of `model`. Subsequent reads from it will return its default value.
  mutating func clearModel() {self._model = nil}

  var version: String {
    get {return _version ?? String()}
    set {_version = newValue}
  }
  /// Returns true if `version` has been explicitly set.
  var hasVersion: Bool {return self._version != nil}
  /// Clears the value of `version`. Subsequent reads from it will return its default value.
  mutating func clearVersion() {self._version = nil}

  var forceUpgrade: Bool {
    get {return _forceUpgrade ?? false}
    set {_forceUpgrade = newValue}
  }
  /// Returns true if `forceUpgrade` has been explicitly set.
  var hasForceUpgrade: Bool {return self._forceUpgrade != nil}
  /// Clears the value of `forceUpgrade`. Subsequent reads from it will return its default value.
  mutating func clearForceUpgrade() {self._forceUpgrade = nil}

  var mc30PowerMode: Mc30Powermode {
    get {return _mc30PowerMode ?? .high}
    set {_mc30PowerMode = newValue}
  }
  /// Returns true if `mc30PowerMode` has been explicitly set.
  var hasMc30PowerMode: Bool {return self._mc30PowerMode != nil}
  /// Clears the value of `mc30PowerMode`. Subsequent reads from it will return its default value.
  mutating func clearMc30PowerMode() {self._mc30PowerMode = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _hash: UInt32? = nil
  fileprivate var _autoRun: Bool? = nil
  fileprivate var _interval: UInt32? = nil
  fileprivate var _model: String? = nil
  fileprivate var _version: String? = nil
  fileprivate var _forceUpgrade: Bool? = nil
  fileprivate var _mc30PowerMode: Mc30Powermode? = nil
}

struct OM0SleepData {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var score: UInt32 {
    get {return _storage._score ?? 0}
    set {_uniqueStorage()._score = newValue}
  }
  /// Returns true if `score` has been explicitly set.
  var hasScore: Bool {return _storage._score != nil}
  /// Clears the value of `score`. Subsequent reads from it will return its default value.
  mutating func clearScore() {_uniqueStorage()._score = nil}

  /// minutes
  var duration: UInt32 {
    get {return _storage._duration ?? 0}
    set {_uniqueStorage()._duration = newValue}
  }
  /// Returns true if `duration` has been explicitly set.
  var hasDuration: Bool {return _storage._duration != nil}
  /// Clears the value of `duration`. Subsequent reads from it will return its default value.
  mutating func clearDuration() {_uniqueStorage()._duration = nil}

  /// minutes
  var deepsleep: UInt32 {
    get {return _storage._deepsleep ?? 0}
    set {_uniqueStorage()._deepsleep = newValue}
  }
  /// Returns true if `deepsleep` has been explicitly set.
  var hasDeepsleep: Bool {return _storage._deepsleep != nil}
  /// Clears the value of `deepsleep`. Subsequent reads from it will return its default value.
  mutating func clearDeepsleep() {_uniqueStorage()._deepsleep = nil}

  /// minutes
  var somnolence: UInt32 {
    get {return _storage._somnolence ?? 0}
    set {_uniqueStorage()._somnolence = newValue}
  }
  /// Returns true if `somnolence` has been explicitly set.
  var hasSomnolence: Bool {return _storage._somnolence != nil}
  /// Clears the value of `somnolence`. Subsequent reads from it will return its default value.
  mutating func clearSomnolence() {_uniqueStorage()._somnolence = nil}

  /// minutes
  var wakefulness: UInt32 {
    get {return _storage._wakefulness ?? 0}
    set {_uniqueStorage()._wakefulness = newValue}
  }
  /// Returns true if `wakefulness` has been explicitly set.
  var hasWakefulness: Bool {return _storage._wakefulness != nil}
  /// Clears the value of `wakefulness`. Subsequent reads from it will return its default value.
  mutating func clearWakefulness() {_uniqueStorage()._wakefulness = nil}

  /// date of sleep data
  var date: RtTime {
    get {return _storage._date ?? RtTime()}
    set {_uniqueStorage()._date = newValue}
  }
  /// Returns true if `date` has been explicitly set.
  var hasDate: Bool {return _storage._date != nil}
  /// Clears the value of `date`. Subsequent reads from it will return its default value.
  mutating func clearDate() {_uniqueStorage()._date = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct OM0Command {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var trackConf: OM0TrackConf {
    get {return _storage._trackConf ?? OM0TrackConf()}
    set {_uniqueStorage()._trackConf = newValue}
  }
  /// Returns true if `trackConf` has been explicitly set.
  var hasTrackConf: Bool {return _storage._trackConf != nil}
  /// Clears the value of `trackConf`. Subsequent reads from it will return its default value.
  mutating func clearTrackConf() {_uniqueStorage()._trackConf = nil}

  var sleepData: OM0SleepData {
    get {return _storage._sleepData ?? OM0SleepData()}
    set {_uniqueStorage()._sleepData = newValue}
  }
  /// Returns true if `sleepData` has been explicitly set.
  var hasSleepData: Bool {return _storage._sleepData != nil}
  /// Clears the value of `sleepData`. Subsequent reads from it will return its default value.
  mutating func clearSleepData() {_uniqueStorage()._sleepData = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct OM0TrackData {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var time: DateTime {
    get {return _storage._time ?? DateTime()}
    set {_uniqueStorage()._time = newValue}
  }
  /// Returns true if `time` has been explicitly set.
  var hasTime: Bool {return _storage._time != nil}
  /// Clears the value of `time`. Subsequent reads from it will return its default value.
  mutating func clearTime() {_uniqueStorage()._time = nil}

  var gnss: RtGNSS {
    get {return _storage._gnss ?? RtGNSS()}
    set {_uniqueStorage()._gnss = newValue}
  }
  /// Returns true if `gnss` has been explicitly set.
  var hasGnss: Bool {return _storage._gnss != nil}
  /// Clears the value of `gnss`. Subsequent reads from it will return its default value.
  mutating func clearGnss() {_uniqueStorage()._gnss = nil}

  var hr: UInt32 {
    get {return _storage._hr ?? 0}
    set {_uniqueStorage()._hr = newValue}
  }
  /// Returns true if `hr` has been explicitly set.
  var hasHr: Bool {return _storage._hr != nil}
  /// Clears the value of `hr`. Subsequent reads from it will return its default value.
  mutating func clearHr() {_uniqueStorage()._hr = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct OM0Response {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var ret: Bool {
    get {return _ret ?? false}
    set {_ret = newValue}
  }
  /// Returns true if `ret` has been explicitly set.
  var hasRet: Bool {return self._ret != nil}
  /// Clears the value of `ret`. Subsequent reads from it will return its default value.
  mutating func clearRet() {self._ret = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _ret: Bool? = nil
}

struct OM0Report {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var sosSignal: Bool {
    get {return _storage._sosSignal ?? false}
    set {_uniqueStorage()._sosSignal = newValue}
  }
  /// Returns true if `sosSignal` has been explicitly set.
  var hasSosSignal: Bool {return _storage._sosSignal != nil}
  /// Clears the value of `sosSignal`. Subsequent reads from it will return its default value.
  mutating func clearSosSignal() {_uniqueStorage()._sosSignal = nil}

  var wakeUp: Bool {
    get {return _storage._wakeUp ?? false}
    set {_uniqueStorage()._wakeUp = newValue}
  }
  /// Returns true if `wakeUp` has been explicitly set.
  var hasWakeUp: Bool {return _storage._wakeUp != nil}
  /// Clears the value of `wakeUp`. Subsequent reads from it will return its default value.
  mutating func clearWakeUp() {_uniqueStorage()._wakeUp = nil}

  var trackData: [OM0TrackData] {
    get {return _storage._trackData}
    set {_uniqueStorage()._trackData = newValue}
  }

  var battery: RtBattery {
    get {return _storage._battery ?? RtBattery()}
    set {_uniqueStorage()._battery = newValue}
  }
  /// Returns true if `battery` has been explicitly set.
  var hasBattery: Bool {return _storage._battery != nil}
  /// Clears the value of `battery`. Subsequent reads from it will return its default value.
  mutating func clearBattery() {_uniqueStorage()._battery = nil}

  var health: RtHealth {
    get {return _storage._health ?? RtHealth()}
    set {_uniqueStorage()._health = newValue}
  }
  /// Returns true if `health` has been explicitly set.
  var hasHealth: Bool {return _storage._health != nil}
  /// Clears the value of `health`. Subsequent reads from it will return its default value.
  mutating func clearHealth() {_uniqueStorage()._health = nil}

  var dateTime: DateTime {
    get {return _storage._dateTime ?? DateTime()}
    set {_uniqueStorage()._dateTime = newValue}
  }
  /// Returns true if `dateTime` has been explicitly set.
  var hasDateTime: Bool {return _storage._dateTime != nil}
  /// Clears the value of `dateTime`. Subsequent reads from it will return its default value.
  mutating func clearDateTime() {_uniqueStorage()._dateTime = nil}

  var rssi: UInt32 {
    get {return _storage._rssi ?? 0}
    set {_uniqueStorage()._rssi = newValue}
  }
  /// Returns true if `rssi` has been explicitly set.
  var hasRssi: Bool {return _storage._rssi != nil}
  /// Clears the value of `rssi`. Subsequent reads from it will return its default value.
  mutating func clearRssi() {_uniqueStorage()._rssi = nil}

  var sleepData: OM0SleepData {
    get {return _storage._sleepData ?? OM0SleepData()}
    set {_uniqueStorage()._sleepData = newValue}
  }
  /// Returns true if `sleepData` has been explicitly set.
  var hasSleepData: Bool {return _storage._sleepData != nil}
  /// Clears the value of `sleepData`. Subsequent reads from it will return its default value.
  mutating func clearSleepData() {_uniqueStorage()._sleepData = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension Mc30Powermode: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "HIGH"),
    1: .same(proto: "MID"),
    2: .same(proto: "LOW"),
  ]
}

extension OM0TrackConf: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "OM0TrackConf"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "hash"),
    2: .standard(proto: "auto_run"),
    3: .same(proto: "interval"),
    4: .same(proto: "model"),
    5: .same(proto: "version"),
    6: .standard(proto: "force_upgrade"),
    7: .standard(proto: "mc30_power_mode"),
  ]

  public var isInitialized: Bool {
    if self._hash == nil {return false}
    if self._autoRun == nil {return false}
    if self._interval == nil {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularFixed32Field(value: &self._hash)
      case 2: try decoder.decodeSingularBoolField(value: &self._autoRun)
      case 3: try decoder.decodeSingularFixed32Field(value: &self._interval)
      case 4: try decoder.decodeSingularStringField(value: &self._model)
      case 5: try decoder.decodeSingularStringField(value: &self._version)
      case 6: try decoder.decodeSingularBoolField(value: &self._forceUpgrade)
      case 7: try decoder.decodeSingularEnumField(value: &self._mc30PowerMode)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._hash {
      try visitor.visitSingularFixed32Field(value: v, fieldNumber: 1)
    }
    if let v = self._autoRun {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 2)
    }
    if let v = self._interval {
      try visitor.visitSingularFixed32Field(value: v, fieldNumber: 3)
    }
    if let v = self._model {
      try visitor.visitSingularStringField(value: v, fieldNumber: 4)
    }
    if let v = self._version {
      try visitor.visitSingularStringField(value: v, fieldNumber: 5)
    }
    if let v = self._forceUpgrade {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 6)
    }
    if let v = self._mc30PowerMode {
      try visitor.visitSingularEnumField(value: v, fieldNumber: 7)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: OM0TrackConf, rhs: OM0TrackConf) -> Bool {
    if lhs._hash != rhs._hash {return false}
    if lhs._autoRun != rhs._autoRun {return false}
    if lhs._interval != rhs._interval {return false}
    if lhs._model != rhs._model {return false}
    if lhs._version != rhs._version {return false}
    if lhs._forceUpgrade != rhs._forceUpgrade {return false}
    if lhs._mc30PowerMode != rhs._mc30PowerMode {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension OM0SleepData: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "OM0SleepData"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "score"),
    2: .same(proto: "duration"),
    3: .same(proto: "deepsleep"),
    4: .same(proto: "somnolence"),
    5: .same(proto: "wakefulness"),
    6: .same(proto: "date"),
  ]

  fileprivate class _StorageClass {
    var _score: UInt32? = nil
    var _duration: UInt32? = nil
    var _deepsleep: UInt32? = nil
    var _somnolence: UInt32? = nil
    var _wakefulness: UInt32? = nil
    var _date: RtTime? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _score = source._score
      _duration = source._duration
      _deepsleep = source._deepsleep
      _somnolence = source._somnolence
      _wakefulness = source._wakefulness
      _date = source._date
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  public var isInitialized: Bool {
    return withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if _storage._score == nil {return false}
      if _storage._duration == nil {return false}
      if _storage._deepsleep == nil {return false}
      if _storage._somnolence == nil {return false}
      if _storage._wakefulness == nil {return false}
      if _storage._date == nil {return false}
      if let v = _storage._date, !v.isInitialized {return false}
      return true
    }
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularFixed32Field(value: &_storage._score)
        case 2: try decoder.decodeSingularFixed32Field(value: &_storage._duration)
        case 3: try decoder.decodeSingularFixed32Field(value: &_storage._deepsleep)
        case 4: try decoder.decodeSingularFixed32Field(value: &_storage._somnolence)
        case 5: try decoder.decodeSingularFixed32Field(value: &_storage._wakefulness)
        case 6: try decoder.decodeSingularMessageField(value: &_storage._date)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._score {
        try visitor.visitSingularFixed32Field(value: v, fieldNumber: 1)
      }
      if let v = _storage._duration {
        try visitor.visitSingularFixed32Field(value: v, fieldNumber: 2)
      }
      if let v = _storage._deepsleep {
        try visitor.visitSingularFixed32Field(value: v, fieldNumber: 3)
      }
      if let v = _storage._somnolence {
        try visitor.visitSingularFixed32Field(value: v, fieldNumber: 4)
      }
      if let v = _storage._wakefulness {
        try visitor.visitSingularFixed32Field(value: v, fieldNumber: 5)
      }
      if let v = _storage._date {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: OM0SleepData, rhs: OM0SleepData) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._score != rhs_storage._score {return false}
        if _storage._duration != rhs_storage._duration {return false}
        if _storage._deepsleep != rhs_storage._deepsleep {return false}
        if _storage._somnolence != rhs_storage._somnolence {return false}
        if _storage._wakefulness != rhs_storage._wakefulness {return false}
        if _storage._date != rhs_storage._date {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension OM0Command: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "OM0Command"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "track_conf"),
    2: .standard(proto: "sleep_data"),
  ]

  fileprivate class _StorageClass {
    var _trackConf: OM0TrackConf? = nil
    var _sleepData: OM0SleepData? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _trackConf = source._trackConf
      _sleepData = source._sleepData
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  public var isInitialized: Bool {
    return withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._trackConf, !v.isInitialized {return false}
      if let v = _storage._sleepData, !v.isInitialized {return false}
      return true
    }
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularMessageField(value: &_storage._trackConf)
        case 2: try decoder.decodeSingularMessageField(value: &_storage._sleepData)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._trackConf {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
      if let v = _storage._sleepData {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: OM0Command, rhs: OM0Command) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._trackConf != rhs_storage._trackConf {return false}
        if _storage._sleepData != rhs_storage._sleepData {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension OM0TrackData: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "OM0TrackData"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "time"),
    2: .same(proto: "gnss"),
    3: .same(proto: "hr"),
  ]

  fileprivate class _StorageClass {
    var _time: DateTime? = nil
    var _gnss: RtGNSS? = nil
    var _hr: UInt32? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _time = source._time
      _gnss = source._gnss
      _hr = source._hr
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  public var isInitialized: Bool {
    return withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if _storage._time == nil {return false}
      if let v = _storage._time, !v.isInitialized {return false}
      if let v = _storage._gnss, !v.isInitialized {return false}
      return true
    }
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularMessageField(value: &_storage._time)
        case 2: try decoder.decodeSingularMessageField(value: &_storage._gnss)
        case 3: try decoder.decodeSingularFixed32Field(value: &_storage._hr)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._time {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
      if let v = _storage._gnss {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      }
      if let v = _storage._hr {
        try visitor.visitSingularFixed32Field(value: v, fieldNumber: 3)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: OM0TrackData, rhs: OM0TrackData) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._time != rhs_storage._time {return false}
        if _storage._gnss != rhs_storage._gnss {return false}
        if _storage._hr != rhs_storage._hr {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension OM0Response: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "OM0Response"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "ret"),
  ]

  public var isInitialized: Bool {
    if self._ret == nil {return false}
    return true
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBoolField(value: &self._ret)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._ret {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: OM0Response, rhs: OM0Response) -> Bool {
    if lhs._ret != rhs._ret {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension OM0Report: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "OM0Report"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "sos_signal"),
    2: .standard(proto: "wake_up"),
    3: .standard(proto: "track_data"),
    4: .same(proto: "battery"),
    5: .same(proto: "health"),
    6: .standard(proto: "date_time"),
    7: .same(proto: "rssi"),
    8: .standard(proto: "sleep_data"),
  ]

  fileprivate class _StorageClass {
    var _sosSignal: Bool? = nil
    var _wakeUp: Bool? = nil
    var _trackData: [OM0TrackData] = []
    var _battery: RtBattery? = nil
    var _health: RtHealth? = nil
    var _dateTime: DateTime? = nil
    var _rssi: UInt32? = nil
    var _sleepData: OM0SleepData? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _sosSignal = source._sosSignal
      _wakeUp = source._wakeUp
      _trackData = source._trackData
      _battery = source._battery
      _health = source._health
      _dateTime = source._dateTime
      _rssi = source._rssi
      _sleepData = source._sleepData
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  public var isInitialized: Bool {
    return withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if !SwiftProtobuf.Internal.areAllInitialized(_storage._trackData) {return false}
      if let v = _storage._battery, !v.isInitialized {return false}
      if let v = _storage._health, !v.isInitialized {return false}
      if let v = _storage._dateTime, !v.isInitialized {return false}
      if let v = _storage._sleepData, !v.isInitialized {return false}
      return true
    }
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularBoolField(value: &_storage._sosSignal)
        case 2: try decoder.decodeSingularBoolField(value: &_storage._wakeUp)
        case 3: try decoder.decodeRepeatedMessageField(value: &_storage._trackData)
        case 4: try decoder.decodeSingularMessageField(value: &_storage._battery)
        case 5: try decoder.decodeSingularMessageField(value: &_storage._health)
        case 6: try decoder.decodeSingularMessageField(value: &_storage._dateTime)
        case 7: try decoder.decodeSingularFixed32Field(value: &_storage._rssi)
        case 8: try decoder.decodeSingularMessageField(value: &_storage._sleepData)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._sosSignal {
        try visitor.visitSingularBoolField(value: v, fieldNumber: 1)
      }
      if let v = _storage._wakeUp {
        try visitor.visitSingularBoolField(value: v, fieldNumber: 2)
      }
      if !_storage._trackData.isEmpty {
        try visitor.visitRepeatedMessageField(value: _storage._trackData, fieldNumber: 3)
      }
      if let v = _storage._battery {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
      }
      if let v = _storage._health {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
      }
      if let v = _storage._dateTime {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
      }
      if let v = _storage._rssi {
        try visitor.visitSingularFixed32Field(value: v, fieldNumber: 7)
      }
      if let v = _storage._sleepData {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 8)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: OM0Report, rhs: OM0Report) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._sosSignal != rhs_storage._sosSignal {return false}
        if _storage._wakeUp != rhs_storage._wakeUp {return false}
        if _storage._trackData != rhs_storage._trackData {return false}
        if _storage._battery != rhs_storage._battery {return false}
        if _storage._health != rhs_storage._health {return false}
        if _storage._dateTime != rhs_storage._dateTime {return false}
        if _storage._rssi != rhs_storage._rssi {return false}
        if _storage._sleepData != rhs_storage._sleepData {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
