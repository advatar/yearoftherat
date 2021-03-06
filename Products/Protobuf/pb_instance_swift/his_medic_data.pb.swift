// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: his_medic_data.proto
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

struct HisDataMedic {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var timeStamp: DateTime {
    get {return _storage._timeStamp ?? DateTime()}
    set {_uniqueStorage()._timeStamp = newValue}
  }
  /// Returns true if `timeStamp` has been explicitly set.
  var hasTimeStamp: Bool {return _storage._timeStamp != nil}
  /// Clears the value of `timeStamp`. Subsequent reads from it will return its default value.
  mutating func clearTimeStamp() {_uniqueStorage()._timeStamp = nil}

  var painLevel: UInt32 {
    get {return _storage._painLevel ?? 0}
    set {_uniqueStorage()._painLevel = newValue}
  }
  /// Returns true if `painLevel` has been explicitly set.
  var hasPainLevel: Bool {return _storage._painLevel != nil}
  /// Clears the value of `painLevel`. Subsequent reads from it will return its default value.
  mutating func clearPainLevel() {_uniqueStorage()._painLevel = nil}

  var fatigueLevel: UInt32 {
    get {return _storage._fatigueLevel ?? 0}
    set {_uniqueStorage()._fatigueLevel = newValue}
  }
  /// Returns true if `fatigueLevel` has been explicitly set.
  var hasFatigueLevel: Bool {return _storage._fatigueLevel != nil}
  /// Clears the value of `fatigueLevel`. Subsequent reads from it will return its default value.
  mutating func clearFatigueLevel() {_uniqueStorage()._fatigueLevel = nil}

  var stiffLevel: UInt32 {
    get {return _storage._stiffLevel ?? 0}
    set {_uniqueStorage()._stiffLevel = newValue}
  }
  /// Returns true if `stiffLevel` has been explicitly set.
  var hasStiffLevel: Bool {return _storage._stiffLevel != nil}
  /// Clears the value of `stiffLevel`. Subsequent reads from it will return its default value.
  mutating func clearStiffLevel() {_uniqueStorage()._stiffLevel = nil}

  var stiffTime: UInt32 {
    get {return _storage._stiffTime ?? 0}
    set {_uniqueStorage()._stiffTime = newValue}
  }
  /// Returns true if `stiffTime` has been explicitly set.
  var hasStiffTime: Bool {return _storage._stiffTime != nil}
  /// Clears the value of `stiffTime`. Subsequent reads from it will return its default value.
  mutating func clearStiffTime() {_uniqueStorage()._stiffTime = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension HisDataMedic: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "HisDataMedic"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "time_stamp"),
    2: .standard(proto: "pain_level"),
    3: .standard(proto: "fatigue_level"),
    4: .standard(proto: "stiff_level"),
    5: .standard(proto: "stiff_time"),
  ]

  fileprivate class _StorageClass {
    var _timeStamp: DateTime? = nil
    var _painLevel: UInt32? = nil
    var _fatigueLevel: UInt32? = nil
    var _stiffLevel: UInt32? = nil
    var _stiffTime: UInt32? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _timeStamp = source._timeStamp
      _painLevel = source._painLevel
      _fatigueLevel = source._fatigueLevel
      _stiffLevel = source._stiffLevel
      _stiffTime = source._stiffTime
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
      if _storage._timeStamp == nil {return false}
      if let v = _storage._timeStamp, !v.isInitialized {return false}
      return true
    }
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularMessageField(value: &_storage._timeStamp)
        case 2: try decoder.decodeSingularFixed32Field(value: &_storage._painLevel)
        case 3: try decoder.decodeSingularFixed32Field(value: &_storage._fatigueLevel)
        case 4: try decoder.decodeSingularFixed32Field(value: &_storage._stiffLevel)
        case 5: try decoder.decodeSingularFixed32Field(value: &_storage._stiffTime)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._timeStamp {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
      if let v = _storage._painLevel {
        try visitor.visitSingularFixed32Field(value: v, fieldNumber: 2)
      }
      if let v = _storage._fatigueLevel {
        try visitor.visitSingularFixed32Field(value: v, fieldNumber: 3)
      }
      if let v = _storage._stiffLevel {
        try visitor.visitSingularFixed32Field(value: v, fieldNumber: 4)
      }
      if let v = _storage._stiffTime {
        try visitor.visitSingularFixed32Field(value: v, fieldNumber: 5)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: HisDataMedic, rhs: HisDataMedic) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._timeStamp != rhs_storage._timeStamp {return false}
        if _storage._painLevel != rhs_storage._painLevel {return false}
        if _storage._fatigueLevel != rhs_storage._fatigueLevel {return false}
        if _storage._stiffLevel != rhs_storage._stiffLevel {return false}
        if _storage._stiffTime != rhs_storage._stiffTime {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
