//
//  Register.swift
//  Firebase_Example
//
//  Created by SHIBA on 17/5/2565 BE.
//

import SwiftUI
import Firebase

struct Register: View {
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    
    @State var StatusMessage = ""
    @State private var shouldShowLoginAlert: Bool = false
    @Binding var isUserCurrentlyLoggedOut : Bool
    

    var body: some View {
       
        VStack{ //Open VStack
            
            Text("Welcome to Register")
                .font(.system(size: 35, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(red: 31 / 255, green: 65 / 255, blue: 114 / 255))
            Text("Mind Diary")
                .font(.system(size: 35, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(red: 31 / 255, green: 65 / 255, blue: 114 / 255))
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Username")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
              
                TextField("username", text: $username)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.top, 5)

                Divider()
                    .background(Color.black)
            }).padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Email")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                TextField("Email@gmail.com", text: $email)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.top, 5)
                Divider()
                    .background(Color.black)
            }).padding(.top, 20)
            
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
            
            //Register Button
            Button{
                register()
            }
            label: {
                Text("Register")
                    .foregroundColor(.white)
                    .bold()
                    .frame(width: 200, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.black)
                    )
            }.padding(.all, 20)
               

        }
        .onAppear {
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil{
                    isUserCurrentlyLoggedOut.toggle()
                }
            }
        } //Close VStack
        .padding(.all, 20)
        .frame( maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
    
    
    
    func register(){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil{
                
                print("Failed to create user:", error!)
                self.StatusMessage = "Failed to create user: \(error!)"
                return
            }
            print("Successfully created user: \(result?.user.uid ?? "")")
            self.StatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            self.storeUserInformation()
            self.isUserCurrentlyLoggedOut = true
        }
    }
    
    func storeUserInformation() {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let userData = ["username": self.username, "email": self.email, "uid": uid]
            Firestore.firestore().collection("users")
                .document(uid).setData(userData) { err in
                    if let err = err {
                        print(err)
                        self.StatusMessage = "\(err)"
                        return
                    }
                    print("Success")
                }
        }
    
}



struct Register_Previews: PreviewProvider {
    @State static var isUserCurrentlyLoggedOut = false
    static var previews: some View {
        Register(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
    }
}
