//
//  LogsViewController.swift
//  CoreBluetoothClassicSample
//
//  Created by A$CE on 2020/1/13.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class LogsViewController: UIViewController {

    let textView = UITextView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
        
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
        //开始计时器
        timer.fire()
        // Do any additional setup after loading the view.
    }
    
    func initUI() -> Void {
        self.view.backgroundColor = UIColor.white
        
        textView.frame = self.view.bounds
    }
    
    @objc func timeAction() -> Void {
        textView.text = LogManager.sharedInstance.textContent
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
