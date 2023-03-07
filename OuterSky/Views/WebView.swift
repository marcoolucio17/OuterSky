//
//  DayImage.swift
//  OuterSky
//
//  Created by Marco Lucio Sosa on 2/10/23.
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    // Protocol UIVIewRepresnetable is used in order for the view to be shown in swiftUI
    
    let urlString: String?
    
    // Creates a blank web view object
    func makeUIView(context: Context) -> WebView.UIViewType {
        return WKWebView()
    }
    // Loads web information into the web view.
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // if there's a string..
        if let safeString = urlString {
            // if the url is valid..
            if let url = URL(string: safeString){
                // Creates a URLRequest with passed url and loads web information.
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}
