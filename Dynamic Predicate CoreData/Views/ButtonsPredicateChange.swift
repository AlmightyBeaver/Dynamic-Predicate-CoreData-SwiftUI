//
//  ButtonsPredicateChange.swift
//  Dynamic Predicate CoreData
//
//  Created by Heiner Gerdes on 15.10.19.
//  Copyright © 2019 Heiner Gerdes. All rights reserved.
//

import SwiftUI

struct ButtonsPredicateChange: View {
    var body: some View {
        HStack{
            Spacer()
            HStack {
                Image(systemName: "minus.circle")
                Text("Decrease")
                    .fontWeight(.semibold)
            }
            .padding(10)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(20)
            .onTapGesture {
                CoreDataManager.defaults.decreasePredicateFriendsNumber()
            }
            Spacer()
            HStack {
                Image(systemName: "plus.circle")
                Text("Increase")
                    .fontWeight(.semibold)
            }
            .padding(10)
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(20)
            .onTapGesture {
                CoreDataManager.defaults.increasePredicateFriendsNumber()
                
            }
            Spacer()
        }
    }
}

//struct ButtonsPredicateChange_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonsPredicateChange()
//    }
//}
