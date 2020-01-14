//
//  DataViewController.swift
//  iwown_blesdk_ios_swift
//
//  Created by A$CE on 2018/6/5.
//  Copyright © 2018年 A$CE. All rights reserved.
//

import UIKit

class DataViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func initParam() {
        _dataSource = NSMutableArray.init(array: [[],[],[]])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() -> Void {
        
    }
}

extension DataViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let arr:NSArray = _dataSource![indexPath.section] as! NSArray
        
        if arr.count > 0 {

        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (_dataSource![section] as! NSArray).count;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (_dataSource?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerRect:CGRect = CGRect(x:0, y:0, width:SCREEN_WIDTH, height:55)
        let vi = UIView.init(frame: headerRect)
        vi.backgroundColor = UIColor.lightGray
        
        let labRect:CGRect = CGRect(x:20, y:0, width:200, height:55)
        let lab = UILabel.init(frame: labRect)
        var labText = "";
        switch section {
        case 0:
            labText = "Hybrid Health Data"
            break;
        case 1:
            labText = "Normal Data 0x61"
            break;
        case 2:
            labText = "GNSS Data 0x62"
            break;
        default:
            break;
        }
        lab.text = labText
        
        vi.addSubview(lab)
        return vi
    }
}


