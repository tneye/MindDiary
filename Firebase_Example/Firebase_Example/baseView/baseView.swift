//
//  baseView.swift
//  projext_emotionalTraking
//
//  Created by SHIBA on 14/4/2565 BE.
//

import SwiftUI

struct baseView: View {
    @State var currentTab = "home"
    
    let dateHolder = DateHolder()
    
    var body: some View {
        let houseImage = Image(systemName: "house")
        let chartImage = Image(systemName: "chart.bar")
        let plusImage = Image(systemName: "plus")
        VStack(spacing: 0){
            //Tab View...
            TabView(selection: $currentTab){
                Home().tag("home").environmentObject(dateHolder)
                AddEmo().tag("AddEmo")
                barChart().tag("chart")
                
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
                                .foregroundColor(Color.purple)
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
                Color("BG").ignoresSafeArea()
            )
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
                .frame(width: 25, height: 25)
                .foregroundColor(
                    currentTab == text ? Color.black : Color.gray.opacity(0.8)
                )
        }
    }
}

struct baseView_Previews: PreviewProvider {
    static var previews: some View {
        baseView()
    }
}
