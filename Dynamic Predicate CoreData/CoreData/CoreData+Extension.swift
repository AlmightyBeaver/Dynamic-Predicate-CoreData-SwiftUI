//
//  CoreData+Extension.swift
//  Dynamic Predicate CoreData
//
//  Created by Heiner Gerdes on 15.10.19.
//  Copyright © 2019 Heiner Gerdes. All rights reserved.
//

import Foundation
import CoreData


//=================================================
//MARK: Extension Appsettings
extension Appsettings{
    
    /// FetchRequest for Appsettings, sorted by predicateFriendsNumber
    static func AppsettingsFetchRequest() -> NSFetchRequest<Appsettings> {
        let request: NSFetchRequest<Appsettings> = Appsettings.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Appsettings.predicateFriendsNumber, ascending: true)]
        return request
    }
    
    
}//end Extension AppSetting



//=================================================
//MARK: Extension Person
extension Person{
    
    
    /// FetchRequest for all persons, sorted by name
    static func PersonsFetchRequest() -> NSFetchRequest<Person> {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Person.name, ascending: true)]
        return request
    }
    
    /// FetchRequest for selected person, sorted by name
    static func SelectedPersonFetchRequest() -> NSFetchRequest<Person> {
        let request: NSFetchRequest<Person> = Person.PersonsFetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Person.name, ascending: true)]
        request.predicate = NSPredicate(
            format: "isSelected == %@",
            argumentArray: [true]
        )

        return request
    }
    
} //end Extension Person
