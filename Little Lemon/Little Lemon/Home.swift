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
        TabView(){
            Menu()
                .tag(0)
                .tabItem {
                    Label("Menu",systemImage: "list.dash")
                }
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            UserProfile()
                .tag(0)
                .tabItem {
                    Label("Profile",systemImage: "square.and.pencil")
                }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
