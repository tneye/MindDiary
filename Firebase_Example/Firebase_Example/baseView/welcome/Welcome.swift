//
//  Welcome.swift
//  Firebase_Example
//
//  Created by SHIBA on 17/5/2565 BE.
//

import SwiftUI

struct Welcome: View {
    @State var showSignUp = false
    @Binding var isUserCurrentlyLoggedOut : Bool
    
    var body: some View {
       
        VStack{
            ZStack{
                if showSignUp{
                    Login(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
                        .transition(.move(edge: .trailing))
                }
                else{
                    Register(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
                        .transition(.move(edge: .trailing))
                }
                
            }
        }
        .overlay(
            HStack{
                Text(showSignUp ? "New Member?" : "Already have an account?")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                Button(action: {
                    withAnimation{
                        showSignUp.toggle()
                    }
                }, label: {
                    Text(showSignUp ? "Register" : "Sign In")
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 31 / 255, green: 65 / 255, blue: 114 / 255))
                })
            }, alignment: .bottom
        )
        
    }
}

struct Welcome_Previews: PreviewProvider {
    @State static var isUserCurrentlyLoggedOut = false
    static var previews: some View {
        Welcome(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
    }
}
