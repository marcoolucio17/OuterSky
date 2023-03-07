//
//  ImageView.swift
//  OuterSky
//
//  Created by Marco Lucio Sosa on 2/14/23.
//

import Foundation
import SwiftUI

var exampleURL = "https://mars.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/02673/opgs/edr/fcam/FLB_634797777EDR_F0790000FHAZ00341M_.JPG"

var exampleMarsObj = NetworkManagerMars()

struct ImageView: View {
    let desiredURL: NetworkManagerMars
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("Image from selection: ")
                        .foregroundColor(Color(.systemGray2))
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                Divider()
                VStack {
                    if desiredURL.images.first?.img_src != nil{
                        GeometryReader { proxy in
                            AsyncImage(url: URL(string: desiredURL.images.first?.img_src ?? exampleURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .edgesIgnoringSafeArea(.all)
                                    .modifier(ImageModifier(contentSize: CGSize(width: proxy.size.width, height: proxy.size.height)))
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                    else {
                        SwiftUI.Image("errorMessage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    Divider()
                    
                    VStack{
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color(.systemGroupedBackground))
                                .cornerRadius(25)
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("RoverID: \(self.desiredURL.images.first?.rover.name ?? "unknown")")
                                    Text("Landing Date: \(self.desiredURL.images.first?.rover.landing_date ?? "unknown")")
                                    Text("Launch Date: \(self.desiredURL.images.first?.rover.launch_date ?? "unknown")")
                                    Text("Status: \(self.desiredURL.images.first?.rover.status ?? "unknown") ")
                                }
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(.systemGray   ))
                                
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    .frame(width: 350, height: 250)
                }
            }
        }
    }
}

struct ImagePreview : PreviewProvider {
    static var previews: some View {
        ImageView(desiredURL: exampleMarsObj)
    }
}
