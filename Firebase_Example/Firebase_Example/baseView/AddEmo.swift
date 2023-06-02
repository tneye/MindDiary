//
//  AddEmo.swift
//  Firebase_Example
//
//  Created by SHIBA on 27/5/2565 BE.
//

import SwiftUI
import Firebase
struct AddEmo: View {
    
    @State private var text: String = ""
    @State private var emotion: String = ""
    @State var StatusMessage = ""
   
    @State private var greenIsSelected = false
    @State private var yellowIsSelected = false
    @State private var redIsSelected = false
    @State private var purpleIsSelected = false
    @State private var blueIsSelected = false
    @State private var alreadyUpdate = false
    
    var body: some View {
        VStack{ //Open VStack
            
            VStack (alignment: .leading){ //Open Stack
                Text("How was your day?")
                    .font(.system(size:25))
                    .fontWeight(.heavy)
                    .padding(.bottom,20)
                
                HStack{//Open HStack
                    Button(action: {
                      
                        self.greenIsSelected = true
                        self.yellowIsSelected = false
                        self.redIsSelected = false
                        self.purpleIsSelected = false
                        self.blueIsSelected = false
                        self.emotion = "green"
                    }) {
                        Image(greenIsSelected ? "emoji-green" : "emoji-green-not").resizable().scaledToFit().frame(width: 70, height: 70)
                    }
                    Button(action: {
                        self.yellowIsSelected = true
                        self.greenIsSelected = false
                        self.redIsSelected = false
                        self.purpleIsSelected = false
                        self.blueIsSelected = false
                        self.emotion = "yellow"
                    }) {
                        Image(yellowIsSelected ? "emoji-yellow" : "emoji-yellow-not").resizable().scaledToFit().frame(width: 70, height: 70)
                    }
                    Button(action: {
                        self.redIsSelected = true
                        self.greenIsSelected = false
                        self.yellowIsSelected = false
                        self.purpleIsSelected = false
                        self.blueIsSelected = false
                        self.emotion = "red"
                    }) {
                        Image(redIsSelected ? "emoji-red" : "emoji-red-not").resizable().scaledToFit().frame(width: 70, height: 70)
                    }
                    Button(action: {
                        self.purpleIsSelected = true
                        self.greenIsSelected = false
                        self.yellowIsSelected = false
                        self.redIsSelected = false
                        self.blueIsSelected = false
                        self.emotion = "purple"
                    }) {
                        Image(purpleIsSelected ? "emoji-purple" : "emoji-purple-not").resizable().scaledToFit().frame(width: 70, height: 70)
                    }
                    Button(action: {
                        self.blueIsSelected = true
                        self.greenIsSelected = false
                        self.yellowIsSelected = false
                        self.redIsSelected = false
                        self.purpleIsSelected = false
                        self.emotion = "blue"
                    }) {
                        Image(blueIsSelected ? "emoji-blue" : "emoji-blue-not").resizable().scaledToFit().frame(width: 70, height: 70)
                    }
                 
                }//Close HStack
            }//Close VStack
            .padding(.bottom, 10)
            VStack(alignment: .leading){ //Open VStack
                Text("Today's note")
                    .font(.system(size:20))
                    
                TextField("", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                   
            }//Close VStack
            .padding([.trailing, .leading], 20)
            
            Button{
                storeUserInformation()
                hideKeyboard()
                self.text = ""
                self.emotion = ""
                self.greenIsSelected = false
                self.yellowIsSelected = false
                self.redIsSelected = false
                self.purpleIsSelected = false
                self.blueIsSelected = false
                self.alreadyUpdate = true
            }label: {
                Text("Done")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color.white)
                    .padding([.top, .bottom], 10)
                    .padding([.leading, .trailing], 120)
                    .background(Color.black)
                    .cornerRadius(5)
            }
            
            Text(alreadyUpdate ? "" : "you already added your day if you do again it'll update")
                .padding(.all)
            Spacer()
        } //Close VStack
        
    }

    func storeUserInformation() {
        
        var date = Date().formatted(.dateTime.day().month().year())
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let identifier = UUID().uuidString
        let ref = db.collection("timelines").document(date)
        ref.setData(["emotion": self.emotion, "uid": uid, "text": self.text , "date": date, "id": identifier]) { error in
                if let error = error{
                    print(error.localizedDescription)
                }
            }

        }
}
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
struct AddEmo_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
