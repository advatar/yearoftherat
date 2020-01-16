# Introduction

Bluetooth SDK and Demo written in Swift

# Tutorial

### Step 1: Integrated
- Use CocoaPods: `pod 'GengziRat'`
- Drag *Products* dir in your project, then download 'https://github.com/apple/swift-protobuf.git' lib file and add it in your project too.

### Step 2: Uuids
Use CoreBluetooth create CentralManager to communicate with Peripheral device. The uuid information of our device is as follows:
	
```swift
struct PROTOBUF_UUID_STR {
    static let serviceUuid:String = "2E8C0001-2D91-5533-3117-59380A40AF8F"
    static let notifyUuid:String = "2E8C0002-2D91-5533-3117-59380A40AF8F"
    static let writeUuid:String = "2E8C0003-2D91-5533-3117-59380A40AF8F"
}
```
### Step 3: Constitute an instance
* 1. Create instance 
* 2. Strong return Peripheral & CBCharacteristic
	
```swift
	//1. 
   	var selectedPeripheral: CBPeripheral?
   	var readCharacter: CBCharacteristic?
	var writeCharacter: CBCharacteristic?
	let protobufIns = BLEProtobuf.init()
	
	//2.
	func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {     
		...
   		writeCharacter = character
		...
	}
	
	func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        selectedPeripheral = peripheral
        readCharacter = characteristic
        os_log("didUpdateNotificationStateFor: %@ - %@", peripheral, characteristic)
    }
	
```

### Step 4: Read Device Info
* 1. Build conf struct for protobufIns and write data to Peripheral
* 2. Implement the callback mathod recieve data
 
```swift
	//Cmd
	let data = protobufIns.getDeviceInfo()
	selectedPeripheral?.writeValue(data, for: writeCharacter!, type: CBCharacteristicWriteType.withoutResponse)

	//CallBack
    func bleProtobufDidRecieveDeviceInfo(deviceInfo: DeviceInfoResponse) {
        print("bleProtobufDidRecieveDeviceInfo \(deviceInfo)")
    }
```

### Step 5: Sync Data
* Realtime Data

```swift
	//cmd
 	let data = protobufIns.getRealTimeData()
 	selectedPeripheral?.writeValue(data, for: writeCharacter!, type: CBCharacteristicWriteType.withoutResponse)
 	
 	//callback
    func bleProtobufDidRecieveRealTimeData(rtData: RtHealth) {
        print("bleProtobufDidRecieveRealTimeData \(rtData)")
    } 	
```

* History
	- 1.get data IndexTable
	- 2.get detail history data

```swift
	//cmd indextable
	guard let data = pVC?.protobufIns.getSyncDataIndexTable(type: HisDataType.healthData) else {
  		return
    }
   	let writeCharacter:CBCharacteristic = pVC!.writeCharacter!
    pVC?.selectedPeripheral?.writeValue(data, for: writeCharacter, type: CBCharacteristicWriteType.withoutResponse)
    
    //cmd history data
    let data = pVC!.protobufIns.getStartSync(type: HisDataType.healthData, blocks: self.getHisBlockArray())
    let writeCharacter:CBCharacteristic = pVC!.writeCharacter!
    pVC?.selectedPeripheral?.writeValue(data, for: writeCharacter, type: CBCharacteristicWriteType.withoutResponse)	
    func getHisBlockArray() -> Array<HisBlock> {
        var hisBk = HisBlock.init()
        hisBk.startSeq = 0
        hisBk.endSeq = 100
        return [hisBk]
    }
	
	//callback indextable
	func bleProtobufDidRecieveDataIndexTable(type: HisDataType, indexTable: HisIndexTable) {
        print("bleProtobufDidRecieveDataIndexTable \(type) \(indexTable)")
    }
    
	//callback history data
    func bleProtobufDidRecieveData(type: HisDataType, hisData: HisData) {
        print("bleProtobufDidRecieveData \(type) \(hisData)")
    }
```

### Step 6: Device Config
* Motor feeling

```swift
    var mv:MotorVibrate = MotorVibrate.init()
    mv.mode = MotorShakeWay.Light
    mv.round = 3
    let data = protobufIns.getMotorConf(vCnf: mv)
    selectedPeripheral?.writeValue(data, for: writeCharacter!, type: CBCharacteristicWriteType.withoutResponse)
```

* Motor cofigure

```swift
	var mc:MotorConf = MotorConf.init()
	var vc:VibrateCnf = VibrateCnf.init()
	vc.mode = MotorShakeWay.Light
	vc.type = VibrateType.sms
	vc.round = 5
	mc.conf = [vc]
	let mData = protobufIns.getMotorConf(motorConf: mc)
	selectedPeripheral?.writeValue(mData, for: writeCharacter!, type: CBCharacteristicWriteType.withoutResponse)
```

******
**to be continue**
