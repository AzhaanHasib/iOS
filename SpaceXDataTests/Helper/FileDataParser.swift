//
//  FileDataParser.swift
//  SpaceXData
//
//  Created by Azhaan Hasib on 20/02/22.
//

import Foundation


class FileDataParser {
    
    static let shared = FileDataParser()
}


extension FileDataParser {
    
    func load<T: Decodable>(_ filename: String, bundle: Bundle?) -> T? {
        let data: Data
        guard let file = bundle?.url(forResource: filename, withExtension: "json") else {
            return nil
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            return nil
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            return nil
        }
    }
    
}
