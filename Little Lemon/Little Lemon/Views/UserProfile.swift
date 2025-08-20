//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Roz on 8/10/25.
//

import SwiftUI

struct UserProfile: View {
    
    var savedFirstName = UserDefaults.standard.string(forKey:kFirstName) ?? ""
    var savedLastName = UserDefaults.standard.string(forKey:kLastName) ?? ""
    var savedEmail = UserDefaults.standard.string(forKey:kEmail) ?? ""
    var savedPhoneNumber = UserDefaults.standard.string(forKey:kPhoneNumber) ?? ""
    
    var savedOrderStatus = UserDefaults.standard.bool(forKey:kOrderStatus)
    var savedPasswordChanges = UserDefaults.standard.bool(forKey:kPasswordChanges)
    var savedSpecialOffers = UserDefaults.standard.bool(forKey:kSpecialOffers)
    var savedNewsletter = UserDefaults.standard.bool(forKey:kNewsletter)

    @Environment(\.presentationMode) var presentation
    
    @State private var isLoggedOut = false
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""

    @State private var isOnOrderStatus = false
    @State private var isOnPasswordChanges = false
    @State private var isOnSpecialOffers = false
    @State private var isOnNewsletter = false

    @State private var showFormInvalidMessage = false
    @State private var errorMsg = ""
    @State private var showFormSaved = false
    
    var body: some View {
        
        
        ScrollView(.vertical, showsIndicators: false){
            NavigationLink(destination: Onboarding(), isActive: $isLoggedOut) { }
            VStack{
                Divider()
                    .padding(.top,10)
                    .padding(.bottom,5)
                Text("Avatar")
                    .frame(maxWidth:.infinity,alignment:.leading)
                    .font(Font.custom("Karla-Bold",size:18))
                    .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)))
                    .padding(0)
                
                HStack(alignment:.center){
                    Image("profile-image-placeholder")
                        .resizable()
                        .frame(width:75,height:75)
                        .aspectRatio( contentMode: .fit)
                        .background(Color(.red))
                        .clipShape(Circle())
                        .padding(.trailing,5)
                    Button("Change") { }
                        .padding(10)
                        .padding(.leading,11)
                        .padding(.trailing,11)
                        .background(Color(#colorLiteral(red: 0.286, green: 0.369, blue: 0.341, alpha: 1)))
                        .foregroundColor(.white)
                        .font(Font.custom("Karla",size:18))
                        .cornerRadius(8)
                    Button("Remove") { }
                        .padding(10)
                        .padding(.leading,11)
                        .padding(.trailing,11)
                        .background(Color(.white))
                        .foregroundColor(Color(#colorLiteral(red: 0.286, green: 0.369, blue: 0.341, alpha: 1)))
                        .font(Font.custom("Karla",size:18))
                        .overlay(
                            Rectangle()
                                .stroke(Color(#colorLiteral(red: 0.286, green: 0.369, blue: 0.341, alpha: 1)), lineWidth: 1)
                        )
                    Spacer()
                }.frame(alignment:.leading)
                    .padding(.top,0)//end avatar
                
                VStack{
                    Text("First Name")
                        .frame(maxWidth:.infinity, alignment:.leading)
                        .font(Font.custom("Karla-Bold",size:18))
                        .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)))
                    
                    TextField("First Name", text: $firstName)
                        .font(.title3)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5) // Match corner radius
                                .stroke(Color(#colorLiteral(red: 0.929, green: 0.937, blue: 0.933, alpha: 1)), lineWidth: 2)
                        )
                }.padding(.top,20)
                
                VStack{
                    Text("Last Name")
                        .frame(maxWidth:.infinity, alignment:.leading)
                        .font(Font.custom("Karla-Bold",size:18))
                        .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)))
                    
                    TextField("Last Name", text: $lastName)
                        .font(.title3)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5) // Match corner radius
                                .stroke(Color(#colorLiteral(red: 0.929, green: 0.937, blue: 0.933, alpha: 1)), lineWidth: 2)
                        )
                }.padding(.top,20)
                
                VStack{
                    Text("Email")
                        .frame(maxWidth:.infinity, alignment:.leading)
                        .font(Font.custom("Karla-Bold",size:18))
                        .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)))
                    
                    TextField("Email", text: $email)
                        .font(.title3)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5) // Match corner radius
                                .stroke(Color(#colorLiteral(red: 0.929, green: 0.937, blue: 0.933, alpha: 1)), lineWidth: 2)
                        )
                }.padding(.top,20)
                
                VStack{
                    Text("Phone Number")
                        .frame(maxWidth:.infinity, alignment:.leading)
                        .font(Font.custom("Karla-Bold",size:18))
                        .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)))
                    
                    TextField("+1234567890", text: $phone)
                        .font(.title3)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5) // Match corner radius
                                .stroke(Color(#colorLiteral(red: 0.929, green: 0.937, blue: 0.933, alpha: 1)), lineWidth: 2)
                        )
                }.padding(.top,20)
                
                Text("Email notifications")
                    .frame(maxWidth:.infinity,alignment:.leading)
                    .font(Font.custom("Karla-Bold",size:20))
                    .padding(2)
                    .padding(.top,20)

                VStack{
                    Toggle("Order Statuses", isOn: $isOnOrderStatus)
                        .padding(.bottom,10)
                    Toggle("Password Changes", isOn: $isOnPasswordChanges)
                        .padding(.bottom,10)
                    Toggle("Special Offers", isOn: $isOnSpecialOffers)
                        .padding(.bottom,10)
                    Toggle("Newsletter", isOn: $isOnNewsletter)
                        .padding(.bottom,10)
                }

                //logout button
                Button(action: {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    //self.presentation.wrappedValue.dismiss()
                    isLoggedOut = true
                }){
                    HStack {
                      Spacer()
                      Text("Logout")
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
                HStack(alignment:.center){
                    Button("Discard changes") {
                        firstName = UserDefaults.standard.string(forKey:kFirstName) ?? ""
                        lastName = UserDefaults.standard.string(forKey:kLastName) ?? ""
                        email = UserDefaults.standard.string(forKey:kEmail) ?? ""
                        phone = UserDefaults.standard.string(forKey:kPhoneNumber) ?? ""
                        
                        isOnOrderStatus = UserDefaults.standard.bool(forKey:kOrderStatus)
                        isOnPasswordChanges = UserDefaults.standard.bool(forKey:kPasswordChanges)
                        isOnSpecialOffers = UserDefaults.standard.bool(forKey:kSpecialOffers)
                        isOnNewsletter = UserDefaults.standard.bool(forKey:kNewsletter)
                        
                    }
                        .padding(10)
                        .padding(.leading,11)
                        .padding(.trailing,11)
                        .background(Color(.white))
                        .foregroundColor(Color(#colorLiteral(red: 0.286, green: 0.369, blue: 0.341, alpha: 1)))
                        .font(Font.custom("Karla",size:18))
                        .overlay(
                            RoundedRectangle(cornerRadius:5)
                                .stroke(Color(#colorLiteral(red: 0.286, green: 0.369, blue: 0.341, alpha: 1)), lineWidth: 1)
                        )
                    Button(action:{
                        
                        if firstName.isEmpty && lastName.isEmpty && email.isEmpty{
                            self.showFormInvalidMessage = true
                            self.errorMsg = "All fields are required!"
                        }else{
                            
                            let emailIsValid = isValidEmail(email: email)
                            
                            var invalidFirstNameMsg = ""
                            if firstName.isEmpty {
                                invalidFirstNameMsg = "\nA First Name is required!\n"
                            }
                            
                            var invalidLastNameMsg = ""
                            if lastName.isEmpty {
                                invalidLastNameMsg = "\nA Last Name is required!\n"
                            }
                            
                            var invalidEmailMsg = ""
                            if email.isEmpty || !emailIsValid {
                                invalidEmailMsg = "\nA valid Email Address is required!\n"
                            }
                            
                            var invalidPhoneMsg = ""
                            if !phone.isEmpty && !isValidPhoneNumber(phoneNum: phone) {
                                invalidPhoneMsg = "\nPlease enter a valid Phone Number.\n (e.g. +1234567890)\n"
                            }
                            
                            if !invalidFirstNameMsg.isEmpty || !invalidLastNameMsg.isEmpty || !invalidEmailMsg.isEmpty || !invalidPhoneMsg.isEmpty {
                                self.showFormInvalidMessage = true
                                self.errorMsg = invalidFirstNameMsg + invalidLastNameMsg + invalidEmailMsg + invalidPhoneMsg
                            }else{
                                UserDefaults.standard.set(email, forKey: kEmail)
                                UserDefaults.standard.set(lastName, forKey: kLastName)
                                UserDefaults.standard.set(firstName, forKey: kFirstName)
                                UserDefaults.standard.set(phone, forKey: kPhoneNumber)
                                UserDefaults.standard.set(isOnOrderStatus, forKey: kOrderStatus)
                                UserDefaults.standard.set(isOnPasswordChanges, forKey: kPasswordChanges)
                                UserDefaults.standard.set(isOnSpecialOffers, forKey: kSpecialOffers)
                                UserDefaults.standard.set(isOnNewsletter, forKey: kNewsletter)
                                self.showFormSaved = true
                                
                            }
                        }
                    }){
                        HStack {
                              Spacer()
                              Text("Save Changes")
                              Spacer()
                            }
                            .padding(10)
                            .padding(.leading,11)
                            .padding(.trailing,11)
                            .background(Color(#colorLiteral(red: 0.286, green: 0.369, blue: 0.341, alpha: 1)))
                            .foregroundColor(.white)
                            .font(Font.custom("Karla",size:18))
                            .cornerRadius(8)
                        }
                        .alert("Personal Information", isPresented: $showFormSaved, actions: {
                            Button("OK", role: .cancel) { }
                        }, message: {
                            Text("Save Successful!")
                        })
                        .alert("ERROR", isPresented: $showFormInvalidMessage, actions: {
                            Button("OK", role: .cancel) { }
                        }, message: {
                            Text(self.errorMsg)
                        })
                        
                        
                        
                        
                }.frame(alignment:.center)
                    .padding(.top,30)
                
                Spacer()
            }.padding(.leading,8)
                .padding(.trailing,8)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {self.presentation.wrappedValue.dismiss()}) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color(#colorLiteral(red: 0.286, green: 0.369, blue: 0.341, alpha: 1)))
                                .clipShape(Circle())
                        }
                    }
                    ToolbarItem(placement:.principal) {
                        Text("Personal Information")
                    }
                }.navigationBarBackButtonHidden(true)
                .onAppear {
                    firstName = UserDefaults.standard.string(forKey:kFirstName) ?? ""
                    lastName = UserDefaults.standard.string(forKey:kLastName) ?? ""
                    email = UserDefaults.standard.string(forKey:kEmail) ?? ""
                    phone = UserDefaults.standard.string(forKey:kPhoneNumber) ?? ""
                    
                    isOnOrderStatus = UserDefaults.standard.bool(forKey:kOrderStatus)
                    isOnPasswordChanges = UserDefaults.standard.bool(forKey:kPasswordChanges)
                    isOnSpecialOffers = UserDefaults.standard.bool(forKey:kSpecialOffers)
                    isOnNewsletter = UserDefaults.standard.bool(forKey:kNewsletter)
                }
            //  .navigationTitle(Text("Personal information"))
        }
    }
        func isValidEmail(email:String) -> Bool {
            guard !email.isEmpty else { return false }
            let emailValidationRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
            return emailValidationPredicate.evaluate(with: email)
        }
        func isValidPhoneNumber(phoneNum:String) -> Bool {
            let regEx = "^\\+(?:[0-9]?){6,14}[0-9]$"
            let phoneCheck = NSPredicate(format: "SELF MATCHES[c] %@", regEx)
            return phoneCheck.evaluate(with: phoneNum)
        }
}

#Preview {
    UserProfile()
}
