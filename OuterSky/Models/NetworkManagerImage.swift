//
//  NetworkManager.swift
//  OuterSky
//
//  Created by Marco Lucio Sosa on 2/10/23.
//

import Foundation
import SwiftUI
import Combine

class NetworkManagerImage: ObservableObject {
    
    @Published var ImageData: Image?
    
    func fetchData() {
        
        if let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=gqR30fI23A1mLV0hbixUMlHqx6gnYSTHVoxxkKvn"){
            let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { data, response, error in
                    if error == nil {
                        if let safeData = data {
                            // print(String(data: safeData, encoding: .utf8)!)
                            let decoder = JSONDecoder()
                            do {
                                let results = try decoder.decode(Image.self, from: safeData)
                                // print(results)
                                DispatchQueue.main.async {
                                    self.ImageData = results
                                }
                                
                            } catch {
                                print(error)
                            }
                        }
                        print("No data received")
                    }
                }
            task.resume()
        }
    }
}
