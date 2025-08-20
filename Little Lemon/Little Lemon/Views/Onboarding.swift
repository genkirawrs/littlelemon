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
let kPhoneNumber = "phoneNumber key"

let kOrderStatus = "order notification key"
let kPasswordChanges = "password notification key"
let kSpecialOffers = "special offers notification key"
let kNewsletter = "newsletter key"


struct Onboarding: View {
    @State var isLoggedIn = false
    
    @State var showFormInvalidMessage = false
    @State var errorMsg = ""
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""

    
    var body: some View {
        NavigationStack{
            NavigationLink(destination: Home(), isActive: $isLoggedIn) { }

            Header()
            VStack{
                HeroContent()
            }.frame(maxWidth: .infinity, alignment:.leading)
             .padding(.trailing,8)
             .padding(.leading,8)
             .background(Color(#colorLiteral(red: 0.286, green: 0.369, blue: 0.341, alpha: 1)))
            VStack (alignment:.leading){

                Text("Create Your Account")
                    .frame(maxWidth:.infinity,alignment:.leading)
                    .font(Font.custom("Karla-Bold",size:20))
                    .padding(2)
                
                Divider()
                    .padding(.bottom, 30)
                
                VStack (alignment:.leading){
                    HStack{
                        Text("FIRST NAME*: ")
                            .font(Font.custom("Karla-Bold",size:18))
                            .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)))
                        TextField("Your first name", text: $firstName)
                    }
                    Divider()
                        .padding(.bottom, 20)
                    HStack{
                        Text("LAST NAME*: ")
                            .font(Font.custom("Karla-Bold",size:18))
                            .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)))
                        TextField("Your last name", text: $lastName)
                    }
                    Divider()
                        .padding(.bottom, 20)
                    HStack{
                        Text("E-MAIL*: ")
                            .font(Font.custom("Karla-Bold",size:18))
                            .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)))
                        TextField("Your e-mail", text: $email)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    Divider()
                        .padding(.bottom, 20)
                    
                    Button(action:{
                        
                        if firstName.isEmpty && lastName.isEmpty && email.isEmpty{
                            self.showFormInvalidMessage = true
                            self.errorMsg = "All fields are required!"
                        }else{
                            
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
                                //set defaults
                                UserDefaults.standard.set("", forKey: kPhoneNumber)
                                UserDefaults.standard.set(true, forKey: kOrderStatus)
                                UserDefaults.standard.set(true, forKey: kPasswordChanges)
                                UserDefaults.standard.set(true, forKey: kSpecialOffers)
                                UserDefaults.standard.set(true, forKey: kNewsletter)
                                
                                UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                                isLoggedIn = true
                            }
                        }
                    }){
                        HStack {
                          Spacer()
                          Text("Register")
                          Spacer()
                        }
                        .font(Font.custom("Karla-Bold",size:20))
                        .padding(10)
                        .background(Color(#colorLiteral(red: 0.957, green: 0.808, blue: 0.078, alpha: 1)))
                        .foregroundColor(.black)
                        .contentShape(Rectangle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 5) // Match corner radius
                                .stroke(Color(#colorLiteral(red: 0.824, green: 0.612, blue: 0, alpha: 1)), lineWidth: 2)
                        )
                    }
                    .padding(.top,20)
                    Spacer()

                }.alert("ERROR", isPresented: $showFormInvalidMessage, actions: {
                    Button("OK", role: .cancel) { }
                }, message: {
                    Text(self.errorMsg)
                })
            }
            .padding(.horizontal, 20)
        }.navigationBarBackButtonHidden(true)
         .onAppear(){
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                isLoggedIn = true
            }
        }// main vstack

    }//end navigation

        
        
        func isValid(email:String) -> Bool {
            guard !email.isEmpty else { return false }
            let emailValidationRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
            return emailValidationPredicate.evaluate(with: email)
        }
}

#Preview {
    Onboarding()
}
