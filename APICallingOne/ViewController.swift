//
//  ViewController.swift
//  APICallingOne
//
//  Created by Lalaiya Sahil on 01/03/23.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    var arrWelcome: [Search] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       setup()
    }
    
    private func setup(){
           getCustomerInfo()
    }
    
    func getCustomerInfo(){
        AF.request("http://universities.hipolabs.com/search?country=United+States", method: .get).responseData {  response in
            debugPrint("response\(response)")
            debugPrint(response.response?.statusCode )
            if response.response?.statusCode == 200{
                guard let apiData = response.data else { return }
                do{
                    let welcome = try JSONDecoder().decode([Search].self, from: apiData)
                    print(welcome)
                    self.arrWelcome = welcome
                }catch{
                    print(error)
                }
            }else{
                print("Something is wrong")
            }
        }
    }
}
struct Search: Decodable {
    let alphaTwoCode: AlphaTwoCode
    let webPages: [String]
    let stateProvince: String?
    let name: String
    let domains: [String]
    let country: Country

    enum CodingKeys: String, CodingKey {
        case alphaTwoCode = "alpha_two_code"
        case webPages = "web_pages"
        case stateProvince = "state-province"
        case name, domains, country
    }
}

enum AlphaTwoCode: String, Codable {
    case us = "US"
}

enum Country: String, Codable {
    case unitedStates = "United States"
}

