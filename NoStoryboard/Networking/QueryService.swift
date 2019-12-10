//
//  QueryService.swift
//  NoStoryboard
//
//  Created by Kalyan Mannem on 10/12/19.
//  Copyright © 2019 CompIndia. All rights reserved.
//

import Foundation

class QueryService
{

    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    var title: String?
    var rows: [Row]?

    typealias QueryResult = ([Row]?, String?, String) -> Void
    

    func getResults(completion: @escaping QueryResult)
    {
        
        dataTask?.cancel()
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        else
        {
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer
            {
                self?.dataTask = nil
            }
            
            if let error = error
            {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                self?.updateResults(data)
                
                DispatchQueue.main.async
                {
                    completion(self?.rows, self?.title, self?.errorMessage ?? "")
                }
            }
        }
        dataTask?.resume()
        
    }
    

    private func updateResults(_ data: Data)
    {
        rows = nil

        if let values = try? ResponseModel.init(data: data)
        {
            rows = values.rows
            title = values.title
        }
        else
        {
            print("else")
        }
        

    }
}

