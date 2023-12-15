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
    @Environment (ScoresModel.self) var scoresModel
    @Environment (\.colorScheme) var colorScheme
    //@Environment (ScoresModel.self) var scoresModel
    // @Environment (QuizzesModel.self) var quizzesModel: QuizzesModel

    @State var errorMsg = "" {
            didSet {
                showErrorMsgAlert = true
            }//Cuando cambie errorMsg que se ponga a true, es un observador y asi no hace falta ponerlo a true a lo largo de la práctia
        }
    @State var showErrorMsgAlert = false

    @State var showAll = true
    
    var body: some View {
        
        NavigationStack{
            
                List {
                    Toggle("Ver todos", isOn:
                                    $showAll)
                    ForEach(quizzesModel.quizzes){quizItem in
                        if showAll || scoresModel.pendiente(quizItem) {
                        //if showAll || quizItem.pendiente(quizItem) {
                            NavigationLink {
                                QuizItemPlayView(quizItem: quizItem)
                            } label: {
                                QuizItemRowView(quizItem: quizItem)
                                
                            }
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
            .navigationBarItems( // Boton de refrescar
                leading: Text("Record \(scoresModel.record.count)"),
                trailing: Button(action:{
                    Task  {
                        do { // para que no se descargue cada vez que se entra en la vista y pornga el error si se la pega
                            try await quizzesModel.download() //try: porque la sentencia puede mandar errores
                            scoresModel.cleanup()
                        } catch {
                            errorMsg = error.localizedDescription
                        }
                    }
                }, label:{
                    Label("Refrescar", systemImage: "arrow.counterclockwise")
                })
            )

            //.navigationBarTitle(Text("Today's Flavors", displayMode: .inline))

        
            
        }
        .alert("Erroor", isPresented: $showErrorMsgAlert) {
            } message: { Text(errorMsg)
            }
        .task  {
            do { // para que no se descargue cada vez que se entra en la vista y pornga el error si se la pega
                guard quizzesModel.quizzes.count == 0 else {return}
                try await quizzesModel.download() //try: porque la sentencia puede mandar errores
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        .background(Color.cFou.edgesIgnoringSafeArea(.all))
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
