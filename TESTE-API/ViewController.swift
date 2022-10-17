//
//  ViewController.swift
//  TESTE-API
//
//  Created by Nillia Sousa on 11/10/22.
//

import UIKit

//"id"
//"images"

import Foundation

//API

// MARK: - Card
struct Data: Codable {
    let data: [Card]
}

// MARK: - Datum
struct Card: Codable {
    let id, name: String
    let images: Images
}

// MARK: - Images
struct Images: Codable {
    let large: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequest()
    }
    
    private func makeRequest() {
        let url = URL(string: "https://api.pokemontcg.io/v2/cards")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            
            guard let responseData = data else { return }
            
            do {
                let cards = try JSONDecoder().decode(Data.self, from: responseData)
                print("obects cards:\(cards)")
            } catch let error {
                    
                print("error: \(error)")
                
            }

        }
        task.resume()
    }


}

