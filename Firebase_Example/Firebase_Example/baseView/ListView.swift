//
//  ListView.swift
//  Firebase_Example
//
//  Created by SHIBA on 17/5/2565 BE.
//

import SwiftUI
import Firebase
import SystemConfiguration

struct ListView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showPopup = false
    
    @State var shouldShowLogOutOptions = false
    @Binding var isUserCurrentlyLoggedOut : Bool
    
    @State private var showModal = false
    @State var currentTab = "home"
    let dateHolder = DateHolder()
    
    @State var showaddemo = false
    
    var body: some View {
        let houseImage = Image(systemName: "calendar")
        let chartImage = Image(systemName: "chart.bar")
        let plusImage = Image(systemName: "plus")
        
        ZStack{
            
            VStack{//Open VStack
              
                //Header
                HStack{
                   // Text("Mind Diary")
                     //   .font(.system(size:25))
                       // .fontWeight(.bold)
                    Spacer()
                  
                    Button(action: {showModal = true}){
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.black)
                    }
                        
                }
               
                .padding(.trailing, 20)
                
                
                //Tab View...
                TabView(selection: $currentTab){
                    Home().tag("home")
                    barChart().tag("chart").environmentObject(dataManager)
                    AddEmo().tag("AddEmo")
                }
                // Custom Tab Bar
                HStack(spacing: 90){
                    //Tab button
                    TabButton(image: houseImage, text: "home")
                    Button{
                        withAnimation{currentTab = "AddEmo"}
                    } label: {
                        plusImage
                            .font(.system(size:20, weight: .bold))
                            .foregroundColor(.white)
                            .padding(20)
                            .background(
                                Circle()
                                    .foregroundColor(
                                        currentTab == "AddEmo" ? Color(red: 31 / 255, green: 65 / 255, blue: 114 / 255) : Color(red: 254 / 255, green: 187 / 255, blue: 187 / 255).opacity(0.8)
                                    )
                                //shadow
                                    .shadow(color: Color("Tab").opacity(0.15), radius: 5, x: 0, y: 8)
                            )
                    }
                    .offset(y:-20)
                    .padding(.horizontal, -15)
                    TabButton(image: chartImage, text: "chart")
                }
                .padding(.top,-10)
                .frame(maxWidth:.infinity)
                .background(
                    Color(.white).ignoresSafeArea()
                )
            }
            ModalView(isShowing: $showModal, isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
        }
    }
        @ViewBuilder
        func TabButton(image: Image, text: String)-> some View{
            Button{
                withAnimation{currentTab = text}
            }label:{
                
                image
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(
                        currentTab == text ? Color(red: 31 / 255, green: 65 / 255, blue: 114 / 255) : Color(red: 254 / 255, green: 187 / 255, blue: 187 / 255).opacity(0.8)
                    )

            }
        }
}
            
           
            
            
 

struct ListView_Previews: PreviewProvider {
    @State static var isUserCurrentlyLoggedOut = false
    static var previews: some View {
        ListView(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
    }
}
