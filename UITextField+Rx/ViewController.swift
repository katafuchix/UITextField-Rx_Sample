//
//  ViewController.swift
//  UITextField+Rx
//
//  Created by cano on 2021/05/16.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.textField.rx.editingDidEnd.subscribe(onNext: { value in
            print(value)
        }).disposed(by: rx.disposeBag)
        
        self.textField.rx.textFieldDidBeginEditing.subscribe(onNext: { value in
            print("editing start")
            print(value)
        }).disposed(by: rx.disposeBag)
    }

    

}

