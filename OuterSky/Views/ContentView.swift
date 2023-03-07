//
//  ContentView.swift
//  OuterSky
//
//  Created by Marco Lucio Sosa on 2/9/23.
//

import SwiftUI

struct ContentView: View {
    init() {
            //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color(.systemGray))]

        }
    
    @ObservedObject var networkManagerImage = NetworkManagerImage()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(.quaternarySystemFill))
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        
                        SwiftUI.Image("imageButton")
                            .resizable()
                            .cornerRadius(30)
                            //.blur(radius: 1)
                        
                        NavigationLink(destination: ImageDayView(desiredURL: networkManagerImage.ImageData?.hdurl ?? exURL, explanation: networkManagerImage.ImageData?.explanation ?? "Picture")){
                            
                            VStack {
                                
                                if #available(iOS 16.1, *) {
                                    Text("Image of the day: \(networkManagerImage.ImageData?.title ?? "loading title...")")
                                        .fontDesign(.default)
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding(5.0)
                                        .fontWeight(.bold)
                                } else {
                                    // Fallback on earlier versions
                                    Text("Image of the day: \(networkManagerImage.ImageData?.title ?? "loading title...")")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding(5.0)
                                        .fontWeight(.bold)
                                }
                                
                                if #available(iOS 16.1, *) {
                                    Text(networkManagerImage.ImageData?.explanation ?? "loading explanation..")
                                        .fontDesign(.default)
                                        .foregroundColor(.white)
                                        .minimumScaleFactor(10)
                                        .bold()
                                        //.padding()
                                } else {
                                    // Fallback on earlier versions
                                    Text(networkManagerImage.ImageData?.explanation ?? "loading explanation..")
                                        .foregroundColor(.white)
                                        .minimumScaleFactor(10)
                                        .bold()
                                    
                                }
                            }
                            .padding(30)
                        }
                        .navigationTitle("home page")
                    }
                    //.padding(12)
                    
                    ZStack {

                        SwiftUI.Image("marsButton")
                            .resizable()
                            .cornerRadius(35)
                            .shadow(radius: 10)
                        
                        NavigationLink(destination: MarsPicker()){
                            
                            VStack {
                                
                                if #available(iOS 16.1, *) {
                                    Text("Mars Exploration")
                                        .fontDesign(.default)
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                } else {
                                    // Fallback on earlier versions
                                    Text("Mars Exploration")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                }
                                
                                if #available(iOS 16.1, *) {
                                    Text("Have you ever wondered what was going on in Mars at a certain day? Look up any Earth day to see what was happening up there!")
                                        .fontDesign(.default)
                                        .foregroundColor(.white)
                                        .bold()
                                        .padding()
                                } else {
                                    // Fallback on earlier versions
                                    Text("Have you ever wondered what was going on in Mars at a certain day? Look up any Earth day to see what was happening up there!")
                                        .foregroundColor(.white)
                                        .bold()
                                        .padding()
                                }

                            }
                        }
                    }
                    //.padding(12)
                }
                .padding(30)
            }
        }
        .onAppear {
            self.networkManagerImage.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
