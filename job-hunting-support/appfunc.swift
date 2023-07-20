//
//  appfunc.swift
//  job-hunting-support
//
//  Created by ibu.m on 2023/06/22
//
//

import Foundation

//ユーザー情報
struct user: Identifiable, Equatable, Decodable{
    var id = UUID() //ID(作成する場合としない場合でイニシャライザを分ける)
    var name: String?   //名前
    var password: String    //パスワード
    var sex: String  //性別
    var age: Int    //年齢
    var graduation_year: Date //卒業年度

    init(name: String, password: String, sex: String, age: Int, graduate: Date = Date()) {
        self.id = UUID()
        self.name = name
        self.password = password
        self.sex = sex
        self.age = age
        self.graduation_year = graduate
    }
    
    init(id: UUID, name: String, password: String, sex: String, age: Int, graduate: Date) {
        self.id = id
        self.name = name
        self.password = password
        self.sex = sex
        self.age = age
        self.graduation_year = graduate
    }
}

//業種
struct industry: Identifiable, Equatable, Hashable, Decodable{
    var id = UUID() //ID
    var name: String //業種

    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
//職種
struct occupation: Identifiable, Equatable, Hashable, Decodable{
    var id = UUID() //id
    var name: String // 職種

    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

//企業情報
struct corporate_info: Identifiable, Equatable, Decodable{
    var id : UUID //UUID(作成する場合としない場合でイニシャライザを分ける必要あり)
    var user_info: UUID //作成したユーザーのid
    var name: String //企業名
    var industry: UUID //業種のid
    var occupation: UUID //職種のid
    var business: String //事業内容
    var establishment: Date //設立日
    var employees: Int //従業員数
    var capital: Int //資本金
    var sales: Int //売上高
    var operating_income:Int //営業利益
    var representative: String //代表者
    var location: String //所在地
    var registration: Date //登録日
    var memo: String //メモ
    
    init(id: UUID, user: UUID, name: String, Industry: UUID, Occupation: UUID, business: String, establishment: Date, employees: Int, capital: Int, sales: Int, operating_income: Int, representative: String, location: String, registration: Date, memo: String) {
        self.id = id
        self.user_info = user
        self.name = name
        self.industry = Industry
        self.occupation = Occupation
        self.business = business
        self.establishment = establishment
        self.employees = employees
        self.capital = capital
        self.sales = sales
        self.operating_income = operating_income
        self.representative = representative
        self.location = location
        self.registration = registration
        self.memo = memo
    }
    init(user: UUID, name: String, Industry: UUID, Occupation: UUID, business: String, establishment: Date, employees: Int, capital: Int, sales: Int, operating_income: Int, representative: String, location: String, registration: Date, memo: String) {
        self.id = UUID()
        self.user_info = user
        self.name = name
        self.industry = Industry
        self.occupation = Occupation
        self.business = business
        self.establishment = establishment
        self.employees = employees
        self.capital = capital
        self.sales = sales
        self.operating_income = operating_income
        self.representative = representative
        self.location = location
        self.registration = registration
        self.memo = memo
    }
}

//インターン情報
struct internship_info: Identifiable, Equatable, Decodable{
    var id = UUID() //ID
    var user_info: UUID //ユーザーのid
    var corporate_info: UUID //企業のid
    var start: Date //いつから
    var end: Date //いつまで
    var memo: String?   //メモ

    init(id: UUID = UUID(), user: UUID, company: UUID, start:Date, end:Date, memo: String){
        self.id = id
        self.user_info = user
        self.corporate_info = company
        self.start = start
        self.end = end
        self.memo = memo
    }

    init(user: UUID, company: UUID, start:Date, end:Date, memo: String){
        self.id = UUID()
        self.user_info = user
        self.corporate_info = company
        self.start = start
        self.end = end
        self.memo = memo
    }
}

//本選考
struct Selection: Identifiable, Equatable, Decodable{
    var id = UUID() //ID
    var user_info: UUID //ユーザーのid
    var corporate_info: UUID //企業のid
    var result: String //合否結果
    var memo: String? //メモ

    init(id: UUID = UUID(), user: UUID, company: UUID, result: String, memo: String){
        self.id = id
        self.user_info = user
        self.corporate_info = company
        self.result = result
        self.memo = memo
    }

    init(user: UUID, company: UUID, result: String, memo: String){
        self.id = UUID()
        self.user_info = user
        self.corporate_info = company
        self.result = result
        self.memo = memo
    }
}

//スケジュールカテゴリ
struct Category: Identifiable, Equatable, Decodable{
    var id = UUID() //ID
    var name: String //カテゴリー

    init(id: UUID = UUID(), category: String){
        self.id = id
        self.name = category
    }
}
//スケジュール
struct Schedule: Identifiable, Equatable, Decodable{
    var id = UUID() //ID
    var title: String //スケジュール名
    var schedule_category: UUID //カテゴリのid
    var internship_info: UUID //インターンのid
    var corporate_info : UUID //企業のid
    var start: Date //いつから
    var end: Date //いつまで
    var memo: String? //メモ

    init(id: UUID = UUID(), name: String, category: UUID, intern: UUID, company:UUID, begin: Date, end: Date, memo: String){
        self.id = id
        self.title = name
        self.schedule_category = category
        self.internship_info = intern
        self.corporate_info = company
        self.start = begin
        self.end = end
        self.memo = memo
    }

    init(name: String, category: UUID, intern: UUID, company:UUID, begin: Date, end: Date, memo: String){
        self.id = UUID()
        self.title = name
        self.schedule_category = category
        self.internship_info = intern
        self.corporate_info = company
        self.start = begin
        self.end = end
        self.memo = memo
    }
}
