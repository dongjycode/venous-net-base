//
//  File.swift
//  
//
//  Created by jdq on 2022/9/13.
//

import Foundation

struct ActivateNetAuth {
    /// 激活网络权限
    public static func active() {
        if let url = URL(string: "http://www.baidu.com") {
            URLSession.shared.dataTask(with: url).resume()
        }
    }
}
