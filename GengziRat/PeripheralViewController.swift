/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A class to view details of a CBPeripheral.
*/

import CoreBluetooth
import UIKit
import os.log

typealias JSON = Dictionary<String,Any>

/*
{
   "seq":506,
   "ecg":{
      "timeStamp":{
         "dateTime":{
            "seconds":1579886486
         },
         "timeZone":1
      },
      "rawData":[
         27,
    .....
         115,
         160,
         136,
         86
      ]
   }
}*/

struct MyDateTime: Codable {
    let seconds: Int
}

struct TimeStamp: Codable {
    let dateTime: MyDateTime
    let timeZone: Int
}

struct EcgData: Codable {
    let timeStamp: TimeStamp
    let rawData: [Int]
}

struct EcgSeq: Codable {
    let seq: Int
    let ecg: EcgData
}

class PeripheralViewController: UIViewController {
    
    @IBOutlet internal var pTableView: UITableView!
	var cbManager: CBCentralManager?
    var selectedPeripheral: CBPeripheral?
    var readCharacter: CBCharacteristic?
    var writeCharacter: CBCharacteristic?
    var protocType: BTCProtoType = BTCProtoType.nullDefault
    
    let protobufIns = BLEProtobuf.init()
    let iwownIns = BLEIwown.init()

    @IBOutlet weak var textView: UITextView!
    
    private var peripheralConnectedState = false
    
    var ecgData = [Int]()
    var lastSeq: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        textView.text = ""
        protobufIns.bpbDelegate = self
        // Set peripheral delegate
        selectedPeripheral?.delegate = self
		cbManager?.delegate = self
        os_log("Conenect selectedPeripheral : %@", selectedPeripheral ?? "nil")
		cbManager?.connect(selectedPeripheral!, options: nil)
    }
    
    func getHisBlockArray() -> Array<PB_HisBlock> {
        let hisBk = PB_HisBlock.init(startSeq: 0, endSeq: 100)
        return [hisBk]
    }
    
    func loadData() {
        
        /*
           case healthData  // = 0
           case gnssData    // = 1
           case ecgData     // = 2
           case ppgData     // = 3
           case rriData     // = 4
           case medicData   // = 5
           case spo2Data    // = 6
           case swimData    // = 7
        */
        
        guard let writeCharacter = writeCharacter else {
            print("writeCharacter is nil")
            return
        }
        
        var data = protobufIns.getStartSync(type: PB_HisDatatype.ecgData, blocks: self.getHisBlockArray())
        
        selectedPeripheral?.writeValue(data, for: writeCharacter, type: CBCharacteristicWriteType.withoutResponse)
        
        /* Uncomment for other datatypes
        data = protobufIns.getStartSync(type: PB_HisDatatype.healthData, blocks: self.getHisBlockArray())
        
        selectedPeripheral?.writeValue(data, for: writeCharacter, type: CBCharacteristicWriteType.withoutResponse)
        
        data = protobufIns.getStartSync(type: PB_HisDatatype.ppgData, blocks: self.getHisBlockArray())
        
        selectedPeripheral?.writeValue(data, for: writeCharacter, type: CBCharacteristicWriteType.withoutResponse)
        
        data = protobufIns.getStartSync(type: PB_HisDatatype.rriData, blocks: self.getHisBlockArray())
        
        selectedPeripheral?.writeValue(data, for: writeCharacter, type: CBCharacteristicWriteType.withoutResponse)
        
        data = protobufIns.getStartSync(type: PB_HisDatatype.medicData, blocks: self.getHisBlockArray())
        
        selectedPeripheral?.writeValue(data, for: writeCharacter, type: CBCharacteristicWriteType.withoutResponse)
        
        data = protobufIns.getStartSync(type: PB_HisDatatype.spo2Data, blocks: self.getHisBlockArray())
        
        selectedPeripheral?.writeValue(data, for: writeCharacter, type: CBCharacteristicWriteType.withoutResponse)

        data = protobufIns.getStartSync(type: PB_HisDatatype.swimData, blocks: self.getHisBlockArray())
        
        selectedPeripheral?.writeValue(data, for: writeCharacter, type: CBCharacteristicWriteType.withoutResponse)*/

    }
    
}

extension PeripheralViewController: CBCentralManagerDelegate {
	func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
	}

	func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
		os_log("peripheral: %@ connected", peripheral)
        self.title = peripheral.name
        let arr = [BTCProto.protobuf.sampleServiceUUID!,
                   BTCProto.iwown.sampleServiceUUID!]
        peripheral.discoverServices(arr)
	}

	func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
		os_log("peripheral: %@ failed to connect", peripheral)
	}

	func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
		os_log("peripheral: %@ disconnected", peripheral)
        self.title = "NULL"
		// Clean up cached peripheral state
	}
}

extension PeripheralViewController: CBPeripheralDelegate {
	func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
		guard let service = peripheral.services?.first else {
			if let error = error {
				os_log("Error discovering service: %@", "\(error)")
			}
			return
		}
        for scSer in peripheral.services ?? [] {
            let btcI = BTCInsProtoc.instanceProtocol(uuidStr: scSer.uuid.uuidString)
            if btcI != BTCProtoType.nullDefault {
                protocType = btcI
            }
        }
        os_log("Discovered services %@", peripheral.services ?? [])
        peripheral.discoverCharacteristics(nil, for: service)
	}

	func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
		guard let characteristics = service.characteristics else {
			if let error = error {
				os_log("Error discovering characteristic: %@", "\(error)")
			}
			return
		}
        os_log("Discovered characteristics %@", characteristics)
        for character in characteristics {
            switch character.uuid {
            case BTCProto.protobuf.sampleCharacteristicNotifyUUID:
                peripheral.setNotifyValue(true, for: character)
            case BTCProto.protobuf.sampleCharacteristicWriteUUID:
                writeCharacter = character
            case BTCProto.iwown.sampleCharacteristicNotifyUUID:
                peripheral.setNotifyValue(true, for: character)
            case BTCProto.iwown.sampleCharacteristicWriteUUID:
                writeCharacter = character
            default:
                break
            }
        }
        loadData()
	}

	func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let value = characteristic.value as Data? else {
            os_log("Unable to determine the characteristic's value.")
            return
        }
        protobufIns.braceletCmdReceive(data: value)
	}

	func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
		// Accessory's GATT database has updated. Refresh your local cache (if any)
	}
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        selectedPeripheral = peripheral
        readCharacter = characteristic
        os_log("didUpdateNotificationStateFor: %@ - %@", peripheral, characteristic)
    }
}

extension PeripheralViewController: BleProtobufDelegate {
    
    func bleProtobufDidRecieveDeviceInfo(deviceInfo: PB_DeivceInfo) {
        print("bleProtobufDidRecieveDeviceInfo \(deviceInfo)")
        textView.text =  textView.text + "\(deviceInfo)"
    }
    
    func bleProtobufDidRecieveBatteryInfo(batteryInfo: PB_BatteryInfo) {
        print("bleProtobufDidRecieveBatteryInfo \(batteryInfo)")
        textView.text =  textView.text + "\(batteryInfo)"
    }
    
    func bleProtobufDidRecieveRealTimeData(rtData: PB_HealthSummary) {
        print("bleProtobufDidRecieveRealTimeData \(rtData)")
        textView.text =  textView.text + "\(rtData)"
    }
    
    func bleProtobufDidRecieveDataIndexTable(type: PB_HisDatatype, indexTables: [PB_HisIndexTable]) {
        print("bleProtobufDidRecieveDataIndexTable \(type) \(indexTables)")
        
        // So, you need to check per data type what end and start seq are and then wait for all of it to arrive.
        
        var str = ""
        for item in indexTables {
            let snippet = " \(item.date)  \(item.startSeq) \(item.endSeq)"
            str += snippet
            print(snippet)
        }
        
        textView.text =  textView.text + str
        textView.text =  textView.text + "\(type) \(indexTables)"
    }
    
    
    
    func bleProtobufDidRecieveData(type: PB_HisDatatype, hisData: PB_HisData) {
        
        //print("bleProtobufDidRecieveData \(type) \(hisData)")
        textView.text =  textView.text + "\(type) \(hisData)"
        
        // PB_HisData is JSON String, convert to object. Design similar classes to decode other datatypes.
        let str = hisData.jsonData
        //print("str \(str)")
        if let data = str.data(using: .utf8) {
            let decoder = JSONDecoder()
            if let ecgSeq = try? decoder.decode(EcgSeq.self, from: data) {
                print(ecgSeq)
                ecgData.append(contentsOf: ecgSeq.ecg.rawData)
                lastSeq = ecgSeq.seq
            } else {
                print("could not decode")
            }
        } else {
            print("could not convert to data")
        }
    }
    
}

