//
//  ContentView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 06/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var presentingOnboardingSheet = false
    
    private let storage = EnvironmentResolver.storageProvider
    
    func onAppear() {
        presentingOnboardingSheet = !storage.bool(forKey: storage.onboardedKey)
        
        if presentingOnboardingSheet {
            storage.setValue(true, forKey: storage.onboardedKey)
        }
    }
    
    var body: some View {
        TabView {
            NavigationView {
                FeedView()
                    .navigationTitle("Feed")
                    .navigationBarTitleDisplayMode(.inline)
            }.tabItem {
                Image(systemName: "photo.on.rectangle.angled")
                    .accessibility(identifier: "tab.feed")
            }
            
            NavigationView {
                SavedView()
                    .navigationTitle("Saved")
                    .navigationBarTitleDisplayMode(.inline)
            }.tabItem {
                Image(systemName: "bookmark")
                    .accessibility(identifier: "tab.saved")
            }
            
            NavigationView {
                SettingsView()
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.inline)
            }.tabItem {
                Image(systemName: "wrench.and.screwdriver")
                    .accessibility(identifier: "tab.settings")
            }
        }
        .accentColor(.primary)
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $presentingOnboardingSheet) {
            OnboardingView()
        }
        .onAppear(perform: onAppear)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
#endif
