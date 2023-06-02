//
//  MonthStruct.swift
//  CalendarSwiftUI
//
//  Created by Kjem . on 1/5/2565 BE.
//

import Foundation

import SwiftUI


struct MonthStruct
{
    var monthType: MonthType
    var dayInt : Int
    func day() -> String
    {
        return String(dayInt)
    }
}

enum MonthType
{
    case Previous
    case Current
    case Next
}
