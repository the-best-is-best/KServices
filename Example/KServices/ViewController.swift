//
//  ViewController.swift
//  KServices
//
//  Created by 72160249 on 09/17/2024.
//  Copyright (c) 2024 72160249. All rights reserved.
//

import UIKit
import KServices
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            //            try KServices.save(service: "myServices", account: "michelle", data: "somthing$as".data(using: .utf8)!
            //            )
            //            print("saved")
            
            if let data = try KServices.get(service: "myServices", account: "michelle") {
                print("data is \(data)") // This will print the actual value without "Optional"
            } else {
                print("No data found")
            }
        } catch {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

