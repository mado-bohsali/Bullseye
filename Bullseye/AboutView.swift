//
//  AboutView.swift
//  Bullseye
//
//  Created by Mohamad El Bohsaly on 10/6/19.
//

import SwiftUI

let beige = Color(red: 255, green: 214, blue: 179)

struct Heading:ViewModifier{
    func body(content:Content)->some View{
        return content
            .font(Font.custom("Arial Rounded MT Bold", size: 30))
            .foregroundColor(.black)
            .padding(.bottom, 20)
            .padding(.top, 20)
    }
}

struct TextView:ViewModifier{
    func body(content:Content)->some View{
        return content
            .font(Font.custom("Arial Rounded MT Bold", size: 16))
            .foregroundColor(.black)
            .padding(.trailing, 60)
            .padding(.leading, 60)
            .padding(.bottom, 20)
    }
}

struct AboutView: View {
    var body: some View {
    Group{
        VStack{
            Text("🎯 Bullseye 🎯").modifier(Heading())
            Text("Your goal is to place the slider as close as possible to the target value in order to gain higher scores.").modifier(TextView())
        }
        .navigationBarTitle("About Bullseye App")
        .background(beige)
        }
        .background(Image("Background"))
    }
    
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
