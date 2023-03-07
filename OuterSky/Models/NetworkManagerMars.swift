//
//  NetworkManagerMars.swift
//  OuterSky
//
//  Created by Marco Lucio Sosa on 2/10/23.
//

import Foundation
import SwiftUI

class NetworkManagerMars: ObservableObject {
    
    @Published var images = [MarsPhoto]()
    @Published var strungSelectedDate = " "
    
    func fetchData(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        strungSelectedDate = formattedDate
        
        self.images = []
        
        if let firstUrlString = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=\(formattedDate)&api_key=gqR30fI23A1mLV0hbixUMlHqx6gnYSTHVoxxkKvn"){
            print(formattedDate)
            print(firstUrlString)
            let marsSession = URLSession(configuration: .default)
            let marsTask = marsSession.dataTask(with: firstUrlString) {data, response, error in
                
                if error == nil {
                    let marsDecoder = JSONDecoder()
                    
                    if let marsSafeData = data {
                        do {
                            let marsResults = try marsDecoder.decode(PhotosResponse.self, from: marsSafeData)
                            DispatchQueue.main.async {
                                self.images = marsResults.photos
                                print(self.images.first?.img_src ?? "failed")
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            marsTask.resume()
        }
    }
    
    func fetchData() {
        strungSelectedDate = "2018-11-28"
        if let firstUrlString = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2018-11-28&api_key=gqR30fI23A1mLV0hbixUMlHqx6gnYSTHVoxxkKvn"){
            print(firstUrlString)
            let marsSession = URLSession(configuration: .default)
            let marsTask = marsSession.dataTask(with: firstUrlString) {data, response, error in
                
                if error == nil {
                    let marsDecoder = JSONDecoder()
                    
                    if let marsSafeData = data {
                        do {
                            let marsResults = try marsDecoder.decode(PhotosResponse.self, from: marsSafeData)
                            DispatchQueue.main.async {
                                self.images = marsResults.photos
                            }
                            print(self.images.first?.img_src ?? "failed")
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            marsTask.resume()
        }
    }
    
    func getDesiredUrl() -> String {
        if let someURL = self.images.first?.img_src {
            return someURL
        } else {
            return "https://google.com"
        }
    }
    
    func getDays() -> Bool {
        
        return true
    }
}

