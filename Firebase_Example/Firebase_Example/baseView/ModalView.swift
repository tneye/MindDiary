//
//  ModalView.swift
//  Firebase_Example
//
//  Created by SHIBA on 23/5/2565 BE.
//

import SwiftUI
import Firebase

struct ModalView: View {
    @Binding var isShowing: Bool
    @Binding var isUserCurrentlyLoggedOut: Bool
    @State private var curHeight: CGFloat = 250
    let minHeight: CGFloat = 250
    let maxHeight: CGFloat = 500
    
    @State var shouldShowLogOutOptions = false
    
    @ObservedObject private var vm = FetchUser()
    
    
    var body: some View {
        ZStack(alignment: .bottom){
            if isShowing{
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                mainView
                .background(Color.white)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut)
    }
    
    var mainView: some View{
        VStack{
            //Handle
            ZStack{
                Capsule()
                    .frame(width: 40, height: 6)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            
            
            ZStack{
                VStack{
                    
                    let email = vm.chatUser?.email
                    let username = vm.chatUser?.username
                    
                    HStack{
                        Image("man")
                            .resizable()
                            .frame(width: 80.0, height: 80.0)
                            .padding(.trailing, 10)
                        VStack(alignment: .leading){
                            Text(email!)
                                .font(.system(size: 20, weight: .regular))
                            Text(username!)
                                .font(.system(size: 20, weight: .regular))
                            
                        }
                        
                    }
                   Spacer()
                   
                    Button {
                         shouldShowLogOutOptions.toggle()
                     } label: {
                         Text("Log out")
                             .font(.system(size: 24, weight: .bold))
                             .foregroundColor(Color.white)
                             .padding([.top, .bottom], 10)
                             .padding([.leading, .trailing], 120)
                             .background(Color.black)
                             .cornerRadius(5)
                     }
                     .actionSheet(isPresented: $shouldShowLogOutOptions) {
                     .init(title: Text("Sign Out"), message: Text("Are you sure?"), buttons: [
                             .destructive(Text("Sign Out"), action: {
                                 print("handle sign out")
                                 try? Auth.auth().signOut()

                                 self.isUserCurrentlyLoggedOut = false
                             }),
                                 .cancel()
                         ])
                     }
                    Spacer()
                    
                }
                .padding(.horizontal, 30)
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
        }
        .frame(height: curHeight)
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }

}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
