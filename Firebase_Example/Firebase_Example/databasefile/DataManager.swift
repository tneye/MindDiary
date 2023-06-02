//
//  DataManager.swift
//  Firebase_Example
//
//  Created by SHIBA on 17/5/2565 BE.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject{
    @Published var emotionlist: [Datapoint] = []
    @Published var percentpoints: [percentPoint] = []
    @Published var circlepoints: [circlepercent] = []
    
    @Published var timeline: [Timeline] = []
    init(){
        fetchDataForChart()
        fetchDataTimeline()
    }
    func fetchDataForChart(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let ref = db.collection("timelines")
        ref.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            var id:String = ""
            var uid:String = ""
            
            var green:Int = 0
            var yellow:Int = 0
            var red:Int = 0
            var purple:Int = 0
            var blue:Int = 0
            
            var score:Int = 0
            if let snapshot = snapshot {
                for document in snapshot.documents  {
                    let data = document.data()
                    
                    let emotion = data["emotion"] as? String ?? ""
                    let userid = data["uid"] as? String ?? ""
                    let iddata = data["id"] as? String ?? ""
                    id = iddata
                    uid = userid
                    if (uid == userid){
                        
                        if (emotion == "green"){
                            score = 100
                            green = green+1
                        }else if(emotion == "yellow"){
                            score = 80
                            yellow = yellow+1
                        }else if(emotion == "red"){
                            score = 60
                            red = red+1
                        }else if(emotion == "purple"){
                            score = 40
                            purple = purple+1
                        }else if(emotion == "blue"){
                            score = 20
                            blue = blue+1
                        }
                        let emotions = Datapoint(id: id, emotion_score: score, emotion: emotion)
                        
                        self.emotionlist.append(emotions)
                        
                    }
                }
            }
            let circlepoint = circlepercent(id: id, green: green, yellow: yellow, red: red, purple: purple, blue: blue)
            self.circlepoints.append(circlepoint)
            
            var percentemo:Int = 0
            var percentemo2:Int = 0
            var percentemo3:Int = 0
            var percentemo4:Int = 0
            var num:Int = 0
            for i in self.emotionlist {
                num = num+1
                if(num < 8){
                    percentemo = percentemo + i.emotion_score
                }
                else if(num >= 8){
                    percentemo2 = percentemo2 + i.emotion_score
                }
                else if(num >= 15){
                    percentemo3 = percentemo3 + i.emotion_score
                }
                else if(num >= 22){
                    percentemo4 = percentemo4 + i.emotion_score
                }
            }
            let percent = percentPoint(id: id, percentweek1: percentemo, percentweek2: percentemo2, percentweek3: percentemo3, percentweek4: percentemo4)
            self.percentpoints.append(percent)
            
            
            
       }
    }
    func fetchDataTimeline(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let ref = db.collection("timelines")
        ref.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents  {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let date = data["date"] as? String ?? ""
                    let text = data["text"] as? String ?? ""
                    let emotion = data["emotion"] as? String ?? ""
                    let uid = data["uid"] as? String ?? ""
                    
                    let timelineData = Timeline(id: id, uid: uid, emotion: emotion, text: text, date: date)
                    self.timeline.append(timelineData)
                }
            }
            
        }
    }

    
}
