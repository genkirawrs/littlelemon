//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Roz on 8/10/25.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "isLoggedIn key"

struct Onboarding: View {
    @State var isLoggedIn = false;
    @State private var path = NavigationPath()
    
    @State var showFormInvalidMessage = false;
    @State var errorMsg = "";
    
    @State var firstName: String = "";
    @State var lastName: String = "";
    @State var email: String = "";
    
    var body: some View {
        NavigationStack(path: $path){ //switched to Navigation Stack b/c of deprecation of NavigationLink for ios16
            VStack (alignment:.leading){
                //keeping this here, but this method is now deprecated in ios16?
                //trying to implement functionality using navigationDestination
                /*
                NavigationLink(destination: Home(), isActive: $isLoggedIn)){
                    EmptyView()
                }
                */
                Text("REGISTRATION")
                    .font(.title)
                    .padding(.bottom, 5)
                
                Divider()
                    .padding(.bottom, 60)
                
                VStack (alignment:.leading){
                    HStack{
                        Text("FIRST NAME: ")
                            .font(.title3)
                        TextField("Your first name...", text: $firstName)
                    }
                    Divider()
                        .padding(.bottom, 20)
                    HStack{
                        Text("LAST NAME: ")
                            .font(.title3)
                        TextField("Your last name...", text: $lastName)
                    }
                    Divider()
                        .padding(.bottom, 20)
                    HStack{
                        Text("E-MAIL: ")
                            .font(.title3)
                        TextField("Your e-mail...", text: $email)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    Divider()
                        .padding(.bottom, 20)
                    
                    Button("Register", action:{
                        
                        let emailIsValid = isValid(email: email)
                        
                        var invalidFirstNameMsg = ""
                        if !firstName.isEmpty {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                        }else{
                            invalidFirstNameMsg = "\nA First Name is required!\n"
                        }
                        
                        var invalidLastNameMsg = ""
                        if !lastName.isEmpty {
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                        }else{
                            invalidLastNameMsg = "\nA Last Name is required!\n"
                        }
                        
                        var invalidEmailMsg = ""
                        if !email.isEmpty && emailIsValid {
                            UserDefaults.standard.set(email, forKey: kEmail)
                        }else{
                            invalidEmailMsg = "\nA valid Email Address is required!\n"
                        }
                        
                        if !invalidFirstNameMsg.isEmpty || !invalidLastNameMsg.isEmpty || !invalidEmailMsg.isEmpty {
                            self.showFormInvalidMessage = true
                            self.errorMsg = invalidFirstNameMsg + invalidLastNameMsg + invalidEmailMsg
                        }else{
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            isLoggedIn = true
                        }
                    }).padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(20)
                        .padding(.top, 30)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }.alert("ERROR", isPresented: $showFormInvalidMessage, actions: {
                    Button("OK", role: .cancel) { }
                }, message: {
                    Text(self.errorMsg)
                })
            }
            .padding(.horizontal, 20)
            .navigationDestination(isPresented: $isLoggedIn){
                    Home()
            }
        }.onAppear(){
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                isLoggedIn = true
            }
        }// main vstack

    }//end navigation

        
        
        func isValid(email:String) -> Bool {
            guard !email.isEmpty else { return false }
            let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
            let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
            return emailValidationPredicate.evaluate(with: email)
        }
}

#Preview {
    Onboarding()
}
