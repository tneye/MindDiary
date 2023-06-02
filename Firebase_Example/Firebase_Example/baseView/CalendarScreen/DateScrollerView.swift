//
//  DateScrollerView.swift
//  CalendarSwiftUI
//
//  Created by Kjem . on 1/5/2565 BE.
//

import SwiftUI

struct DateScrollerView: View
{
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View
    {
        VStack(alignment: .leading, spacing: 10)
        {//Open VS
        HStack
        {//open HS1
            
            Button(action: previousMonth)
            {
                Image(systemName: "chevron.left").imageScale(.medium).font(Font.title).foregroundColor(Color.black)
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            Spacer()
            Text(CalendarHelper().monthYearString(dateHolder.date)).font(.title)
                .bold()
            
            Spacer()
            Button(action: nextMonth)
            {
                Image(systemName: "chevron.right").imageScale(.medium).font(Font.title).foregroundColor(Color.black)
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            
        
        }//close HS1
        }//close VS
    }
    func previousMonth()
        {
            dateHolder.date = CalendarHelper().minusMonth(dateHolder.date)
        }
        
    func nextMonth()
        {
            dateHolder.date = CalendarHelper().plusMonth(dateHolder.date)
        }
}


struct DateScrollerView_Previews: PreviewProvider {
    static var previews: some View {
        DateScrollerView()
    }
}
