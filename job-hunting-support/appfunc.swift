//
//  appfunc.swift
//  job-hunting-support
//  
//  Created by ibu.m on 2023/06/22
//  
//

import Foundation

//ユーザー情報
struct User: Identifiable, Equatable{
    var id = UUID() //ID
    var name: String?   //名前
    var password: String    //パスワード
    var gender: String  //性別
    var age: Int    //年齢
    var graduate: Date //卒業年度

    init(id: UUID = UUID(), name: String? = nil, password: String, gender: String, age: Int, graduate: Date) {
        self.id = id
        self.name = name
        self.password = password
        self.gender = gender
        self.age = age
        self.graduate = graduate
    }
}

//業種
struct Industry: Identifiable, Equatable{
    var id = UUID() //ID
    var type_of_industry: String //業種

    init(id: UUID = UUID(), type_of_industry: String) {
        self.id = id
        self.type_of_industry = type_of_industry
    }
}
//職種
struct Occupation: Identifiable, Equatable{
    var id = UUID() //id
    var occupation: String // 職種

    init(id: UUID = UUID(), occupation: String) {
        self.id = id
        self.occupation = occupation
    }
}

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

//インターン情報
struct Intern: Identifiable, Equatable{
    var id = UUID() //ID
    var user: User //ユーザー情報
    var company: Company //企業情報
    var term: Date  //期間
    var memo: String?   //メモ

    init(id: UUID = UUID(), user: User, company: Company, term: Date){
        self.id = id
        self.user = user
        self.company = company
        self.term = term
        self.memo = ""
    }

    init(id: UUID = UUID(), user: User, company: Company, term: Date, memo: String){
        self.id = id
        self.user = user
        self.company = company
        self.term = term
        self.memo = memo
    }
}

//本選考
struct Selection: Identifiable, Equatable{
    var id = UUID() //ID
    var user: User //ユーザー情報
    var company: Company //企業情報
    var result: String //合否結果
    var memo: String? //メモ

    init(id: UUID = UUID(), user: User, company: Company, result: String){
        self.id = id
        self.user = user
        self.company = company
        self.result = result
        self.memo = ""
    }

    init(id: UUID = UUID(), user: User, company: Company, result: String, memo: String){
        self.id = id
        self.user = user
        self.company = company
        self.result = result
        self.memo = memo
    }
}

//スケジュールカテゴリ
struct Category: Identifiable, Equatable{
    var id = UUID() //ID
    var category: String //カテゴリー

    init(id: UUID = UUID(), category: String){
        self.id = id
        self.category = category
    }
}
//スケジュール
struct Schedule: Identifiable, Equatable{
    var id = UUID() //ID
    var name: String //スケジュール名
    var category: Category //カテゴリー名
    var intern: Intern //インターン情報
    var company : Company //企業情報
    var begin: Date //いつから
    var end: Date //いつまで
    var memo: String? //メモ

    init(id: UUID = UUID(), name: String, category: Category, intern: Intern, company:Company, begin: Date, end: Date){
        self.id = id
        self.name = name
        self.category = category
        self.intern = intern
        self.company = company
        self.begin = begin
        self.end = end
        self.memo = ""
    }

    init(id: UUID = UUID(), name: String, category: Category, intern: Intern, company:Company, begin: Date, end: Date, memo: String){
        self.id = id
        self.name = name
        self.category = category
        self.intern = intern
        self.company = company
        self.begin = begin
        self.end = end
        self.memo = memo
    }
}
