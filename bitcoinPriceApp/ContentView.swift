//
//  ContentView.swift
//  bitcoinPriceApp
//
//  Created by Emin Akyay on 2.10.2022.
//

import SwiftUI

struct ContentView: View {
    @State var anaModel : Json4Swift_Base?
    var body: some View {
        HStack{
            Image ("bb")
                .resizable()
                .frame(width: 150, height: 100, alignment: .center)
            VStack {
                Text("Bitcoin Dolar Değeri")
                    .padding()
                Text(anaModel?.bpi?.uSD?.rate ?? "Değer Alınamadı")
            }
            .padding()
        } .onAppear(perform: verileriGetir)
        
        
        
        
    }
    
    func verileriGetir() {
        let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
            guard let data = data else{return}
            
            if let decodedData = try?
                JSONDecoder()
                .decode(Json4Swift_Base.self, from: data){
                DispatchQueue.main.async {
                    self.anaModel = decodedData
                }
            }
        }
        .resume()
        
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}
