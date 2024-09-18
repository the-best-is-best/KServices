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
        KServices.get(service: "myServices", account: "michelle") { data, error in
                if let error = error {
                    print("Failed to retrieve data: \(error)")
                } else if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Retrieved data: \(dataString)")
                } else {
                    print("No data found")
                }
            }
        
    //    KServices.save(service: "myServices", account: "michelle", data: "i'm micelle".data(using: .utf8)!) { error in
    //        if let error = error {
    //            print("Failed to save data: \(error)")
    //        } else {
    //            print("Data saved successfully")

    //        }
    //    }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

