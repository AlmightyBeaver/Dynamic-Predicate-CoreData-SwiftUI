//
//  PersonDetail.swift
//  Dynamic Predicate CoreData
//
//  Created by Heiner Gerdes on 15.10.19.
//  Copyright © 2019 Heiner Gerdes. All rights reserved.
//

import SwiftUI

struct PersonDetail: View {
    @FetchRequest(fetchRequest: Person.SelectedPersonFetchRequest()) var selectedPerson: FetchedResults<Person>
    
    @Binding var showModal      : Bool
    @State var name         : String = ""
    
    var body: some View {
        Form {
            
            VStack{
                HStack{
                    Text("Change Name:")
                    TextField(NSLocalizedString("Please enter a new name here", comment: "Textfield placeholder"), text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                Button(action: {
                    self.selectedPerson[0].name = self.name
                    CoreDataManager.defaults.save()
                    self.showModal = false
                }) {
                    Text("Save name")
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(20)
                }
            }
            Text("Friends: \(self.selectedPerson[0].friends?.count ?? 0)")
            HStack{
                Spacer()
                Button(action: {
                    CoreDataManager.defaults.createFriend(person: self.selectedPerson[0])
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("Add Friend")
                            .fontWeight(.semibold)
                    }
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(20)
                }
                Spacer()
            }
        } //end Form
            .onAppear(perform: {self.name = self.selectedPerson[0].name ?? ""})
            .onDisappear(perform: {self.selectedPerson[0].isSelected = false})
            
            
            .navigationBarTitle("Person Detail")
            .navigationBarItems(leading:
                Button(action: {
                    self.showModal = false
                }) {
                    Text(NSLocalizedString("Back", comment: "Button in AddJobView"))
                }
        )
    } //end body
}

//struct PersonDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonDetail()
//    }
//}
