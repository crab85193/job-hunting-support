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
    let id: String //ID(作成する場合としない場合でイニシャライザを分ける)
    let name: String   //名前
    let password: String    //パスワード
    let sex: String  //性別
    let age: String    //年齢 ->intへ変換する必要あり
    let graduation_year: String //卒業年度　->Dateへ変換する必要あり

    init(name: String, password: String, sex: String, age: String, graduate: String) {
        self.id = UUID().uuidString
        self.name = name
        self.password = password
        self.sex = sex
        self.age = age
        self.graduation_year = graduate
    }
    
    init(id: String, name: String, password: String, sex: String, age: String, graduate: String) {
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
    let id: String //ID
    let name: String //業種

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    init(name: String){
        self.id = UUID().uuidString
        self.name = name
    }
    
}
//職種
struct occupation: Identifiable, Equatable, Hashable, Decodable{
    let id: String //id
    var name: String // 職種

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    init(name: String){
        self.id = UUID().uuidString
        self.name = name
    }
}

//企業情報
struct corporate_info: Identifiable, Equatable, Decodable{
    let id : String //ID(作成する場合としない場合でイニシャライザを分ける必要あり)
    let user_info: String //作成したユーザーのid
    var name: String //企業名
    var industry: String //業種のid
    var occupation: String //職種のid
    var business: String //事業内容
    var establishment: String //設立日 ->Dateへ変換する必要あり
    var employees: String //従業員数 ->intへ変換する必要あり
    var capital: String //資本金 ->intへ変換する必要あり
    var sales: String //売上高 ->intへ変換する必要あり
    var operating_income: String //営業利益 ->intへ変換する必要あり
    var representative: String //代表者
    var location: String //所在地
    let registration: String //登録日 ->Dateへ変換する必要あり
    var memo: String //メモ
    
    init(id: String, user: String, name: String, Industry: String, Occupation: String, business: String, establishment: String, employees: String, capital: String, sales: String, operating_income: String, representative: String, location: String, registration: String, memo: String) {
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
    init(user: String, name: String, Industry: String, Occupation: String, business: String, establishment: String, employees: String, capital: String, sales: String, operating_income: String, representative: String, location: String, registration: String, memo: String) {
        self.id = UUID().uuidString
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
    let id: String //ID
    let user_info: String//ユーザーのid
    let corporate_info: String //企業のid
    let start: String //いつから ->Dateへ変換する必要あり
    let end: String //いつまで ->Dateへ変換する必要あり
    let memo: String   //メモ

    init(id: String, user: String, company: String, start:String, end:String, memo: String){
        self.id = id
        self.user_info = user
        self.corporate_info = company
        self.start = start
        self.end = end
        self.memo = memo
    }

    init(user: String, company: String, start:String, end:String, memo: String){
        self.id = UUID().uuidString
        self.user_info = user
        self.corporate_info = company
        self.start = start
        self.end = end
        self.memo = memo
    }
}

//本選考
struct Selection: Identifiable, Equatable, Decodable{
    let id: String //ID
    let user_info: String //ユーザーのid
    let corporate_info: String //企業のid
    let result: String //合否結果
    let memo: String //メモ

    init(id: String, user: String, company: String, result: String, memo: String){
        self.id = id
        self.user_info = user
        self.corporate_info = company
        self.result = result
        self.memo = memo
    }

    init(user: String, company: String, result: String, memo: String){
        self.id = UUID().uuidString
        self.user_info = user
        self.corporate_info = company
        self.result = result
        self.memo = memo
    }
}

//スケジュールカテゴリ
struct Category: Identifiable, Equatable, Decodable{
    let id: String //ID
    let name: String //カテゴリー

    init(id: String, category: String){
        self.id = id
        self.name = category
    }
}
//スケジュール
struct Schedule: Identifiable, Equatable, Decodable{
    let id: String //ID
    let title: String //スケジュール名
    let schedule_category: String //カテゴリのid
    let internship_info: String //インターンのid
    let corporate_info : String //企業のid
    let start: String //いつから ->Dateへ変換する必要あり
    let end: String //いつまで ->Dateへ変換する必要あり
    let memo: String //メモ

    init(id: String, name: String, category: String, intern: String, company:String, begin: String, end: String, memo: String){
        self.id = id
        self.title = name
        self.schedule_category = category
        self.internship_info = intern
        self.corporate_info = company
        self.start = begin
        self.end = end
        self.memo = memo
    }

    init(name: String, category: String, intern: String, company:String, begin: String, end: String, memo: String){
        self.id = UUID().uuidString
        self.title = name
        self.schedule_category = category
        self.internship_info = intern
        self.corporate_info = company
        self.start = begin
        self.end = end
        self.memo = memo
    }
}


//testclass
struct Comments: Codable, Identifiable {
    let id: String
    let name: String
    let password: String
    let sex: String
    let age: String
    let graduation_year: String

}

class apiCall {
    func getUserComments(completion:@escaping ([Comments]) -> ()) {
//        guard let url = URL(string: "http://10.0.4.175/api/select-user.php?id="+"2") else { return }
        guard let url = URL(string: "http://10.0.4.175/api/select-user.php") else { return }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let comments = try! JSONDecoder().decode([Comments].self, from: data!)
            print(comments)

            DispatchQueue.main.async {
                
                completion(comments)
            }
        }
        .resume()
        
    }
}
