//
//  HstackDemo.swift
//  swiftData1229
//
//  Created by imac-2627 on 2023/12/29.
//

import SwiftUI

struct HstackDemo: View {
    var body: some View {
        HStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            //使用 spacer 來填滿水平方向的空間。
//            Spacer()
            Text("Hello, DevTechie!")
                .font(.largeTitle)
        }
        .padding()
        //使用 frame 修飾符來定義 maxWidth 為 HStack 填滿水平空間
        .frame(maxWidth: .infinity)
        .border(.red)
    }
}

#Preview("Dark Scheme") {
    HstackDemo()
        .preferredColorScheme(.dark)
}

