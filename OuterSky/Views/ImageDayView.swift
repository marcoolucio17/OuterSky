//
//  ImageDayView.swift
//  OuterSky
//
//  Created by Marco Lucio Sosa on 2/14/23.
//

import Foundation
import SwiftUI
import UIKit


var exURL = "https://apod.nasa.gov/apod/image/2302/HeartSoul_deHaro_1080.jpg"
var exExplanation = "ladsnkflnlsnlknalfnalknslfaknslknf"

struct ImageDayView: View {
    
    @State private var isPressed = false
    @State var lastScaleValue: CGFloat = 1.0
    
    let desiredURL: String
    // let networkManger: NetworkManagerImage
    let explanation: String
    
    var body: some View {

        ZStack {
            
            Rectangle()
                .foregroundColor(Color(.quaternarySystemFill))
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                
                HStack {
                    Text("Image of the day")
                        .font(.title)
                        .foregroundColor(Color(uiColor: .systemGray))
                    .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal, 10)
                
                Divider()
                
                VStack {
                    GeometryReader { proxy in
                        AsyncImage(url: URL(string: desiredURL)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .edgesIgnoringSafeArea(.vertical)
                        .modifier(ImageModifier(contentSize: CGSize(width: proxy.size.width, height: proxy.size.height)))
                        } placeholder: {
                            ProgressView()
                    }

                    }
                    .frame(width: 350, height: 300)
                }
                
                VStack {
                    Text(explanation)
                        .foregroundColor(Color(uiColor: .systemGray))
                        .font(.body)
                        
                }
                .padding()
            }
        }
    }
}

struct ImageDayPreview : PreviewProvider {
    static var previews: some View {
        ImageDayView(desiredURL: exURL, explanation: exExplanation)
    }
}
