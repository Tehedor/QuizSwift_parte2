//
//  EasyAsyncImage.swift
//  QuizSwift_parte1
//
//  Created by c142 DIT UPM on 22/11/23.
//

import Foundation

import SwiftUI


struct EasyAsyncImage: View {
    // var quizItem: QuizItem
    var url: URL?
    var body: some View {

            // let url = quizItem.attachment?.url

        // var url = URL?
        // var url : URL? = quizItem.attachment?.url

        AsyncImage(url:  url) {phase in
            if url == nil {
                // Poner color blanco
                Color.white

            }else if  let image = phase.image {
                image.resizable()
                //Image(uiImage: image).resizable()
            }
            else if phase.error != nil {
                Color.red
            }else {
                ProgressView() //muestra un spinner de carga
                // ProcessView()
            }
        }
                // .frame(width: 60, height: 60)
                // .scaledToFill()
                // .clippedShape(Circle())
                // .overlay{
                //     Circle()
                //         .stroke(Color.blue, lineWidth: 2)
                // }
                // .shadow(color: .blue, radius: 5, x: 0.0, y: 0.0)

    }
}

/*
#Preview {
    struct EasyAsyncImage_Previews: PreviewProvider {
        static var previews: some View {
            EasyAsyncImage(url: URL(string: "https://example.com/image.jpg"))
        }
    }
}*/
// #Preview {
//    EasyAsyncImage()
// }
