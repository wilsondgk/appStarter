//
//  CoreDataProvider.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 30/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation
import CoreData

protocol LocalApiProtocol {
    func getContext() -> NSManagedObjectContext
    func fetch<T: NSManagedObject>(_ entity: T.Type, predicate: NSPredicate?, successCompletion: @escaping(_ fetchedArray:[T]) -> Void, failCompletion: @escaping(_ error: Error) -> Void)
    func saveObject(_ object: NSManagedObject, successCompletion: @escaping() -> Void, failCompletion: @escaping(_ error: Error) -> Void)
    func delete<T: NSManagedObject>(_ entity: T.Type, predicate: NSPredicate, successCompletion: @escaping() -> Void, failCompletion: @escaping(_ error: Error) -> Void)
}

class CoreDataProvider: LocalApiProtocol {
    
    let context: NSManagedObjectContext
    
    init(withContext context: NSManagedObjectContext) {
        self.context = context
    }
    
    func getContext() -> NSManagedObjectContext {
        return context
    }
    
    func fetch<T: NSManagedObject>(_ entity: T.Type,
                                     predicate: NSPredicate? = nil,
                                     successCompletion: @escaping(_ fetchedArray: [T]) -> Void,
                                     failCompletion: @escaping(_ error: Error) -> Void) {
        let fetchRequest = NSFetchRequest<T>(entityName: NSStringFromClass(T.self))
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let searchResult = try context.fetch(fetchRequest)
            successCompletion(searchResult.count > 0 ? searchResult : [])
        } catch {
            failCompletion(error)
        }
    }
    
    func saveObject(_ object: NSManagedObject, successCompletion: @escaping() -> Void, failCompletion: @escaping(_ error: Error) -> Void) {
        do {
            try context.save()
            successCompletion()
            return
        } catch {
            context.delete(object)
            failCompletion(error)
        }
    }
    
    func delete<T: NSManagedObject>(_ entity: T.Type,
                                    predicate: NSPredicate,
                                    successCompletion: @escaping() -> Void,
                                    failCompletion: @escaping(_ error: Error) -> Void) {
        let fetchRequest = NSFetchRequest<T>(entityName: NSStringFromClass(T.self))
        fetchRequest.predicate = predicate
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let searchResult = try context.fetch(fetchRequest)
            if (searchResult.count > 0) {
                context.delete(searchResult[0])
                do {
                    try context.save()
                    successCompletion()
                } catch {
                    failCompletion(error)
                }
            } else {
                failCompletion(NSError(domain: Bundle.main.bundleIdentifier ?? "com.appCompany.AppName" , code:-111, userInfo:[ NSLocalizedDescriptionKey: "No items to delete"]))
            }
        } catch {
            failCompletion(error)
        }
    }
}
