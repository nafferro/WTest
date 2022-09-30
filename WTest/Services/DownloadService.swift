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
        
        if LocalStorage().loadSettings().fileLoaded == false {
            downloadZipCodes()
        }
        
        else if LocalStorage().loadSettings().databaseLoaded == false {
            processData()
        }
    }
    
    private func downloadZipCodes () {
        processingDataState.send(false)
        let urlString = ZIPCODES_ADDRESS
        if let zipCodesUrl = URL(string: urlString) {
            URLSession.shared.downloadTask(with: zipCodesUrl) { (tempFileUrl, response, error) in
                if let csvTempFileUrl = tempFileUrl {
                    do {
                        let savedURL = getDocumentsDirectory().appendingPathComponent(filename)
                        try FileManager.default.moveItem(at: csvTempFileUrl, to: savedURL)
                        let tempSettings = SettingsModel()
                        tempSettings.fileLoaded = true
                        LocalStorage().saveSettings(settingsModel: tempSettings)
                        processData()
                    } catch {
                        print("Error: ", error)
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
        processingDataState.send(true)
        LocalStorage().deleteData()
        let savedURL = getDocumentsDirectory().appendingPathComponent(filename)
        let stream = InputStream(fileAtPath: savedURL.path)!
        let csv = try! CSVReader(stream: stream, hasHeaderRow: true)
        var processed = 0
        while let row = csv.next() {
            let tempZip = ZipcodeModel()
            tempZip.zipcode = row[14]
            tempZip.zipcodeExtension = row[15]
            tempZip.city = row[3]
            processed = processed + 1
            LocalStorage().saveZipCodeData(zipcodeModel: tempZip)
            print(processed)
        }
        
        let tempSettings = SettingsModel()
        tempSettings.databaseLoaded = true
        LocalStorage().saveSettings(settingsModel: tempSettings)
        processingDataState.send(completion: .finished)
        
    }
}
