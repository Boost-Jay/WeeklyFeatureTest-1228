//
//  DataModel.swift
//  swiftData1229
//
//  Created by imac-2627 on 2023/12/29.
//

//  DataModel.swift
import Foundation
import SwiftData

//這將是 SwiftData 資料庫中的一個表。
@Model
class DataModel {
    //我們可以使用 @Attribute 屬性包裝器將屬性添加到資料庫的字段中
    //這裡的 .unique 選項告訴我們的資料庫，此列保證是唯一的
    @Attribute(.unique) private(set) var id = UUID()
    private(set) var text: String
    private(set) var priority: Int
    
    init(text: String, priority: Int) {
        self.text = text
        self.priority = priority
    }
}
