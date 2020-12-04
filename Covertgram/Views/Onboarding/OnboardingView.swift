//
//  OnboardingView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 11/11/2020.
//

import SwiftUI

struct OnboardingView: View {
    
    struct WelcomeView: View {
        
        var body: some View {
            VStack {
                Text("👋")
                    .font(.system(size: 64))
                Text("Welcome to Covertgram!")
                    .font(.largeTitle)
                Text("Your own covert feed.")
                    .font(.caption)
                    .padding()
            }
        }
    }
    
    struct StepsView: View {
        
        var body: some View {
            VStack(alignment: .leading) {
                Label("Tap the \"Settings\" tab...", systemImage: "1.circle")
                Label("Tap \"Search Users\"...", systemImage: "2.circle")
                Label("Add the people you want to (covertly) follow...", systemImage: "3.circle")
                Label("There's no step 4 - go check your feed!", systemImage: "4.circle")
            }
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            
            WelcomeView()
            
            Spacer()
            
            Text("You're almost ready to start using your alternative feed.")
                .padding(.bottom, 32)
                .multilineTextAlignment(.center)
            
            StepsView()
                .padding(.bottom)
            
            Spacer()
            
            Text("Start!")
                .padding()
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
        }.padding()
    }
}

#if DEBUG
struct OnboardingView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            OnboardingView()
                .previewDevice(.init(stringLiteral: "iPhone 12"))
            
            OnboardingView()
                .previewDevice(.init(stringLiteral: "iPhone SE (1st generation)"))
            
            OnboardingView()
                .preferredColorScheme(.dark)
                .previewDevice(.init(stringLiteral: "iPhone 12"))
        }
    }
}
#endif
