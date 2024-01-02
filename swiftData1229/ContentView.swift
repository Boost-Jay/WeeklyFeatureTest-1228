//
//  ContentView.swift
//  swiftData1229
//
//  Created by imac-2627 on 2023/12/29.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
//    @Query private var dataModel: [DataModel]
    
    //根據優先順序對清單中的資料進行排序
//    @Query(sort: \DataModel.priority)
//    private var dataModel: [DataModel]
    
    //濾掉小於 50 的優先權（因此僅保留高於 50 的優先權）
//    @Query(filter: #Predicate<DataModel> {$0.priority > 50})
//    private var dataModel: [DataModel]
    
    //僅保留小於 65 的優先級，然後我們根據任務名稱（或 DataModel 範例中的文字）對這些優先級進行排序，並明確指出順序應該向前。
    @Query(
        filter: #Predicate<DataModel> {
            $0.priority < 65
        },
        sort: \DataModel.text,
        order: .forward
    )
    private var dataModel: [DataModel]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Add Items", systemImage: "plus") {
                    //新增10個隨機的資料模型
                    for _ in 1...10 {
                        let newDataToAdd = DataModel(
                            text: "Task \(Int.random(in: 0...10))",
                            priority: Int.random(in: 0...100)
                        )
                        modelContext.insert(newDataToAdd)
                    }
                }
                
            }
            Text("Hi")
                .frame(width: 100,height: 100)
            
            List(dataModel) { item in
                HStack {
                    Text(item.text)
                    Spacer()
                    Text(item.priority, format: .number)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        //使用 inMemory: true 來在記憶體中創建資料庫
        .modelContainer(for: DataModel.self, inMemory: true)
}
