//
//  AddCompanyView.swift
//  job-hunting-support
//
//  Created by ibu.m ev on 2023/08/03.
//

import SwiftUI

//新規企業データの作成
struct AddCompanyView: View {
    
    //画面遷移
    @Environment(\.presentationMode) var presentationMode
    
    var userid: String //ユーザーID
    @Binding var companyList: [corporate_info] //企業リスト
    var industryList: [industry] //職種リスト
    var occupationList: [occupation] //業種リスト
    
    //日付関連
    let dateFormatter = DateFormatter()
    
    //各種パラメータの初期化
    init(userid: String,companyList: Binding<[corporate_info]>, industryList: [industry], occupationList: [occupation]) {
        self.userid = userid
        self.industryList = industryList
        self.occupationList = occupationList
        _companyList = companyList
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    //新規作成時の初期値
    @State private var newName = ""
    @State private var selectindustry: String = ""
    @State private var selectoccupation: String = ""
    @State private var newbusiness = ""
    @State private var selectionDate = Date()
    @State private var newEmployees = 0
    @State private var newcapital = 0
    @State private var newsales = 0
    @State private var newincome = 0
    @State private var newrepresentative = ""
    @State private var newlocation = ""
    @State private var newmemo = ""
    @State private var currentdate = Date()
    
    //キーボードの利用検知
    @FocusState  var isActive:Bool
    
    //ナビゲーションバーの戻るボタンを消すための定義
    @Environment(\.presentationMode) var presentaion
    
    //ScrollViewで指定した場所まで飛ぶための変数定義
    @State private var indexnum = 0
    
    var body: some View {
        ScrollViewReader{reader in
            ScrollView{
                //最初にカテゴリーから検索するのか新規作成するのか選択する部分
                Group{
                    Text("追加方法を選択")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .padding(.top, 20)
                    HStack{
                        Button(action: {
                            //ここにボタンを押したときの動作を記述
                            indexnum = 1
                            withAnimation (.easeInOut){
                                reader.scrollTo(indexnum, anchor: .top)
                            }
                        }){
                        Text("カテゴリー\nから検索")
                             .foregroundColor(Color.white)
                             .frame(width: 130, height: 60, alignment: .center)
                             .background(Color.green)
                             .cornerRadius(50)
                            /*
                            // 文字色をブルーに指定
                            .foregroundColor(.blue)
                            // フレームのサイズを指定
                            .frame(width: 130, height: 60, alignment: .center)
                            // 枠線で囲って文字を重ねる
                            .overlay(RoundedRectangle(cornerRadius: 20)
                            // 枠線の色をブルーに指定
                            .stroke(Color.blue, lineWidth: 2)
                            )
                             */
                        }
                        Button(action: {
                            //ここにボタンを押したときの動作を記述
                            indexnum = 2
                            withAnimation (.easeInOut){
                                reader.scrollTo(indexnum, anchor: .top)
                            }
                        }){
                        Text("新規作成")
                            .foregroundColor(Color.white)
                            .frame(width: 130, height: 60, alignment: .center)
                            .background(Color.pink)
                            .cornerRadius(50)
                        }
                    }
                }
                
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: .infinity, height: 0.5)
                    .padding(.vertical, 30)
                
                //カテゴリーから選択する部分
                Group{
                    Text("カテゴリーから選択").id(1)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                    VStack{
                        HStack{
                            Text("業種")
                                //.font(.title2)
                                .padding()
                            Section{
                                Picker(selection: $selectindustry, content: {
                                    ForEach(industryList) { industry in
                                        Text("\(industry.name)").tag(industry.id)
                                    }
                                }, label: { Text("業種") }).pickerStyle(MenuPickerStyle())
                            }.autocapitalization(.none)
                        }
                        HStack{
                            Text("職種")
                                //.font(.title2)
                                .padding()
                            Section{
                                Picker(selection: $selectoccupation, content: {
                                    ForEach(occupationList) { occupation in
                                        Text("\(occupation.name)").tag(occupation.id)
                                    }
                                }, label: { Text("職種") }).pickerStyle(MenuPickerStyle())
                            }.autocapitalization(.none)
                        }
                        Button(action: {
                            //ここにボタンを押したときの動作を記述
                        }){
                            HStack{
                                Text("検索")
                                Image(systemName: "magnifyingglass")
                            }
                            .foregroundColor(Color.white)
                            .frame(width: 130, height: 50, alignment: .center)
                            .background(Color.blue)
                            .cornerRadius(50)
                        }
                    }
                }
                
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: .infinity, height: 0.5)
                    .padding(.vertical, 30)
                
                //新規作成の部分
                Text("新規作成").id(2)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 15)
                HStack{
                    Text("企業名")
                        //.font(.title)
                        .padding()
                    TextField("株式会社タカアシガニ", text:$newName)
                        //.font(.title)
                        .focused($isActive)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("業種")
                        //.font(.title2)
                        .padding()
                    Section{
                        Picker(selection: $selectindustry, content: {
                            ForEach(industryList) { industry in
                                Text("\(industry.name)").tag(industry.id)
                            }
                        }, label: { Text("業種") }).pickerStyle(MenuPickerStyle())
                    }.autocapitalization(.none)
                }
                HStack{
                    Text("職種")
                        //.font(.title2)
                        .padding()
                    Section{
                        Picker(selection: $selectoccupation, content: {
                            ForEach(occupationList) { occupation in
                                Text("\(occupation.name)").tag(occupation.id)
                            }
                        }, label: { Text("職種") }).pickerStyle(MenuPickerStyle())
                    }.autocapitalization(.none)
                }
                Group{
                    HStack{
                        Text("事業内容")
                            //.font(.title2)
                            .padding()
                        TextField("事業内容を書いてください。", text:$newbusiness)
                            .focused($isActive)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                    }
                    HStack{
                        DatePicker("設立日", selection: $selectionDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                            //.font(.title2)
                            .padding()
                    }
                    HStack{
                        Text("従業員数")
                            //.font(.title2)
                            .padding()
                        TextField("従業員数", value:$newEmployees, format: .number)
                            .keyboardType(.numberPad)
                            .focused($isActive)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .autocapitalization(.none)
                    }
                    HStack{
                        Text("資本金")
                            //.font(.title2)
                            .padding()
                        TextField("資本金", value:$newcapital, format: .number)
                            .keyboardType(.numberPad)
                            .focused($isActive)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .autocapitalization(.none)
                    }
                    HStack{
                        Text("売上高")
                            //.font(.title2)
                            .padding()
                        TextField("売上高", value:$newsales, format: .number)
                            .keyboardType(.numberPad)
                            .focused($isActive)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .autocapitalization(.none)
                    }
                    HStack{
                        Text("営業利益")
                            //.font(.title2)
                            .padding()
                        TextField("営業利益", value:$newincome, format: .number)
                            .keyboardType(.numberPad)
                            .focused($isActive)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .autocapitalization(.none)
                    }
                    HStack{
                        Text("代表者")
                            //.font(.title2)
                            .padding()
                        TextField("山田 太郎", text:$newrepresentative)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .focused($isActive)
                            .padding()
                            .autocapitalization(.none)
                    }
                    HStack{
                        Text("所在地")
                            //.font(.title2)
                            .padding()
                        TextField("沖縄県中頭郡西原町字千原1番地", text:$newlocation)
                            .focused($isActive)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .autocapitalization(.none)
                    }
                    HStack{
                        Text("メモ")
                            //.font(.title2)
                            .padding()
                        TextField("メモ", text:$newmemo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .focused($isActive)
                            .padding()
                            .autocapitalization(.none)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("リストを追加")
        .navigationBarItems(trailing: Button("作成") {
            //新規企業データの作成
            companyList.append(corporate_info(user: userid, name: newName, Industry: selectindustry, Occupation: selectoccupation, business: newbusiness, establishment: dateFormatter.string(from: selectionDate), employees: String(newEmployees), capital: String(newcapital), sales: String(newsales), operating_income: String(newincome), representative: newrepresentative, location: newlocation, registration: dateFormatter.string(from: currentdate), memo: newmemo))
            
            //企業データ入力部分の初期化
            newName = ""
            newbusiness = ""
            selectionDate = Date()
            newEmployees = 0
            newcapital = 0
            newsales = 0
            newincome = 0
            newrepresentative = ""
            newlocation = ""
            newmemo = ""
            currentdate = Date()
            
            //企業リスト画面に戻る
            presentationMode.wrappedValue.dismiss()
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                  Button(action: { presentaion.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.backward")
                }
            }
            //キーボードを閉じるボタン
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()         // 右寄せにする
                Button("閉じる") {
                    isActive = false  //  フォーカスを外す
                }
            }
        }
        Spacer()
    }
}
