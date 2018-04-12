//
//  CoreDataManager.swift
//  iOSRecruitmentTest
//
//  Created by Kordian Ledzion on 22/03/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager: DataSource {
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func add(_ items: [DataModel]) {
        for item in items {
            let newItem = RecruitmentItem(entity: RecruitmentItem.entity(), insertInto: context)
            newItem.copy(item)
            appDelegate.saveContext()
        }
    }
    
    func getAllItems() -> [RecruitmentItem] {
        var items = [RecruitmentItem]()
        do {
            items = try context.fetch(RecruitmentItem.fetchRequest())
        } catch let error as NSError {
            NSLog("Core Data Fetching error: \(error), \(error.userInfo)")
            abort()
        }
        return items
    }
    
    func deleteAll() {
        for object in try! context.fetch(RecruitmentItem.fetchRequest()) {
            context.delete(object as! NSManagedObject)
        }
    }
    
}
