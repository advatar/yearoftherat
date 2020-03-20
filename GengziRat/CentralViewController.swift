/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A class to monitor bluetooth connections.
*/

import CoreBluetooth
import UIKit
import os.log

struct BTConstants {
    // These are sample GATT service strings. Your accessory will need to include these services/characteristics in its GATT database
    var sampleServiceUUID:CBUUID?
    var sampleCharacteristicNotifyUUID:CBUUID?
    var sampleCharacteristicWriteUUID:CBUUID?
}

struct BTCProto {
    static let protobuf = BTConstants.init(sampleServiceUUID: CBUUID(string: PROTOBUF_UUID_STR.serviceUuid), sampleCharacteristicNotifyUUID: CBUUID(string: PROTOBUF_UUID_STR.notifyUuid), sampleCharacteristicWriteUUID: CBUUID(string: PROTOBUF_UUID_STR.writeUuid))
    static let iwown = BTConstants.init(sampleServiceUUID: CBUUID(string: IWOWN_UUID_STR.serviceUuid), sampleCharacteristicNotifyUUID: CBUUID(string: IWOWN_UUID_STR.notifyUuid), sampleCharacteristicWriteUUID: CBUUID(string: IWOWN_UUID_STR.writeUuid))
    
    static let nullDefault = BTConstants.init()
}

public enum BTCProtoType {
    case nullDefault
    case protobuf
    case iwown
}

struct BTCInsProtoc {
    static func instanceProtocol(uuidStr: String) -> BTCProtoType {
        switch uuidStr {
        case BTCProto.iwown.sampleServiceUUID!.uuidString:
            return BTCProtoType.iwown
        case BTCProto.protobuf.sampleServiceUUID!.uuidString:
            return BTCProtoType.protobuf
        default:
            return BTCProtoType.nullDefault
        }
    }
}

class CentralViewController: UIViewController {
    @IBOutlet internal var tableView: UITableView!
    private var cbManager: CBCentralManager!
    private var cbState = CBManagerState.unknown
    private var cbPeripherals = [CBPeripheral]()
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.dataSource = self
		tableView.reloadData()
        
        self.initUI()
    }
    
    func initUI() -> Void {
        self.title = "MidAutumn"
        let item=UIBarButtonItem(title: "Scan", style: UIBarButtonItem.Style.plain, target: self, action: #selector(resetTable))
        item.tintColor = UIColor.blue
        self.navigationItem.rightBarButtonItem=item
    }
    
    @objc func scanTimeOut() {
        os_log("scanTimeOut **************")
        cbManager.stopScan()
    }
    
    @objc func resetTable() {
        cbPeripherals.removeAll()
        tableView.reloadData()
        
        cbManager = CBCentralManager(delegate: self, queue: nil)
        self.perform(#selector(scanTimeOut), with: nil, afterDelay: 3)
    }
    
    @objc func scanDevice() -> Void {
        let matchingOptions = [CBConnectionEventMatchingOption.serviceUUIDs: [BTCProto.protobuf.sampleServiceUUID]]
        cbManager.registerForConnectionEvents(options: matchingOptions)
        cbManager.scanForPeripherals(withServices: nil, options: nil)
    }
}

extension CentralViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cbPeripherals.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "peripheralCell", for: indexPath)
		let index = indexPath.row
		cell.textLabel?.text = "\(cbPeripherals[index].name ?? "CBPeripheral")"
		return cell
	}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let destinationVc:PeripheralViewController = storyBoard.instantiateViewController(identifier: "PeripheralViewController")
        self.navigationController?.pushViewController(destinationVc, animated: true)
        destinationVc.cbManager = cbManager
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        destinationVc.selectedPeripheral = cbPeripherals[indexPath.row]
    }
}

extension CentralViewController: CBCentralManagerDelegate {
	func centralManagerDidUpdateState(_ central: CBCentralManager) {
		// In your application, you would address each possible value of central.state and central.authorization
		switch central.state {
		case .resetting:
			os_log("Connection with the system service was momentarily lost. Update imminent")
		case .unsupported:
			os_log("Platform does not support the Bluetooth Low Energy Central/Client role")
		case .unauthorized:
			switch central.authorization {
			case .restricted:
				os_log("Bluetooth is restricted on this device")
			case .denied:
				os_log("The application is not authorized to use the Bluetooth Low Energy role")
			default:
				os_log("Something went wrong. Cleaning up cbManager")
			}
		case .poweredOff:
			os_log("Bluetooth is currently powered off")
		case .poweredOn:
			os_log("Starting cbManager")
            self.scanDevice()
		default:
			os_log("Cleaning up cbManager")
		}
	}

	func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
		os_log("connectionEventDidOccur for peripheral: %@", peripheral)
		switch event {
		case .peerConnected:
			cbPeripherals.append(peripheral)
		case .peerDisconnected:
			os_log("Peer %@ disconnected!", peripheral)
		default:
			if let idx = cbPeripherals.firstIndex(where: { $0 === peripheral }) {
				cbPeripherals.remove(at: idx)
			}
		}
		tableView.reloadData()
	}
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        for item in cbPeripherals {
            if item.name == peripheral.name  {
                return
            }
        }
        cbPeripherals.append(peripheral)
        tableView.reloadData()
    }

	func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
		os_log("peripheral: %@ connected", peripheral)
	}

	func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
		os_log("peripheral: %@ failed to connect", peripheral)
	}

	func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
		os_log("peripheral: %@ disconnected", peripheral)
	}
}

