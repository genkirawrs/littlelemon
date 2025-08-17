//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Roz on 8/10/25.
//

import SwiftUI

struct UserProfile: View {
    let savedFirstName = UserDefaults.standard.string(forKey:kFirstName)
    let savedLastName = UserDefaults.standard.string(forKey:kLastName)
    let savedEmail = UserDefaults.standard.string(forKey:kEmail)

    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        let unwrappedFirstName = savedFirstName ?? ""
        let unwrappedLastName = savedLastName ?? ""
        let unwrappedEmail = savedEmail ?? ""
        
        VStack{
            Text("Personal Information")
            Image("profile-image-placeholder")
            
            Text(unwrappedFirstName)
                .font(.title3)
            Text(unwrappedLastName)
                .font(.title3)

            Text(unwrappedEmail)
                .font(.title3)
            
            //logout button
            Button("Logout", action: {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            })
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
