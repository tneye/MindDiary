//
//  barChart.swift
//  projext_emotionalTraking
//
//  Created by SHIBA on 14/4/2565 BE.
//

import SwiftUI
import Firebase

struct barChart: View { //Open Strcut barChart
    
    @EnvironmentObject var dataManager: DataManager
   

    var body: some View { //Open Body
        
        ScrollViewReader { scrollView in //Open ScrollViewReader
            //ScrollView(.vertical) { //Open ScrollView
            
            
                ZStack{ // Open ZStack
                    
                    Color.white.opacity(0.8).edgesIgnoringSafeArea(.all)
                    
                    VStack{ // open VStack
                        Text("Statistic Chart")
                            .font(.system(size:25))
                            .fontWeight(.heavy)
                            .padding(.bottom,10)
                            .foregroundColor(Color(red: 31 / 255, green: 65 / 255, blue: 114 / 255))
                       
                     
                            
                        HStack(spacing:16){ //Open HStack
                            VStack{
                                
                                Image("emoji-green").resizable().scaledToFit().frame(width: 30, height: 30).clipShape(Circle())
                                Image("emoji-yellow").resizable().scaledToFit().frame(width: 30, height: 30).clipShape(Circle())
                                Image("emoji-red").resizable().scaledToFit().frame(width: 30, height: 30)
                                    .clipShape(Circle())
                                Image("emoji-purple").resizable().scaledToFit().frame(width: 30, height: 30)
                                    .clipShape(Circle())
                                Image("emoji-blue").resizable().scaledToFit().frame(width: 30, height: 30)
                                    .clipShape(Circle())
                            }
                            .padding(.trailing,20)
                            ForEach(dataManager.percentpoints, id: \.id) { emotion in
                                BarCapsule(value: CGFloat(emotion.percentweek1)/7, text: "Week 1")
                                BarCapsule(value: CGFloat(emotion.percentweek2)/7, text: "Week 2")
                                BarCapsule(value: CGFloat(emotion.percentweek3)/7, text: "Week 3")
                                BarCapsule(value: CGFloat(emotion.percentweek4)/7, text: "Week 4")
                            }
                        }//Close HStack
                        .padding([.leading, .trailing, .bottom], 20)
                        .border(Color.gray)
                        .cornerRadius(20)
                        .background(Color.gray.opacity(0.3).cornerRadius(20))
                        //Circle Bar
                        Text("Percent of Emotion")
                            .font(.system(size:18))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading,24)
                            .padding([.top,.bottom], 5)
                        Divider()
                            .padding([.leading, .trailing],40)
                            .frame(width: 70, height: 3)
                        HStack(spacing:20){ //Open HStack
                            
                            ForEach(dataManager.circlepoints, id: \.id) { emotion in
                                CircleBar(percent: CGFloat(emotion.green)/2, emoji: "emoji-green", color: Color.green)
                                CircleBar(percent: CGFloat(emotion.yellow)/2, emoji: "emoji-yellow", color: Color.yellow)
                                CircleBar(percent: CGFloat(emotion.red)/2, emoji: "emoji-red",color: Color.red)
                            }
                            
                        } //Close HStack
                        .padding(.top, 5)
                        
                        HStack(spacing:20){ //Open HStack
                            ForEach(dataManager.circlepoints, id: \.id) { emotion in
                                CircleBar(percent: CGFloat(emotion.purple)/2, emoji: "emoji-purple",color: Color.purple)
                                CircleBar(percent: CGFloat(emotion.blue)/2, emoji: "emoji-blue",color: Color.blue)
                            }
                        } // Close HStack
                        .padding(.top, 5)
                    }//Close VStack
                    
                } //Close ZStack
            } //Close ScrollView
        //} //Close ScrollViewReader
        
    }//Close body
    

} //Close Struct barChart

struct CircleBar: View{
    var percent: CGFloat
    var emoji: String
    var color: Color
    var body: some View{
        let per = percent*100
        VStack{ //Open VStack
            ZStack{ //Open ZStack
                Circle()
                     .trim(from: 0, to: 1)
                     .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                     .frame(width: (UIScreen.main.bounds.width - 230) / 2, height: (UIScreen.main.bounds.width - 230) / 2 )
                Circle()
                     .trim(from: 0, to: percent)
                     .stroke(color.opacity(0.8), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                     .frame(width: (UIScreen.main.bounds.width - 230) / 2, height: (UIScreen.main.bounds.width - 230) / 2 )
                Image(emoji)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50 , height: 50)
                            .rotationEffect(.init(degrees: 90))
                            .clipShape(Circle())
                
            
            } //Close ZStack
            .rotationEffect(.init(degrees: -90))
            
            HStack{
                Text(String(format: "%.1f", per))
                    .font(.system(size: 14))
                    .padding(.top, 10)
                Text("%")
                    .font(.system(size: 14))
                    .padding(.top, 10)
            }
            
        } //Close VStack
    }

    
    func getPercent(current: CGFloat, Goal: CGFloat)->String{
        let per = ( current / Goal ) * 100
        return String(format: "%.1f", per)
    }
}

struct BarCapsule: View{
    
    var value: CGFloat = 0
    var text: String = ""
    var body: some View{
        VStack{ //Open VStack
            
            ZStack(alignment: .bottom){ //Open ZStack
                Capsule().frame(width: 30, height: 200)
                    .foregroundColor(Color.white.opacity(0.5))
                Capsule().frame(width: 30, height: value)
                    .foregroundColor(Color(red: 31 / 255, green: 65 / 255, blue: 114 / 255).opacity(0.8))
            }.padding(.top, 24) //Close ZStack
            
            Text(text).padding(.top, 8).font(.system(size: 14))
            
        } //Close VStack
    }
}

struct barChart_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
