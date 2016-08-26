//
//  NewsItem.swift
//  StretchyHeaders
//
//  Created by Matthew Cheok on 23/9/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

import Foundation
import UIKit

struct NewsItem {
    enum NewsCategory: String {
        case World
        case Americas
        case Europe
        case MiddleEast = "Middle East"
        case Africa
        case AsiaPacific = "Asia-Pacific"
        
        func toString() -> String {
            return self.rawValue
        }
        
        func toColor() -> UIColor {
            switch self {
            case .World:
                return UIColor(red: 0.106, green: 0.686, blue: 0.125, alpha: 1)
            case .Americas:
                return UIColor(red: 0.114, green: 0.639, blue: 0.984, alpha: 1)
            case .Europe:
                return UIColor(red: 0.322, green: 0.459, blue: 0.984, alpha: 1)
            case .MiddleEast:
                return UIColor(red: 0.502, green: 0.290, blue: 0.984, alpha: 1)
            case .Africa:
                return UIColor(red: 0.988, green: 0.271, blue: 0.282, alpha: 1)
            case .AsiaPacific:
                return UIColor(red: 0.620, green: 0.776, blue: 0.153, alpha: 1)
            }
        }
    }
    
    let category: NewsCategory
    let summary: String
}