//
//  Constants.swift
//  Project23
//
//  Created by John Salvador on 5/27/22.
//

import Foundation
import UIKit

enum Constants {
    enum ImageName {
        static let sliceBackground = "sliceBackground"
        static let sliceLife = "sliceLife"
        static let sliceBomb = "sliceBomb"
        static let penguin = "penguin"
    }
    
    enum SoundName {
        static let sliceBombFuse = "sliceBombFuse"
        static let cafExtension = "caf"
        static let launchSoundWithCafExt = "launch.caf"
    }
    
    enum EmitterNode {
        static let sliceFuse = "sliceFuse"
    }
}


enum Styles {
    enum FontName {
        static let chalkduster = "Chalkduster"
    }
    
    enum Color {
        static let activeSliceBGColor = UIColor(red: 1, green: 0.9, blue: 0, alpha: 1)
        static let white = UIColor.white
    }
}
