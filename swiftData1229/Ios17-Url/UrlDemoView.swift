//
//  UrlDemoView.swift
//  swiftData1229
//
//  Created by imac-2627 on 2023/12/29.
//

import SwiftUI
//蘋果的URL解析實現了RFC1738/1808標準，從iOS 17開始改為RFC3986
struct URLDemoView: View {
    @State private var textInput: String = ""
    @State private var parsedURL: URL?
    @State private var ios17URL: URL?
    
    var body: some View {
        VStack {
            TextField("Enter a URL", text: $textInput)
                .padding()
                .border(Color.gray)
            
            Button("Parse URL") {
                parseURL()
            }
            .padding()
            
            Text("iOS 17 URL: \(parsedURL?.absoluteString ?? "Invalid")")
            Text("Old reverse: \(ios17URL?.absoluteString ?? "Invalid")")
        }
        .padding()
    }
    
    private func parseURL() {
        //新的 iOS 17 URL回傳內容
        //可以將連結與搜尋字串等結合起來，並且放心它可以工作，即使在帶有空格和西里爾字母的情況下也是如此
        // "https://google.com/клята русня"    ->
        //https://google.com/%D0%BA%D0%BB%D1%8F%D1%82%D0%B0%20%D1%80%D1%83%D1%81%D0%BD%D1%8F
        //(把空格和特殊字母用編碼取代)
        parsedURL = URL(string: textInput)
        // iOS 17 URL 回到 iOS 16 以前的方法
        ios17URL = URL(string: textInput, encodingInvalidCharacters: false)  // => nil
        // "https://google.com/клята русня"    -> nil
    }
}

#Preview() {
    URLDemoView()
}

