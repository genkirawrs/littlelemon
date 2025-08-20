//
//  Home.swift
//  Little Lemon
//
//  Created by Roz on 8/10/25.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    
    var body: some View {
        VStack{
            Header()
            Menu()
        }.navigationBarBackButtonHidden(true)
        
        /*
        TabView(){
            Menu()
                .tag(0)
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Label("Menu",systemImage: "list.dash")
                }
                
            UserProfile()
                .tag(0)
                .tabItem {
                    Label("Profile",systemImage: "square.and.pencil")
                    }
        }.navigationBarBackButtonHidden(true)
        */
    }
}

#Preview {
    Home()
}
