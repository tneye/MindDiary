//
//  FetchUser.swift
//  Firebase_Example
//
//  Created by SHIBA on 23/5/2565 BE.
//

import SwiftUI
import Firebase
 
struct ChatUser {
    let uid, email, username: String
}
 
class FetchUser: ObservableObject {
     
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
     
    init() {
         
        fetchCurrentUser()
    }
     
    private func fetchCurrentUser() {
 
        guard let uid = Auth.auth().currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
         
         
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user:", error)
                return
            }
             
            self.errorMessage = "123"
             
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
                 
            }
            self.errorMessage = "Data: \(data.description)"
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let username = data["username"] as? String ?? ""
            self.chatUser = ChatUser(uid: uid, email: email, username: username)
             
            
             
        }
    }
}
