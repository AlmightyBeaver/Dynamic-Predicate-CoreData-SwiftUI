//
//  AddPerson.swift
//  Dynamic Predicate CoreData
//
//  Created by Heiner Gerdes on 15.10.19.
//  Copyright © 2019 Heiner Gerdes. All rights reserved.
//

import SwiftUI

struct AddPerson: View {
    @Binding var showModal      : Bool
    @State var name: String = ""
    
    var body: some View {
        Form {
            VStack{
                HStack{
                    Text("Name:")
                    TextField(NSLocalizedString("Please enter a new name here", comment: "Textfield placeholder"), text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                HStack{
                    Spacer()
                    Button(action: {
                        CoreDataManager.defaults.createPerson(name: self.name)
                        self.showModal = false
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add Person")
                                .fontWeight(.semibold)
                        }
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(20)
                    }
                    Spacer()
                }
            }
        }
            
            
            
        .navigationBarTitle("Add Person")
        .navigationBarItems(leading:
            Button(action: {
                self.showModal = false
            }) {
                Text("Cancel")
            }
        )
    } //end body
}

//struct AddPerson_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPerson()
//    }
//}
