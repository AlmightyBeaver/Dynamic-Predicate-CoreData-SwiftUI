//
//  CoreDataManager.swift
//  Dynamic Predicate CoreData
//
//  Created by Heiner Gerdes on 15.10.19.
//  Copyright © 2019 Heiner Gerdes. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    //=================================================
    //MARK: Setup
    
    
    /// Singleton Pattern
    static let defaults = CoreDataManager()
    private init() {
    }
    
    
    /// Context
    var myContext : NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    
    /// Save Context, if changes were made
    func save(){
        if myContext.hasChanges {
            do {
                try myContext.save()
                //print("saved")
            } catch {
                // handle the Core Data error
                print("Error while saving managedObjectContext: \(error)")
            }
        }
    }
    
    
    
    //=================================================
    //MARK: Create
    
    
    /// Create the app settings when the App first starts (see AppDelegate)
    func createAppsetting(){
        let setting                     = Appsettings(context: myContext)
        setting.predicateFriendsNumber  = 3
        createExampleData()
        self.save()
    }
    
    /// Creates a new person with a name
    func createPerson(name: String){
        let person = Person(context: myContext)
        person.id = UUID()
        person.name = name
        person.isSelected = false
        person.appSettings = CoreDataManager.defaults.loadAppsetting()
        self.save()
    }
    
    /// Creates and adds a new friend to a person
    func createFriend(person: Person){
        let friend = Friend(context: myContext)
        friend.name = "Friend \((person.friends?.count ?? 0) + 1)"
        person.addToFriends(friend)
        self.save()
    }
    
    /// Create a new person with friends
    func createPersonWithFriends(name: String, friends: Int){
        let person = Person(context: myContext)
        person.id = UUID()
        person.name = name
        person.isSelected = false
        person.appSettings = CoreDataManager.defaults.loadAppsetting()
        for _ in 1...friends{
            createFriend(person: person)
        }
        self.save()
    }
    
    /// Create example persons with friends
    func createExampleData(){
        createPerson(name: "Person A")
        createPersonWithFriends(name: "Person B", friends: 1)
        createPersonWithFriends(name: "Person C", friends: 3)
        createPersonWithFriends(name: "Person D", friends: 2)
        createPersonWithFriends(name: "Person E", friends: 5)
        createPersonWithFriends(name: "Person F", friends: 8)
        self.save()
    }
    
    
    
    //=================================================
    //MARK: Read
    
    /// Load all persons
    func loadAllPersons() -> [Person]?{
        let myFetchRequest: NSFetchRequest<Person> = Person.PersonsFetchRequest()
        do {
            let resultArray = try myContext.fetch(myFetchRequest)
            var returnValue = [Person]()
            for person in resultArray{
                returnValue.append(person)
            }
            return returnValue
        } catch {
            print("Error while loading all persons.", error.localizedDescription)
        }
        return nil
    }
    
    /// Load the app settings
    func loadAppsetting() -> Appsettings? {
        let myFetchRequest: NSFetchRequest<Appsettings> = Appsettings.AppsettingsFetchRequest()
        do {
            let resultArray                     = try myContext.fetch(myFetchRequest)
            let returnValue     : Appsettings   = resultArray[0]   // App Settings will just exist one time
            return returnValue
        } catch {
            print("Error while loading user.", error.localizedDescription)
        }
        return nil
    }
    
    
    
    //=================================================
    //MARK: Update
    
    /// Adds one to predicateFriendsNumber in app settings
    func increasePredicateFriendsNumber(){
        var number = CoreDataManager.defaults.loadAppsetting()!.predicateFriendsNumber
        number += 1
        CoreDataManager.defaults.loadAppsetting()!.predicateFriendsNumber = number
        CoreDataManager.defaults.save()
    }
    
    /// Substracts one from predicateFriendsNumber in app settings
    func decreasePredicateFriendsNumber(){
        var number = CoreDataManager.defaults.loadAppsetting()!.predicateFriendsNumber
        if number > 0 {
            number -= 1
            CoreDataManager.defaults.loadAppsetting()!.predicateFriendsNumber = number
            CoreDataManager.defaults.save()
        }else {
            print("predicateFriendsNumber is 0")
        }
    }
    
    
    //=================================================
    //MARK: Delete
    
    func removePerson(at offsets: IndexSet) {
        // method will only be executed if there are persons
        let persons = loadAllPersons()!
        for index in offsets {
            let person = persons[index]
            myContext.delete(person)
        }
        save()
    }
    
    
}
