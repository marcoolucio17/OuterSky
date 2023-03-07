//
//  MarsPicker.swift
//  OuterSky
//
//  Created by Marco Lucio Sosa on 2/10/23.
//

import Foundation
import SwiftUI

struct MarsPicker: View {
    
    init() {
            //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color(.systemGray))]
            
        UIDatePicker.appearance().preferredDatePickerStyle = .compact

        }
 
    @Namespace var namespace
    @State private var selectedDate: Date = Date()
    @ObservedObject var networkManagerMars = NetworkManagerMars()
    @State private var showDetail = false
    @State private var isLoading = false
    @State private var isAlert = false
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2015, month: 1, day: 1)
        let endComponents = DateComponents(year: 2022, month: 1, day: 1)
        return calendar.date(from: startComponents)!
                ...
                calendar.date(from: endComponents)!
    }()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(.systemFill))
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(.systemBackground))
                            .cornerRadius(20)
                            //.padding(.top)
                       
                        GeometryReader { geo in
                            DatePicker("Select a date:", selection: $selectedDate, in: dateRange, displayedComponents: [.date])
                                .datePickerStyle(.graphical)
                                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                            
                        }
                        .padding()
                        
                    }
                    ZStack {
                        Rectangle()
                            .frame(width: 80, height: 40)
                            .foregroundColor(Color(.secondarySystemFill))
                            .cornerRadius(10)
                            .shadow(radius: 20)
                        if #available(iOS 16.1, *) {
                            Text("save")
                                .foregroundColor(Color(.systemBlue))
                                .fontDesign(.rounded)
                                .fontWeight(.medium)
                        } else {
                            // Fallback on earlier versions
                            Text("save")
                                .foregroundColor(Color(.systemBlue))
                                .fontWeight(.heavy)
                                
                                
                        }
                    }
                    .onTapGesture {
                        networkManagerMars.fetchData(date: selectedDate)
                        isAlert.toggle()
                    }
                    .padding(.bottom, 25)
                    
                        .alert(isPresented: $isAlert) {
                            
                            Alert(title: Text("Information saved!"))
                        }
                    
                    NavigationLink(destination: ImageView(desiredURL: networkManagerMars)) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color(.tertiarySystemFill))
                                .frame(width: 350.0, height: 60.0)
                                .cornerRadius(30)
                                .shadow(radius: 15)
                            Text("Search Selected Date")
                                .foregroundColor(Color(.systemBlue))
                                .fontWeight(.bold)
                        }
                    } .padding(.vertical, 40)
                }
                .padding(40)
                
            }
            .navigationTitle("Date Selection")
        }
    }
}



struct MarsView_Previews: PreviewProvider {
    var exampledNetwor = NetworkManagerImage()
    static var previews: some View {
        MarsPicker()
    }
}
  
