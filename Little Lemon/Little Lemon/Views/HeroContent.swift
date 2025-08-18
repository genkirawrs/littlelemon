//
//  HeroHeader.swift
//  Little Lemon
//
//  Created by Roz on 8/17/25.
//

import SwiftUI

struct HeroContent: View {
    var body: some View {
        Text ("Little Lemon")
            .font(Font.custom("markazitext-medium", size: 50))
            .padding(.bottom,-10)
            .frame(maxWidth:.infinity,alignment:.leading)
            .foregroundColor(Color(#colorLiteral(red: 0.957, green: 0.808, blue: 0.078, alpha: 1)))
        HStack{
            VStack{
                    Text ("Chicago")
                        .frame(maxWidth:.infinity,alignment:.leading)
                        .padding(.bottom,5)
                        .font(Font.custom("markazitext-regular", size: 30))
                        .foregroundColor(.white)

                Text ("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .frame(maxWidth:.infinity,alignment:.leading)
                    .font(Font.custom("Karla-Medium",size:16))
                    .foregroundColor(.white)
                Spacer()
            }.frame(maxHeight:150)
             .padding(.top,-15)
            VStack{
                Image("hero-image")
                    .resizable()
                    .frame(maxWidth: 120, maxHeight: 140)
                    .aspectRatio( contentMode: .fill)
                    .clipShape(Rectangle())
                    .cornerRadius(15)
                    .padding(.top,-15)
                Spacer()
            }.frame(maxHeight:150)
        }
    }
}

#Preview {
    HeroContent()
}
