//
//  appfunc.swift
//  job-hunting-support
//
//  Created by ibu.m on 2023/06/22
//
//

import Foundation

//ユーザー情報
struct User: Identifiable, Equatable, Codable{
    let id: String //ID(作成する場合としない場合でイニシャライザを分ける)
    var name: String   //名前
    var password: String    //パスワード
    var sex: String  //性別
    var age: String    //年齢 ->intへ変換する必要あり
    var graduation_year: String //卒業年度　->Dateへ変換する必要あり

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
struct Industry: Identifiable, Equatable, Hashable, Codable{
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
struct Occupation: Identifiable, Equatable, Hashable, Codable{
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
struct Corporate_info: Identifiable, Equatable, Codable{
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
struct Internship_info: Identifiable, Equatable, Codable{
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
struct Selection: Identifiable, Equatable, Codable{
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
struct Category: Identifiable, Equatable, Codable{
    let id: String //ID
    let name: String //カテゴリー

    init(id: String, category: String){
        self.id = id
        self.name = category
    }
}
//スケジュール
struct Schedule: Identifiable, Equatable, Codable{
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

//以降サーバとの通信関連

//追加時等の反応
struct Response: Codable {
    let status: String
    let table: String
}
//サーバ通信用の関数をまとめたクラス
class apiCall {
    /*-------------------------------------------------------------
     Test Class
     -------------------------------------------------------------*/
    //testclass(Comments)の情報をサーバからすべて取得するメソッド
    func getUserComments(completion:@escaping ([Comments]) -> ()) {
//        guard let url = URL(string: "http://10.0.4.175/api/select-user.php?id="+"2") else { return }
        guard let url = URL(string: "http://job-app.st.ie.u-ryukyu.ac.jp/user/select.php") else { print("Error")
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let comments = try! JSONDecoder().decode([Comments].self, from: data!)
            print(comments)

            DispatchQueue.main.async {
                
                completion(comments)
            }
        }
        .resume()
        
    }
    
    /*-------------------------------------------------------------
     Industry
      - select
     -------------------------------------------------------------*/
    //職種(industry)の情報をサーバからすべて取得するメソッド
    func getIndustry(completion:@escaping ([Industry]) -> ()) {
//        guard let url = URL(string: "http://10.0.4.175/api/select-user.php?id="+"2") else { return }
        guard let url = URL(string: "http://job-app.st.ie.u-ryukyu.ac.jp/industry/select.php") else { print("Error")
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let industries = try! JSONDecoder().decode([Industry].self, from: data!)
            print(industries)

            DispatchQueue.main.async {
                
                completion(industries)
            }
        }
        .resume()
    }
    
    /*-------------------------------------------------------------
     Occupation
      - select
     -------------------------------------------------------------*/
    //業種(occupation)の情報をサーバからすべて取得するメソッド
    func getOccupation(completion:@escaping ([Occupation]) -> ()) {
//        guard let url = URL(string: "http://10.0.4.175/api/select-user.php?id="+"2") else { return }
        guard let url = URL(string: "http://job-app.st.ie.u-ryukyu.ac.jp/occupation/select.php") else { print("Error")
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let occupations = try! JSONDecoder().decode([Occupation].self, from: data!)
            print(occupations)

            DispatchQueue.main.async {
                
                completion(occupations)
            }
        }
        .resume()
    }
    
    /*-------------------------------------------------------------
     Schedule Category
      - select
     -------------------------------------------------------------*/
    //スケジュールカテゴリ(Category)の情報をサーバからすべて取得するメソッド
    func getCategory(completion:@escaping ([Category]) -> ()) {
//        guard let url = URL(string: "http://10.0.4.175/api/select-user.php?id="+"2") else { return }
        guard let url = URL(string: "http://job-app.st.ie.u-ryukyu.ac.jp/schedule_category/select.php") else { print("Error")
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let categories = try! JSONDecoder().decode([Category].self, from: data!)
            print(categories)

            DispatchQueue.main.async {
                
                completion(categories)
            }
        }
        .resume()
    }

    /*-------------------------------------------------------------
     User
      - select
      - add
      - update
     -------------------------------------------------------------*/
    //nameとpasswordからUserの情報を取得するメソッド
    func getUserFromNameAndPassword(name: String, password: String, completion: @escaping ([User]) -> Void) {
            var urlComponents = URLComponents()
            urlComponents.scheme = "http"
            urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
            urlComponents.path = "/user/select.php"
            urlComponents.queryItems = [
                URLQueryItem(name: "name", value: name),
                URLQueryItem(name: "password", value: password)
            ]

            guard let url = urlComponents.url else {
                return
            }
        print(url.absoluteString)
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                if let data = data {
                    do {
                        let decodedResponse = try JSONDecoder().decode([User].self, from: data)
                        print("success")
                        print(decodedResponse)
                        completion(decodedResponse)
                    } catch {
                        print("JSON decoding error: \(error)")
                    }
                }
            }.resume()
    }
    
    //サーバーに新規ユーザの情報を追加するメソッド
    func addUserInfotoServer(name: String, password: String, sex: String, age: String, graduate: String, completion: @escaping (String) -> Void) {
        var urlComponents = URLComponents()
                urlComponents.scheme = "http"
                urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
                urlComponents.path = "/user/add.php"
                urlComponents.queryItems = [
                    URLQueryItem(name: "name", value: name),
                    URLQueryItem(name: "password", value: password),
                    URLQueryItem(name: "sex", value: sex),
                    URLQueryItem(name: "age", value: age),
                    URLQueryItem(name: "graduation_year", value: graduate)
                ]

                guard let url = urlComponents.url else {
                    return
                }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse.status)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    //サーバーにあるユーザの情報を編集するメソッド
    func EditUserInfoinServer(id: String, name: String, password: String, sex: String, age: String, graduate: String, completion: @escaping (String) -> Void) {
        var urlComponents = URLComponents()
                urlComponents.scheme = "http"
                urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
                urlComponents.path = "/user/update.php"
                urlComponents.queryItems = [
                    URLQueryItem(name: "id", value: id),
                    URLQueryItem(name: "name", value: name),
                    URLQueryItem(name: "password", value: password),
                    URLQueryItem(name: "sex", value: sex),
                    URLQueryItem(name: "age", value: age),
                    URLQueryItem(name: "graduation_year", value: graduate)
                ]

                guard let url = urlComponents.url else {
                    return
                }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse.status)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    /*-------------------------------------------------------------
     Company Info
      - select
      - add
      - update
      - delete
     -------------------------------------------------------------*/
    //userIDをもとにそのユーザーが登録した企業データを取得するメソッド
    func getCompanyInfoFromUserID(userID: String, completion: @escaping ([Corporate_info]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
        urlComponents.path = "/corporate_info/select.php"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_info", value: userID)
        ]

        guard let url = urlComponents.url else {
            return
        }
    print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Corporate_info].self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    //サーバーに新規企業情報を追加するメソッド
    func addCompanyInfotoServer(userID: String, name: String, industry: String, occupation: String, business: String, establishment: String, employees: String, capital: String, sales: String, operating_income: String, representative: String, location: String, registration: String, memo: String, completion: @escaping (String) -> Void) {
        var urlComponents = URLComponents()
                urlComponents.scheme = "http"
                urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
                urlComponents.path = "/corporate_info/add.php"
                urlComponents.queryItems = [
                    URLQueryItem(name: "user_info", value: userID),
                    URLQueryItem(name: "name", value: name),
                    URLQueryItem(name: "industry", value: industry),
                    URLQueryItem(name: "occupation", value: occupation),
                    URLQueryItem(name: "business", value: business),
                    URLQueryItem(name: "establishment", value: establishment),
                    URLQueryItem(name: "employees", value: employees),
                    URLQueryItem(name: "capital", value: capital),
                    URLQueryItem(name: "sales", value: sales),
                    URLQueryItem(name: "operating_income", value: operating_income),
                    URLQueryItem(name: "representative", value: representative),
                    URLQueryItem(name: "location", value: location),
                    URLQueryItem(name: "registration", value: registration),
                    URLQueryItem(name: "memo", value: memo)
                ]

                guard let url = urlComponents.url else {
                    return
                }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse.status)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    //企業情報を編集するメソッド
    func editCompanyInfotoServer(id: String, userID: String, name: String, industry: String, occupation: String, business: String, establishment: String, employees: String, capital: String, sales: String, operating_income: String, representative: String, location: String, registration: String, memo: String, completion: @escaping (String) -> Void) {
        var urlComponents = URLComponents()
                urlComponents.scheme = "http"
                urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
                urlComponents.path = "/corporate_info/update.php"
                urlComponents.queryItems = [
                    URLQueryItem(name: "id", value: id),
                    URLQueryItem(name: "user_info", value: userID),
                    URLQueryItem(name: "name", value: name),
                    URLQueryItem(name: "industry", value: industry),
                    URLQueryItem(name: "occupation", value: occupation),
                    URLQueryItem(name: "business", value: business),
                    URLQueryItem(name: "establishment", value: establishment),
                    URLQueryItem(name: "employees", value: employees),
                    URLQueryItem(name: "capital", value: capital),
                    URLQueryItem(name: "sales", value: sales),
                    URLQueryItem(name: "operating_income", value: operating_income),
                    URLQueryItem(name: "representative", value: representative),
                    URLQueryItem(name: "location", value: location),
                    URLQueryItem(name: "registration", value: registration),
                    URLQueryItem(name: "memo", value: memo)
                ]

                guard let url = urlComponents.url else {
                    return
                }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse.status)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    //企業情報を削除するメソッド
    func deleteCompanyInfotoServer(id: String, completion: @escaping (String) -> Void) {
        var urlComponents = URLComponents()
                urlComponents.scheme = "http"
                urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
                urlComponents.path = "/corporate_info/delete.php"
                urlComponents.queryItems = [
                    URLQueryItem(name: "id", value: id)
                ]

                guard let url = urlComponents.url else {
                    return
                }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse.status)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    /*-------------------------------------------------------------
     Selection
      - select
      - add
      - update
      - edit
     -------------------------------------------------------------*/
    //userIDをもとにそのユーザーが登録した本選考のデータを取得するメソッド
    func getSelectionInfoFromUserID(userID: String, completion: @escaping ([Selection]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
        urlComponents.path = "/selection/select.php"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_info", value: userID)
        ]

        guard let url = urlComponents.url else {
            return
        }
    print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Selection].self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    //本選考のデータを追加するメソッド
    func addSelectionInfoFromUserID(userID: String, corporate_info: String, result: String, memo: String, completion: @escaping ([Selection]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
        urlComponents.path = "/selection/add.php"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_info", value: userID),
            URLQueryItem(name: "corporate_info", value: corporate_info),
            URLQueryItem(name: "result", value: result),
            URLQueryItem(name: "memo", value: memo)
        ]

        guard let url = urlComponents.url else {
            return
        }
    print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Selection].self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    //本選考のデータを編集するメソッド
    func editSelectionInfoFromUserID(id: String, userID: String, corporate_info: String, result: String, memo: String, completion: @escaping ([Selection]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
        urlComponents.path = "/selection/update.php"
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: id),
            URLQueryItem(name: "user_info", value: userID),
            URLQueryItem(name: "corporate_info", value: corporate_info),
            URLQueryItem(name: "result", value: result),
            URLQueryItem(name: "memo", value: memo)
        ]

        guard let url = urlComponents.url else {
            return
        }
    print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Selection].self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    //本選考のデータを削除するメソッド
    func deleteSelectionInfoFromUserID(id: String, completion: @escaping ([Selection]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
        urlComponents.path = "/selection/delete.php"
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: id)
        ]

        guard let url = urlComponents.url else {
            return
        }
    print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Selection].self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    /*-------------------------------------------------------------
     Schedule Info
      - select
      - add
      - update
      - delete
     -------------------------------------------------------------*/
    //userIDをもとにそのユーザーが登録したスケジュールのデータを取得するメソッド
    func getScheduleInfoFromUserID(userID: String, completion: @escaping ([Schedule]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
        urlComponents.path = "/schedule/select.php"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_info", value: userID)
        ]

        guard let url = urlComponents.url else {
            return
        }
    print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Schedule].self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    //スケジュールのデータを追加するメソッド
    func addScheduleInfoFromUserID(title: String, userID: String, schedule_category: String, internship_info: String, corporate_info: String, start_date: String, end_date: String, memo: String, completion: @escaping ([Schedule]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
        urlComponents.path = "/schedule/add.php"
        urlComponents.queryItems = [
            URLQueryItem(name: "title", value: title),
            URLQueryItem(name: "user_info", value: userID),
            URLQueryItem(name: "schedule_category", value: schedule_category),
            URLQueryItem(name: "internship_info", value: internship_info),
            URLQueryItem(name: "corporate_info", value: corporate_info),
            URLQueryItem(name: "start_date", value: start_date),
            URLQueryItem(name: "end_date", value: end_date),
            URLQueryItem(name: "memo", value: memo)
        ]

        guard let url = urlComponents.url else {
            return
        }
    print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Schedule].self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    //スケジュールのデータを編集するメソッド
    func editScheduleInfoFromUserID(id: String, title: String, userID: String, schedule_category: String, internship_info: String, corporate_info: String, start_date: String, end_date: String, memo: String, completion: @escaping ([Schedule]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
        urlComponents.path = "/schedule/update.php"
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: id),
            URLQueryItem(name: "title", value: title),
            URLQueryItem(name: "user_info", value: userID),
            URLQueryItem(name: "schedule_category", value: schedule_category),
            URLQueryItem(name: "internship_info", value: internship_info),
            URLQueryItem(name: "corporate_info", value: corporate_info),
            URLQueryItem(name: "start_date", value: start_date),
            URLQueryItem(name: "end_date", value: end_date),
            URLQueryItem(name: "memo", value: memo)
        ]

        guard let url = urlComponents.url else {
            return
        }
    print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Schedule].self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    //スケジュールのデータを削除するメソッド
    func deleteScheduleInfoFromUserID(id: String, completion: @escaping ([Schedule]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
        urlComponents.path = "/schedule/delete.php"
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: id)
        ]

        guard let url = urlComponents.url else {
            return
        }
    print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Schedule].self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    /*-------------------------------------------------------------
     Internship Info
      - select
      - add
      - update
      - delete
     -------------------------------------------------------------*/
    //userIDをもとにそのユーザーが登録したインターンシップのデータを取得するメソッド
    func getInternshipInfoFromUserID(userID: String, completion: @escaping ([Internship_info]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
        urlComponents.path = "/internship_info/select.php"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_info", value: userID)
        ]

        guard let url = urlComponents.url else {
            return
        }
    print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Internship_info].self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    //インターンシップのデータを追加するメソッド
    func addInternshipInfoFromUserID(userID: String, corporate_info: String, start_date: String, end_date: String, memo: String, completion: @escaping ([Internship_info]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
        urlComponents.path = "/internship_info/add.php"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_info", value: userID),
            URLQueryItem(name: "corporate_info", value: corporate_info),
            URLQueryItem(name: "start_date", value: start_date),
            URLQueryItem(name: "end_date", value: end_date),
            URLQueryItem(name: "memo", value: memo)
        ]

        guard let url = urlComponents.url else {
            return
        }
    print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Internship_info].self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    //インターンシップのデータを編集するメソッド
    func editInternshipInfoFromUserID(id: String, userID: String, corporate_info: String, start_date: String, end_date: String, memo: String, completion: @escaping ([Internship_info]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
        urlComponents.path = "/internship_info/update.php"
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: id),
            URLQueryItem(name: "user_info", value: userID),
            URLQueryItem(name: "corporate_info", value: corporate_info),
            URLQueryItem(name: "start_date", value: start_date),
            URLQueryItem(name: "end_date", value: end_date),
            URLQueryItem(name: "memo", value: memo)
        ]

        guard let url = urlComponents.url else {
            return
        }
    print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Internship_info].self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    //インターンシップのデータを削除するメソッド
    func editInternshipInfoFromUserID(id: String, completion: @escaping ([Internship_info]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "job-app.st.ie.u-ryukyu.ac.jp"
        urlComponents.path = "/internship_info/delete.php"
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: id)
        ]

        guard let url = urlComponents.url else {
            return
        }
    print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Internship_info].self, from: data)
                    print("success")
                    print(decodedResponse)
                    completion(decodedResponse)
                } catch {
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
    
}

//以降データ永続化関連

//User情報をアプリ内に保存
func SaveUserData(_ user: User) {
    do {
        let encodedData = try JSONEncoder().encode(user)
        UserDefaults.standard.set(encodedData, forKey: "savedUser")
    } catch {
        print("Error encoding person: \(error)")
    }
}

//user情報をアプリ内から読み込み
func LoadUserData() -> User? {
    if let savedData = UserDefaults.standard.data(forKey: "savedUser") {
        do {
            let loadedPerson = try JSONDecoder().decode(User.self, from: savedData)
            return loadedPerson
        } catch {
            print("Error decoding person: \(error)")
        }
    }
    return nil
}

func SaveIndustryData(_ industry:[Industry]){
    do {
        let encodedData = try JSONEncoder().encode(industry)
        UserDefaults.standard.set(encodedData, forKey: "savedIndustry")
    } catch {
        print("Error encoding person: \(error)")
    }
}

func LoadIndustryData() -> [Industry] {
    if let savedData = UserDefaults.standard.data(forKey: "savedIndustry") {
        do {
            let loadedIndustry = try JSONDecoder().decode([Industry].self, from: savedData)
            return loadedIndustry
        } catch {
            print("Error decoding person: \(error)")
        }
    }
    let dummyindustry = [
        Industry(name:"未選択"),
        Industry(name:"プログラマー"),
        Industry(name: "WEBエンジニア"),
        Industry(name: "インフラエンジニア")
    ]
    
    return dummyindustry
}

func SaveOccupationData(_ occupation:[Occupation]){
    do {
        let encodedData = try JSONEncoder().encode(occupation)
        UserDefaults.standard.set(encodedData, forKey: "savedoccupation")
    } catch {
        print("Error encoding person: \(error)")
    }
}

func LoadOccupationData() -> [Occupation] {
    if let savedData = UserDefaults.standard.data(forKey: "savedoccupation") {
        do {
            let loadedOccupation = try JSONDecoder().decode([Occupation].self, from: savedData)
            return loadedOccupation
        } catch {
            print("Error decoding person: \(error)")
        }
    }
    let dummyoccupation = [
        Occupation(name:"未選択"),
        Occupation(name: "正社員"),
        Occupation(name:"契約社員"),
        Occupation(name:"パート")
    ]
    return dummyoccupation
}
