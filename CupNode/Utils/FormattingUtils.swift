//
//  FormattingUtils.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import Foundation

func formatCurrency(_ value: Double?, currency: String) -> String {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "en_US")
    formatter.numberStyle = .currency
    formatter.currencyCode = currency
    
    if let valueToBeFormatted = value {
        return formatter.string(from: NSNumber(value: valueToBeFormatted)) ?? ""
    }
    
    return ""
}

func formatRelativeTime(_ value: String?) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Set the input format of the timestamp string
    
    if let dataValue = value, let date = dateFormatter.date(from: dataValue) {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 1
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        
        let difference = Calendar.current.dateComponents([.year, .month, .weekOfMonth, .day, .hour, .minute, .second], from: date, to: Date())
        return formatter.string(from: difference) ?? ""
    } else {
        return ""
    }
}
