//
//  String+Extension.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 19/06/25.
//
import Foundation

extension String {
    static func formattedAsUSD(from number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        
        let formattedNumber: String
        
        if number >= 1_000_000_000 {
            formattedNumber = numberFormatter.string(from: NSNumber(value: number / 1_000_000_000))! + "B"
        } else if number >= 1_000_000 {
            formattedNumber = numberFormatter.string(from: NSNumber(value: number / 1_000_000))! + "M"
        } else if number >= 1_000 {
            formattedNumber = numberFormatter.string(from: NSNumber(value: number / 1_000))! + "K"
        } else {
            formattedNumber = numberFormatter.string(from: NSNumber(value: number))!
        }
        
        return "$" + formattedNumber
    }
    
    func formatDateToString() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'"
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy"
        outputFormatter.locale = Locale(identifier: "pt_BR")

        if let date = inputFormatter.date(from: self) {
            let formattedDate = outputFormatter.string(from: date)
            return formattedDate
        }
        
        return String()
    }
}
