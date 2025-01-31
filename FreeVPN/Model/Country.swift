//
//  Country.swift
//  FreeVPN
//
//  Created by P Deepanshu on 31/01/25.
//

import Foundation

struct Country: Identifiable {
    let id = UUID()
    let countries = ["Canada", "United Kingdom", "South Korea", "United States", "France", "Germany"]
    let countryFlags = ["🇨🇦", "🇬🇧", "🇰🇷", "🇺🇸", "🇫🇷", "🇩🇪"]
}
