//
//  DBHelper.swift
//  Core Data Demo
//
//  Created by Zeitech Solutions on 04/10/17.
//  Copyright © 2017 Core Data Test. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DBHelper{
    
    @available(iOS 10.0, *)
    public static func getContext() -> NSManagedObjectContext{
        if #available(iOS 10.0, *) {
            return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        } else {
            return DatabaseController.getContext()
        }
    }
    
    public static func saveContext() {
        if #available(iOS 10.0, *) {
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        } else {
           DatabaseController.saveContext()
        }
    }
    
    public static func saveData(name: String, mobile: String, city: String){
        if #available(iOS 10.0, *) {
            let data = MyData(context: getContext())
            data.name = name
            data.mobile = mobile
            data.city = city
        } else {
            let entity =  NSEntityDescription.entity(forEntityName: "MyData",
                                                     in:DatabaseController.managedObjectContext)
            let data = NSManagedObject(entity: entity!,
                                         insertInto: DatabaseController.managedObjectContext) as! MyData
            data.name = name
            data.mobile = mobile
            data.city = city
            
            do {
                try DatabaseController.managedObjectContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
        saveContext()
    }
    
    public static func getData()-> [MyData]{
        var data:[MyData] = []
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "MyData")
        do {
            if #available(iOS 10.0, *) {
                data =  try getContext().fetch(fetchReq) as! [MyData]
            } else {
                data = try DatabaseController.getContext().fetch(fetchReq) as! [MyData]
            }
        } catch{
            print("Error while fetching data")
        }
        return data
    }

}
