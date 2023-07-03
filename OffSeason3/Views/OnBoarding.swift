//
//  OnBoarding.swift
//  OffSeason3
//
//  Created by Jacquese Whitson on 6/28/23.
//

import SwiftUI

struct OnBoardingStep{
    let image : String
    let title : String
    let description : String

}

private let onBoardingSteps = [
OnBoardingStep(image: "cover1", title: "Welcome to OffSeason", description: "Offseason is your platform for creating and joining exciting games in real life. Let's dive in and make the most of your gaming experience!"),
OnBoardingStep(image: "cover2", title: "Create and Join Games", description: "Create your own games with custom rules or join thrilling challenges created by others. Experience the joy of competition and camaraderie on Offseason."),
OnBoardingStep(image: "cover1", title: "Connect and Play", description: "Connect with players, chat, and strategize with fellow gaming enthusiasts. Discover new friends, track your progress, and dominate the leaderboard.")

]

struct OnBoarding: View {
    @State private var currentStep = 0
    @State private var playNow = false
    @AppStorage("didCompleteOnboarding") var didCompleteOnboarding: Bool = false

    init(){
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        NavigationStack {
            HStack {
                VStack{
                    HStack{
                        Spacer()
                        Button{
                            // if code is breakin its prolly caus eof here
                            self.currentStep = onBoardingSteps.count - 1
                        }label: {
                            Text("Skip")
                                .padding(16)
                                .foregroundColor(.gray)
                            
                        }
                    }
                    
                    
                    
                    TabView(selection: $currentStep) {
                        ForEach(0..<onBoardingSteps.count) { step in
                            VStack{
                                Image(onBoardingSteps[step].image)
                                    .resizable()
                                    .frame(width: 350, height: 350)
                                    .cornerRadius(30)
                                
                                Text(onBoardingSteps[step].title)
                                    .font(Font.custom("SportSpiritAf", size: 35))
                                    .foregroundColor(.red)

        //                            .font(.title)
        //                            .bold()
                                
                                Text(onBoardingSteps[step].description)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                            .tag(step)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    HStack{
                        ForEach(0..<onBoardingSteps.count) { step in
                            
                            if step == currentStep {
                                Rectangle()
                                    .frame(width: 20, height: 10)
                                    .cornerRadius(10)
                                    .foregroundColor(currentStep < onBoardingSteps.count - 1 ? .red : .black)
                            }
                            else {
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(.gray)
                            }
                            
                            
                        }
                    }.padding(.bottom,24)
                    
                    
                    Button{
                        if currentStep < onBoardingSteps.count - 1{
                            currentStep += 1
                        } else {
                            didCompleteOnboarding = true 
                            playNow.toggle()
                            
                        }
                        
                    } label :{
                        Text(currentStep < onBoardingSteps.count - 1 ? "Next" : "Get Started")
                            .padding(16)
                            .frame(maxWidth: .infinity)
                            .background(currentStep < onBoardingSteps.count - 1 ? .black : .red)
                            .cornerRadius(16)
                            .padding(.horizontal,16)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    
                    
                    
                    
                }
            }
            .fullScreenCover(isPresented: $playNow) {
            
ContentView()
                
            }
        }
        
        
        
        
        
        
     }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}
