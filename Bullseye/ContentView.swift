//
//  ContentView.swift
//  Bullseye
//
//  Created by Mohamad El Bohsaly on 10/3/19.
//

import SwiftUI

struct LabelStyle: ViewModifier{
    func body(content: Content) -> some View {
        return content
            .foregroundColor(Color.white)
            .modifier(ShadowStyle())
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
    }
}

struct ViewStyle : ViewModifier{
    func body(content: Content) -> some View {
        return content
            .foregroundColor(.yellow)
            .modifier(ShadowStyle())
            .font(Font.custom("Arial Rounded MT Bold", size: 24))
    }
}

struct ShadowStyle : ViewModifier{
    func body(content: Content) -> some View {
        return content
            .shadow(color: .black, radius: 5, x: 2, y: 2)
    }
}

struct ButtonLargeTextStyle : ViewModifier{
    func body(content: Content) -> some View {
        return content
            .foregroundColor(.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
    }
}

struct ButtonSmallTextStyle : ViewModifier{
    func body(content: Content) -> some View {
        return content
            .foregroundColor(.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 12))
    }
}

struct ContentView: View { //like UIView
    //A persistent value of a given type, through which a view reads and monitors the value.
    //the view invalidates its appearance and recomputes the body upon changing value

    @State var alertIsVisible:Bool = false
    @State var sliderValue:Double = 50.0
    @State var targetValue:Int = Int.random(in: 1...100)
    @State var score:Int = 0
    @State var round:Int = 1

    var body: some View { //behaves as a View
        VStack {
            //Row 1
            Spacer()
            HStack {
                Text("Put the bullseye as close as possible to ").modifier(LabelStyle())
                Text("\(targetValue)").modifier(ViewStyle())
            };Spacer()
            
            //Row 2 : slider
            HStack{
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(.orange) //sliderValue is being updated as we move the indicator
                Text("\(100)").modifier(LabelStyle())
            };Spacer()
            
            //Row 3
            Button(action: {
                //upon pressing
                self.alertIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/).modifier(ButtonLargeTextStyle())
               }
            .background(Image("Button"))
            
            //binding from a state with the `binding` property, or by using the `$` prefix operator.
            .alert(isPresented: $alertIsVisible) { () ->
                Alert in
                return Alert(title: Text(alertTitle()), message: Text("Slider reached \(Int(self.sliderValue.rounded()))\nYou scored \(pointsForCurrentRound())"),dismissButton: .default(Text("Awesome!")) {
                    self.score = self.score + self.pointsForCurrentRound()
                    self.targetValue = Int.random(in: 1...100)
                    self.round = self.round+1
                    })
            };Spacer()
            
            //HStack container of score, buttons and info
            HStack{
                Button(action: {
                    self.startOver()
                }) {
                    HStack{
                        Image("StartOverIcon")
                        Text("Start over").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button"))
                Spacer() //spreads along the major axis of the containing container
                                      
                Text("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ViewStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(round)").modifier(ViewStyle())
                Spacer()
                
                NavigationLink(destination: AboutView()){
                    HStack{
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button"))
                
            }.padding(.bottom, 20)
        }.background(Image("Background"), alignment: .center)
    }
    
    func pointsForCurrentRound() -> Int {
        let maxScore = 100
        var bonus:Int = 0
        let difference = maxScore - abs(targetValue - Int(sliderValue.rounded()))
        
        if difference == 0{
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else{
            bonus = 0
        }
        return difference + bonus
    }
    
    func alertTitle() -> String{
        let difference = abs(targetValue - Int(sliderValue.rounded()))
        var title:String
        
        if difference == 0{
            title = "Bullseye!"
        } else if difference < 5{
            title = "You almost did it!"
        } else if difference <= 10{
            title = "Not bad."
        } else{
            title = "Are you focusing?"
        }
        
        return title
    }
    
    func startOver(){
        self.round = 1
        self.score = 0
        self.sliderValue = 50.0
        targetValue = Int.random(in: 1...100)
    }
}

/*
 Preview provider, collection of previews each has its settings overriden
 */

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
