//
//  ContentView.swift
//  Firebase_Example
//
//  Created by SHIBA on 16/5/2565 BE.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
   
    @State private var isUserCurrentlyLoggedOut: Bool = false
         
    
    var body: some View {
        if self.isUserCurrentlyLoggedOut{
           // go somewhere
            ListView(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
        } else{
            Welcome(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
