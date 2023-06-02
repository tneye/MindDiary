//
//  Firebase_ExampleApp.swift
//  Firebase_Example
//
//  Created by SHIBA on 16/5/2565 BE.
//

import SwiftUI
import Firebase

@main
struct Firebase_ExampleApp: App {
    @StateObject var dataManager = DataManager()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            //ListView().environmentObject(dataManager)
            ContentView().environmentObject(dataManager)
            //Welcome().environmentObject(dataManager)
        }
    }
}
