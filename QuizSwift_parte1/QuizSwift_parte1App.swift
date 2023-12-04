//
//  QuizSwift_parte1App.swift
//  QuizSwift_parte1
//
//  Created by c142 DIT UPM on 22/11/23.
//

import SwiftUI
import SwiftData

@main
struct QuizSwift_parte1App: App {
    @State var quizzesModel = QuizzesModel()
    @State var scoresModel = ScoresModel()
    
    var body: some Scene {
        WindowGroup {
            
            QuizListView()
                .environment(quizzesModel)
                .environment(scoresModel)
        }
    }
}

