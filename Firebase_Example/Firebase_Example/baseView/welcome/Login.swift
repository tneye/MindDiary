//
//  Login.swift
//  Firebase_Example
//
//  Created by SHIBA on 17/5/2565 BE.
//

import SwiftUI
import Firebase

struct Login: View {
    @State private var email = ""
    @State private var password = ""
    
    @State var StatusMessage = ""
    @State private var shouldShowLoginAlert: Bool = false
    @Binding var isUserCurrentlyLoggedOut : Bool
    
    
    var body: some View {
        VStack(alignment: .leading){ //Open VStack
            
            Text("Welcome to Sign In")
                .font(.system(size: 35, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(red: 31 / 255, green: 65 / 255, blue: 114 / 255))
            Text("Mind Diary")
                .font(.system(size: 35, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(red: 31 / 255, green: 65 / 255, blue: 114 / 255))
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Email")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                TextField("Email@gmail.com", text: $email)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.top, 5)
                Divider()
                    .background(Color.black)
            }).padding(.top, 25)

            VStack(alignment: .leading, spacing: 8, content: {
              
                Text("Password")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                SecureField("******", text: $password)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.top, 5)
                Divider()
                    .background(Color.black)
            }).padding(.top, 15)
            
            //Sign in button
            HStack{
                Spacer()
                Button{
                    login()
                } label: {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.black)
                        )
                }
                Spacer()
            }
            .padding(.all, 20)
            
            
            
        }
        .onAppear {
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil{
                    isUserCurrentlyLoggedOut.toggle()
                }
            }
        }
        .padding(.all, 20)
        .frame( maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
    
    func login(){
        Auth.auth().signIn(withEmail: email , password: password) { result, error in
            if error != nil{
                print(error!.localizedDescription)
                self.StatusMessage = "Failed to login user: \(error!)"
                self.shouldShowLoginAlert = true
                return
            }
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            self.StatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
            self.isUserCurrentlyLoggedOut = true
        }
    }
}


struct Login_Previews: PreviewProvider {
    @State static var isUserCurrentlyLoggedOut = false
    static var previews: some View {
        Login(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
    }
}
