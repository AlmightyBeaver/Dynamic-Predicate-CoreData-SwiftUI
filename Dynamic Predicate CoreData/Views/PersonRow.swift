//
//  PersonRow.swift
//  Dynamic Predicate CoreData
//
//  Created by Heiner Gerdes on 15.10.19.
//  Copyright © 2019 Heiner Gerdes. All rights reserved.
//

import SwiftUI

struct PersonRow: View {
    var person : Person
    @Binding var selectedModal  : Int
    @Binding var showModal      : Bool
    
    
    var body: some View {
        HStack{
            Button(action: {
                print("Row tapped")
                self.showModal = true
                self.selectedModal = 2
                self.person.isSelected = true
                CoreDataManager.defaults.save()
            }) {
                VStack(alignment: .leading){
                    Text("Name: \(person.name ?? "Unknown name")")
                    Text("Friends: \(person.friends?.count ?? 0)")
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}

//struct PersonRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonRow()
//    }
//}
