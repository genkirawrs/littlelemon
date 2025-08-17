//
//  Header.swift
//  Little Lemon
//
//  Created by Roz on 8/17/25.
//

import SwiftUI

struct Header: View {
    @State var isLoggedIn = true;
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("little-lemon-logo")
                HStack{
                    if isLoggedIn {
                        Spacer()
                        NavigationLink(destination: UserProfile()) {
                            Image("profile-image-placeholder")
                                .resizable()
                                .frame(width:50,height:50)
                                .padding(.trailing)
                        }
                    }
                }
            }
        }.frame(height:45)
         .onAppear(){
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                isLoggedIn = true
            }
         }
    }
}

#Preview {
    Header()
}
