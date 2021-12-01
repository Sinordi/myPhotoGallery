//
//  MyCustomLabel.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 01.12.2021.
//

import UIKit
import CLTypingLabel

class MyCustomLabel: CLTypingLabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.text = "Введите свой запрос"
        self.font = UIFont(name: "Kefa", size: 25)
        self.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.charInterval = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
