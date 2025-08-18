//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Roz on 8/10/25.
//

import SwiftUI

struct UserProfile: View {
    let savedFirstName = UserDefaults.standard.string(forKey:kFirstName) ?? ""
    let savedLastName = UserDefaults.standard.string(forKey:kLastName) ?? ""
    let savedEmail = UserDefaults.standard.string(forKey:kEmail) ?? ""

    @Environment(\.presentationMode) var presentation
    
    @State private var isLoggedOut = false
    @State private var firstName: String = "";
    @State private var lastName: String = "";
    @State private var email: String = "";
    @State private var phone: String = "(123) 456-7890";

    @State private var isOnOrderStatus: Bool = true;
    @State private var isOnPasswordChanges: Bool = true;
    @State private var isOnSpecialOffers: Bool = true;
    @State private var isOnNewsletter: Bool = true;

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
                    
                    TextField("Phone Number", text: $phone)
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
                    Button("Discard changes") { }
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
                    Button("Save changes") { }
                        .padding(10)
                        .padding(.leading,11)
                        .padding(.trailing,11)
                        .background(Color(#colorLiteral(red: 0.286, green: 0.369, blue: 0.341, alpha: 1)))
                        .foregroundColor(.white)
                        .font(Font.custom("Karla",size:18))
                        .cornerRadius(8)
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
                    firstName = savedFirstName
                    lastName = savedLastName
                    email = savedEmail
                }
            //  .navigationTitle(Text("Personal information"))
        }
    }
}

#Preview {
    UserProfile()
}
