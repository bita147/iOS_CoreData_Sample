//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Zeitech Solutions on 04/10/17.
//  Copyright © 2017 Core Data Test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelData: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadData()
    }
 
    @IBAction func addDataTapped(_ sender: Any) {
        let insert = UIAlertController(title: "Add", message: "Enter Data", preferredStyle: .alert)
        insert.addTextField { (textField) in
            textField.placeholder = "Name"
            textField.autocapitalizationType = .words
        }
        insert.addTextField { (textField) in
            textField.placeholder = "Phone"
            textField.keyboardType = .numberPad
        }
        insert.addTextField { (textField) in
            textField.placeholder = "City"
            textField.autocapitalizationType = .words
        }
        insert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (alert) in
            let etName = insert.textFields?[0]
            let etMobile = insert.textFields?[1]
            let etCity = insert.textFields?[2]
            
            if etName?.text != nil && (etName?.text?.characters.count)! > 0 &&
                etMobile?.text != nil && (etMobile?.text?.characters.count)! > 0 &&
                etCity?.text != nil && (etCity?.text?.characters.count)! > 0 {
                DBHelper.saveData(name: (etName?.text)!, mobile: (etMobile?.text)!, city: (etCity?.text)!)
                self.reloadData()
            }
        }))
       self.present(insert, animated: true, completion: nil)
    }
    
    func reloadData(){
        let data = DBHelper.getData()
        self.labelData.text = ""
        if data.count > 0 {
            for d in data {
                self.labelData.text?.append("\(String(describing: d.name!))\t\t\(String(describing: d.mobile!))\t\t\(String(describing: d.city!)) \n")
            }
            self.labelData.sizeToFit()
        }
    }
}

