//
//  DishDetail.swift
//  Little Lemon
//
//  Created by Roz on 8/17/25.
//

import SwiftUI

struct DishDetail: View {
    @Environment(\.presentationMode) var presentation

    @State var dish: Dish!
    
    var body: some View {
        let dishTitle = dish.title ?? ""
        let dishImage = dish.image ?? ""
        let dishPrice = dish.price ?? ""
        let dishDesc = dish.desc ?? ""
        
        VStack {
            AsyncImage(url: URL(string: dishImage)) { image in
                image.resizable()
                     .aspectRatio( contentMode: .fit)
                     .padding(.top,20)
            } placeholder: {
                ProgressView()
            }
            Text(dishTitle)
                .padding(.bottom,5)
                .font(Font.custom("markazitext-regular", size: 40))
                .foregroundColor(.black)
            Text(dishDesc)
                .frame(maxWidth:.infinity,alignment:.leading)
                .font(Font.custom("Karla-Medium",size:16))
                .padding(.top,10)
                .padding(.bottom,10)
                .padding(.leading,25)
                .padding(.trailing,25)

            Text("$\(dishPrice)")
                .font(Font.custom("Karla-Regular",size:16))
                .frame(maxWidth:.infinity,alignment:.leading)
                .padding(.leading,25)
            Spacer()
        }.toolbar {
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
                Image("little-lemon-logo")
            }
        }.navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    DishDetail()
}
