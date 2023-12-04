//
//  QuizListView.swift
//  QuizSwift_parte1
//
//  Created by c142 DIT UPM on 22/11/23.
//

import SwiftUI

struct QuizListView: View {

    // @State var quizzesModel = QuizzesModel()
    // var quizzesModel: QuizzesModel // si no lo herda de enviroment sino como parametro
    // para que lo herede del entorno lo tiene que heredar de esta manerea:
    @Environment (QuizzesModel.self) var quizzesModel
    @Environment (\.colorScheme) var colorScheme
    //@Environment (ScoresModel.self) var scoresModel
    // @Environment (QuizzesModel.self) var quizzesModel: QuizzesModel

    var body: some View {
        
        NavigationStack{
                
                List {
                    ForEach(quizzesModel.quizzes){quizItem in
                        NavigationLink {
                            QuizItemPlayView(quizItem: quizItem)
                        } label: {
                            QuizItemRowView(quizItem: quizItem)
                            
                        }
                    }
                    .listRowBackground(Color.cPrincipal)
                    .foregroundColor(.black)
                    //.listRowSeparator(.automatic)
                    
                }
            
            //.foregroundColor(.green)
            //.foregroundColor(.cLetras)
            
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.cFou2)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack{
                        Spacer()
                        Text("Practica 4 Quizzes")
                            //.font(.headline)
                            //.fontWidth(.expanded)
                            .font(.system(size: 35))
                            .bold()
                        //.frame(width: 200, height: 50, alignment: .center)
                        Spacer()
                    }
                }
            }

            //.navigationBarTitle(Text("Today's Flavors", displayMode: .inline))

        
            
        }
        .onAppear ( perform: {
            guard quizzesModel.quizzes.count == 0 else {return}
            quizzesModel.load()
        })
        .background(Color.green)
        //.background(Color.cFou.edgesIgnoringSafeArea(.all))
        //.padding()
        
    }
    
        
       //& .colorMultiply(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
}
/*
#Preview {
    QuizListView()
}*/

#Preview {
    
    let quizzesModel = QuizzesModel()
    let scoresModel = ScoresModel()

    // return QuizzItemPlayView(quizItem: model.quizzes[0])
    return
        QuizListView()
            .environment(quizzesModel)
            .environment(scoresModel)
    
    // return QuizzItemPlayView(quizItem: model.quizzes[0])
}
