//
//
// ViewController.swift
// ObjCSwiftCrossDataModelConversionDemo
//
// Created by Alexandre Hu (HU JEN EN) on 2021/7/30
// Copyright © 2021 Alexandre Hu. All rights reserved.
//
        

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }

    func getData() {
        BaseDataModel.action { responseData, error in
            guard error == nil else { return }
            guard let responseData = responseData else { return }
            print(responseData)
        }
    }

}

