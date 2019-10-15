//
//  ListStaticPredicate.swift
//  Dynamic Predicate CoreData
//
//  Created by Heiner Gerdes on 15.10.19.
//  Copyright © 2019 Heiner Gerdes. All rights reserved.
//

import SwiftUI

struct ListStaticPredicate: View {
    @FetchRequest(fetchRequest: Person.PersonsFetchRequest()) var allPersons: FetchedResults<Person>
    @Binding var selectedModal  : Int
    @Binding var showModal      : Bool
    
    
    var body: some View {
        ForEach(allPersons, id: \.id){person in
            PersonRow(
                person: person,
                selectedModal: self.$selectedModal,
                showModal: self.$showModal
            )
            
        }.onDelete(perform: CoreDataManager.defaults.removePerson )
    }
}

//struct ListStaticPredicate_Previews: PreviewProvider {
//    static var previews: some View {
//        ListStaticPredicate()
//    }
//}
