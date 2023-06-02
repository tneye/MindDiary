//
//  Home.swift
//  projext_emotionalTraking
//
//  Created by SHIBA on 14/4/2565 BE.
//

import SwiftUI

struct Home: View { //Open View Struct

    @EnvironmentObject var dataManager: DataManager
    
    
    var body: some View { //Open View
        ScrollViewReader { scrollView in //Open ScrollViewReader
            ScrollView(.vertical) { //Open ScrollView
                VStack{//Open VStack

                    Text("Timeline Mood")
                        .font(.system(size:25))
                        .fontWeight(.heavy)
                        .padding(.bottom,20)
                        .foregroundColor(Color(red: 31 / 255, green: 65 / 255, blue: 114 / 255))
                    
                    //if(dataManager.timeline.isEmpty){ //Open if
                      //   Text("You don't have timeline right now")
                      //   Spacer()
                    //}//Close if
                     
                     
                    ForEach(dataManager.timeline, id: \.id) { emotion in //Open ForEach
                         HStack{ //OPen HStack
                             VStack{ //Open VSTack
                                 
                                 if(emotion.emotion == "green"){
                                     Image("emoji-green").resizable().scaledToFit().frame(width: 70, height: 70).clipShape(Circle())
                                 }
                                 else if(emotion.emotion == "yellow"){
                                     Image("emoji-yellow").resizable().scaledToFit().frame(width: 70, height: 70).clipShape(Circle())
                                 }
                                 else if(emotion.emotion == "red"){
                                     Image("emoji-red").resizable().scaledToFit().frame(width: 70, height: 70).clipShape(Circle())
                                 }
                                 else if(emotion.emotion == "purple"){
                                     Image("emoji-purple").resizable().scaledToFit().frame(width: 70, height: 70).clipShape(Circle())
                                 }
                                 else if(emotion.emotion == "blue"){
                                     Image("emoji-blue").resizable().scaledToFit().frame(width: 70, height: 70).clipShape(Circle())
                                     
                                 }
                                 
                                 
                                 Text(emotion.date)
                                     .foregroundColor(Color(red: 31 / 255, green: 65 / 255, blue: 114 / 255))
                                     .fontWeight(.bold)
                                    
                             } //Close Vstack
                             .padding(.top, 10)
                             
                             Rectangle().fill(Color.white).frame(width: 3, height: 70, alignment: .center).padding([.trailing ,.leading], 15.5)
                               
                             VStack{ //Open Vstack
                                 Text("How was your day?")
                                     .fontWeight(.bold)
                                     .foregroundColor(Color(red: 31 / 255, green: 65 / 255, blue: 114 / 255))
                                     .frame(width: 200, alignment: .leading)
                                     
                                 Text(emotion.text)
                                     .frame(width: 200, alignment: .leading)
                                     .foregroundColor(.black).opacity(0.8)
                             }//Close VStack
                            
                             
                         }//Close HStack
                         .padding(.all, 10)
                         .border(Color.gray)
                         .background(Color.gray.opacity(0.3))
                         .cornerRadius(10)
                         
                    }//Close ForEach

                }//Close VStack
            }
        }
    }//Close view
}//Close Struct View



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
