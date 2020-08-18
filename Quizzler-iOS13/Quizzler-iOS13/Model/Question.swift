//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Kirill Kuklin on 2020-08-16.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct Question
{
    let text: String
    let answer: String
    
    init(q: String, a: String)
    {
        text = q
        answer = a
    }
}
