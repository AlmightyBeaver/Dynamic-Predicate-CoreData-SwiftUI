//
//  ListDynamicPredicate.swift
//  Dynamic Predicate CoreData
//
//  Created by Heiner Gerdes on 15.10.19.
//  Copyright © 2019 Heiner Gerdes. All rights reserved.
//

import SwiftUI

struct ListDynamicPredicate: View {
    @Binding var selectedModal  : Int
    @Binding var showModal      : Bool
    
    var _predicate      : Int
    var personRequest   : FetchRequest<Person>
    var persons        : FetchedResults<Person>{personRequest.wrappedValue}

    
    init(predicate: Int, selectedModal: Binding<Int>, showModal: Binding<Bool>){
        self._predicate     = predicate
        self._selectedModal = selectedModal
        self._showModal     = showModal
        
        self.personRequest  = FetchRequest(
            entity: Person.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Person.name, ascending: true)],
            predicate: NSPredicate(format: "%K.@count > %@",argumentArray: [#keyPath(Person.friends), _predicate])
        )
    }
    
    
    
    var body: some View {
        ForEach(persons, id: \.id){person in
            
            PersonRow(
                person: person,
                selectedModal: self.$selectedModal,
                showModal: self.$showModal
            )
            
        }
    }
}


//struct ListDynamicPredicate_Previews: PreviewProvider {
//    static var previews: some View {
//        ListDynamicPredicate()
//    }
//}
