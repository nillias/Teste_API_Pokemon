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

class API {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        makeRequest()
//    }
    
    static func makeRequest() {
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

class ViewController: UIViewController {
    
    var cardPokemonImage: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(cardPokemonImage)
        cardPokemonImage.translatesAutoresizingMaskIntoConstraints = false
        cardPokemonImage.image = UIImage(named: "image1")
        
        NSLayoutConstraint.activate([
            cardPokemonImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardPokemonImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
        API.makeRequest()
        let urlFake = "https://images.pokemontcg.io/pl3/1.png"
        imageRequest(url: urlFake){ image in
            DispatchQueue.main.async {
                self.cardPokemonImage.image = image
            }
            
        }
 
    }
    
    func imageRequest(url: String, completion: @escaping(UIImage)->()) {
        guard let urlImage: URL = URL(string: url) else {return}
        URLSession.shared.dataTask(with: urlImage) { (data, response, error) in
            
            guard let responseData = data else {return}
            
            guard let image =  UIImage(data: responseData) else {return}
            completion(image)
        }.resume()
    }
}
