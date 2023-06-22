//
//  appfunc.swift
//  job-hunting-support
//  
//  Created by ibu.m on 2023/06/22
//  
//

import Foundation

//企業情報
struct Company: Identifiable, Equatable{
    var id = UUID()
    var name: String = ""
    var industry: String = ""
    var employees: Int = 0
    
    init(id: UUID = UUID(), name: String, industry: String, employees: Int) {
        self.id = id
        self.name = name
        self.industry = industry
        self.employees = employees
    }
}
