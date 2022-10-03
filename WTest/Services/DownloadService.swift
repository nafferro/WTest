//
//  DataService.swift
//  WTest
//
//  Created by Nuno Ferro on 28/09/2022.
//

import Foundation
import Combine
import CSV

let ZIPCODES_ADDRESS = "https://raw.githubusercontent.com/centraldedados/codigos_postais/master/data/codigos_postais.csv"

struct DataService {
    let processingDataState = PassthroughSubject<Bool,Never>()
    let filename = "zipcodes.csv"
    func setup() {
        if !UserDefaults.standard.bool(forKey: "fileLoaded") {
            downloadZipCodes()
        }
        else if !UserDefaults.standard.bool(forKey: "databaseLoaded") {
            processData()
        }
    }
    
    private func downloadZipCodes () {
        let urlString = ZIPCODES_ADDRESS
        if let zipCodesUrl = URL(string: urlString) {
            URLSession.shared.downloadTask(with: zipCodesUrl) { (tempFileUrl, response, error) in
                if let csvTempFileUrl = tempFileUrl {
                    do {
                        let savedURL = getDocumentsDirectory().appendingPathComponent(filename)
                        try FileManager.default.moveItem(at: csvTempFileUrl, to: savedURL)
                        UserDefaults.standard.set(true, forKey: "fileLoaded")
                        processData() 
                    }
                    catch let error {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func processData() {
        LocalStorage().deleteData()
        let savedURL = getDocumentsDirectory().appendingPathComponent(filename)
        let stream = InputStream(fileAtPath: savedURL.path)!
        let csv = try! CSVReader(stream: stream, hasHeaderRow: true)
        var processed = 0
        while let row = csv.next() {
            let tempZip = ZipcodeModel()
            tempZip.zipcode = "\(row[14])-\(row[15])"
            tempZip.city = row[3]
            processed = processed + 1
            LocalStorage().saveZipCodeData(zipcodeModel: tempZip)
            print("processed: ", processed)
        }
        processingDataState.send(completion: .finished)
    }
}
