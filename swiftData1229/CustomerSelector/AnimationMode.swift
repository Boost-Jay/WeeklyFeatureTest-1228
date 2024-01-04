//
//  AnimationMode.swift
//  swiftData1229
//
//  Created by imac-2627 on 2023/12/29.
//

import SwiftUI

enum AnimationMode: Int, CaseIterable {
    case enabled
    case reduced
    case disabled
    case extra
    
    //圖示
    var imageName: String {
        switch self {
            case .disabled:
                return "figure.stand"
            case .reduced:
                return "figure.walk"
            case .enabled:
                return "figure.run"
                
            case .extra:
                return "cube"
        }}
    
    //標題
    var title: String {
        switch self {
            case .disabled:
                return "Disabled"
            case .reduced:
                return "Reduced"
            case .enabled:
                return "Enabled"
                
            case .extra:
                return "Extra"
        }
    }
}

// 動畫視圖定義
struct AnimationsView: View {
    @AppStorage("animationModeKey") private var animationsMode: AnimationMode = .enabled // 使用AppStorage保存動畫模式
    @Environment(\.colorScheme) var colorScheme  // 讀取系統配色方案
    let color = Color.indigo  // 定義顏色為靛藍色
    var body: some View {
        VStack {
            HStack(spacing: 0) {  // 水平堆疊，間距為0
                                  // 對所有動畫模式進行迭代，創建按鈕
                ForEach(AnimationMode.allCases.indices, id: \.self) { index in
                    let mode = AnimationMode.allCases[index]  // 獲取當前的動畫模式
                    let makeDivider = index < AnimationMode.allCases.count - 1  // 判斷是否需要分隔符
                    
                    Button {
                        animationsMode = mode  // 設置當前的動畫模式
                    } label: {
                        VStack(spacing: 7) {  // 垂直堆疊，間距為7
                            Image(systemName: mode.imageName)  // 顯示圖示
                                .font(.title2)
                            
                            Text(mode.title)  // 顯示標題
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity)  // 框架最大寬度 = 無限寬度
                        .padding(8)
                        .padding(.vertical, 13)
                        
                        .contentShape(Rectangle())  // 內容形狀為矩形
                    }
                    .buttonStyle(BouncyButton())  // 應用按鈕風格
                    
                    // 如果需要分隔符，則添加
                    if makeDivider {
                        if !(index == animationsMode.rawValue || (index + 1) == animationsMode.rawValue) {
                            Divider()
                                .frame(width: 0, height: 55)  // 分隔符框架設定
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)  // 框架最大寬度
            .padding(.horizontal, 2)
            .background {  // 背景
                GeometryReader { proxy in
                    let caseCount = AnimationMode.allCases.count
                    color.opacity(0.1)  // 背景顏色透明度
                        .clipShape(RoundedRectangle(cornerRadius: 10))  // 剪裁形狀為圓角矩形
                        .frame(width: proxy.size.width / CGFloat(caseCount))  // 框架寬度
                        .offset(x: proxy.size.width / CGFloat(caseCount) * CGFloat(animationsMode.rawValue))  // 偏移量
                }
            }
            
            .padding(12)
            .background {                   // 背景
                Color(.systemBackground)     // 系統背景色
                    .opacity(0.6)          // 透明度
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))  // 剪裁形狀
                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.primary.opacity(colorScheme == .dark ? 0.15 : 0.08), lineWidth: 1.2))  // 外框
                
            }
            .padding(.horizontal, 25)  // 水平內邊距
            .animation(.smooth, value: animationsMode)  // 動畫效果
        }
    }
}

// 定義彈跳按鈕的風格
struct BouncyButton: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .scaleEffect(x: configuration.isPressed ? 0.95 : 1.0, y: configuration.isPressed ? 0.9 : 1.0)  // 縮放效果
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)        // 動畫效果
                                                                                 //添加閃爍效果，按下時透明度為0.5，否則為1
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

