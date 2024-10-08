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
      
        let service = "exampleService"
        let account = "exampleAccount"
        let data = "ExampleData".data(using: .utf8)!

        // Save data to the keychain
        KServices.saveDataType(service: service, account: account, data: data) { error in
            if let error = error {
                print("Failed to save data with error: \(error)")
            } else {
                print("Data saved successfully!")
                
                // Retrieve the saved data
                KServices.getDataType(service: service, account: account) { result, error in
                    if let error = error {
                        print("Failed to retrieve data with error: \(error)")
                    } else if let result = result {
                        
                        print("Retrieved data: \(String(data: result , encoding: .utf8)!)")
                    } else {
                        print("No data found.")
                    }
                }
            }
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

