//
//  AnimationsView.swift
//  swiftData1229
//
//  Created by imac-2627 on 2023/12/29.
//

import SwiftUI

// 垂直選擇器視圖，用於在界面上選擇不同的動畫模式
struct AnimationSelectorVertical: View {
    //@AppStorage 屬性包裝器來無縫儲存和檢索選定的動畫模式值
    @AppStorage("animationModeKey") private var animationsMode: AnimationMode = .enabled
    //@Environment(\.colorScheme) 存取目前的配色方案，用於適應深色模式或淺色模式
    @Environment(\.colorScheme) var colorScheme
    let color = Color.indigo  // 預設的顏色設定為靛藍色
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {    // 垂直堆疊容器，內部元素間距為0
                                  // 迭代動畫模式的所有案例，為每個案例創建一個按鈕
                ForEach(AnimationMode.allCases.indices, id: \.self) { index in
                    let mode = AnimationMode.allCases[index]  // 目前迭代到的動畫模式
                    let makeDivider = index < AnimationMode.allCases.count - 1  // 判斷是否需要在按鈕間顯示分隔線
                    
                    Button {
                        animationsMode = mode  // 當按鈕被按下時，設定當前的動畫模式
                    } label: {
                        HStack(spacing: 7) {  // 水平堆疊容器，內部元素間距為7
                            Image(systemName: mode.imageName)  // 顯示與動畫模式相關聯的圖標
                                .font(.title2)
                            
                            Text(mode.title)        // 顯示動畫模式的標題
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity)  // 按鈕水平填滿可用空間
                        .padding(8)
                        .padding(.vertical, 13)
                        .contentShape(Rectangle())  // 設定按鈕的點擊區域為矩形
                    }
                    .buttonStyle(BouncyButton())    // 應用自定義的按鈕風格
                    
                    // 根據需要在按鈕之間添加分隔線
                    if makeDivider {
                        //確保只有在這兩個條件都不成立時（也就是說，當前和下一個索引都不是選中的動畫模式），才會添加分隔線。
                        if !(index == animationsMode.rawValue || (index + 1) == animationsMode.rawValue) {
                            Divider()
                                .frame(width: 310, height: 0)     // 設定分隔線的寬度和高度
                                                               // 分隔線出現和消失的動畫效果
                                .transition(.asymmetric(insertion:
                                        //insertion: 視圖加入到界面中時的過渡效果。
                                        .opacity.animation(.linear(duration: 0.1).delay(0.15)),
                                        //removal: 視圖從界面上移除時的過渡效果。
                                        removal:.opacity.animation(.linear(duration: 0.1))))
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)  // 設定最大寬度以填滿水平空間
            .padding(.horizontal, 2)  // 水平內邊距
            .background {  // 設定背景
                GeometryReader { proxy in
                    let caseCount = AnimationMode.allCases.count  // 獲取動畫模式的總數
                    color.opacity(0.1)  // 背景色的透明度
                        .clipShape(RoundedRectangle(cornerRadius: 10))  // 背景色的形狀
                        .frame(height: proxy.size.height / CGFloat(caseCount))  // 根據動畫模式的選擇調整背景色的高度
                                                                                // 根據選定的動畫模式垂直偏移背景色
                        .offset(y: proxy.size.height / CGFloat(caseCount) * CGFloat(animationsMode.rawValue))
                }
            }
            .padding(12)  // 內邊距
            .background {  // 設定背景
                Color(.systemBackground)  // 使用系統背景顏色
                    .opacity(0.6)  // 背景顏色的透明度
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))  // 背景色的形狀
                                                                                // 為背景色添加外框
                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.primary.opacity(colorScheme == .dark ? 0.15 : 0.08), lineWidth: 1.2))
            }
            .padding(.horizontal, 25)  // 水平內邊距
                                    // 指定動畫變化時應用的動畫效果
            .animation(.smooth, value: animationsMode)
        }
    }
}

#Preview() {
    AnimationSelectorVertical()
}
