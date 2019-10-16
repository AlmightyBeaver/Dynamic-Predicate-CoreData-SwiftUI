//
//  ContentView.swift
//  Dynamic Predicate CoreData
//
//  Created by Heiner Gerdes on 15.10.19.
//  Copyright © 2019 Heiner Gerdes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Appsettings.AppsettingsFetchRequest()) var appSettings: FetchedResults<Appsettings>
    
    @State var selectedModal    = 0         // 1 - AddPerson; 2 - PersonDetail
    @State var showModal        = false
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section(header: Text("All Persons")){
                        
                        ListStaticPredicate(
                            selectedModal: self.$selectedModal,
                            showModal: self.$showModal
                        )
                    }
                }
                List{
                    Section(header: Text("All Persons with more than \(appSettings[0].predicateFriendsNumber) friends")){
                        ButtonsPredicateChange()
                        
                        ListDynamicPredicate(
                            predicate: Int(CoreDataManager.defaults.loadAppsetting()!.predicateFriendsNumber),
                            selectedModal: self.$selectedModal,
                            showModal: self.$showModal
                        )
                    }
                }
                
            } //end VStack
                
                .sheet(isPresented: $showModal, content: {
                    if self.selectedModal == 1{
                        NavigationView{
                            AddPerson(showModal: self.$showModal)
                                .environment(\.managedObjectContext, self.managedObjectContext)
                        }
                    }else if self.selectedModal == 2{
                        NavigationView{
                            PersonDetail(showModal: self.$showModal)
                                .environment(\.managedObjectContext, self.managedObjectContext)
                        }
                    }
                })
                
                
                .navigationBarItems(trailing:
                    Button(action: {
                        self.showModal      = true
                        self.selectedModal  = 1
                    }) {
                        Text("Add Person")
                    }
            )
                
                .navigationBarTitle("Dynamic Predicate", displayMode: .inline)
        }.environment(\.horizontalSizeClass, .compact) //end NavigationView
    } //end body
}





//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
